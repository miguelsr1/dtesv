package sv.com.jsoft.stdte.repository;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.networknt.schema.JsonSchema;
import com.networknt.schema.JsonSchemaFactory;
import com.networknt.schema.SpecVersion;
import com.networknt.schema.ValidationMessage;
import sv.com.jsoft.stdte.dto.GenericResponse;
import sv.com.jsoft.stdte.dto.LoginDto;
import sv.com.jsoft.stdte.model.json.GeneracionJson;
import sv.com.jsoft.stdte.persistence.Buzoncsv;
import sv.com.jsoft.stdte.persistence.Factura;
import sv.com.jsoft.stdte.persistence.ParametrosMh;
import sv.com.jsoft.stdte.persistence.TiposComprobantes;
import sv.com.jsoft.stdte.utils.ViewUtils;
import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.ejb.Stateless;
import javax.ejb.TransactionManagement;
import javax.ejb.TransactionManagementType;
import javax.persistence.*;
import javax.transaction.Transactional;
import java.io.*;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.URLEncoder;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.logging.Level;
import java.util.stream.Collectors;
import lombok.extern.slf4j.Slf4j;
import sv.com.jsoft.stdte.persistence.Contribuyentes;

@Stateless
@TransactionManagement(TransactionManagementType.CONTAINER)
@Slf4j
public class FacturaService {

    public static final String SUFFIX = ".json";
    private static final ResourceBundle RESOURCE_BUNDLE = ResourceBundle.getBundle("bundle");

    @PersistenceContext
    private EntityManager entityManager;

    @EJB
    AppService service;

    @PostConstruct
    public void init() {
        java.util.logging.Logger.getLogger("org.hibernate").setLevel(Level.WARNING);
    }
    
    public Contribuyentes findReceptoNull(){
        return entityManager.find(Contribuyentes.class, 5);
    }

    @Transactional
    public GenericResponse procesoEmitirDocumento(List<Buzoncsv> buzoncsvList, String app,
            LoginDto login, Date dateI, Date dateF,
            String schemaName, Integer fesmhVersion,
            String tipoDocumento, String observaciones) {
        GenericResponse response = new GenericResponse();
        Factura factura;
        String email;

        try {
            Query query = entityManager.createNativeQuery("SELECT fun_genera_numero_interno(:PAPP, :PUSER)  FROM dual");

            query.setParameter("PAPP", app);
            query.setParameter("PUSER", login.getUsuario());

            Integer result = (Integer) query.getSingleResult();
            log.info("resultado fun_genera_numero_interno: " + result);
            buzoncsvList.forEach(c -> c.setCodFactura(String.valueOf(result)));
            log.info("buzoncsv: " + Arrays.toString(buzoncsvList.toArray()));
            //Persist on BuzonCsv
            buzoncsvList.forEach(entityManager::persist);

            //Get email to send
            email = buzoncsvList.get(0).getCorreo();

            //pro_carga_facturas
            try {
                StoredProcedureQuery storedProcedureQuery = entityManager.createStoredProcedureQuery("pro_carga_facturas")
                        .registerStoredProcedureParameter(1, String.class, ParameterMode.IN)
                        .registerStoredProcedureParameter(2, String.class, ParameterMode.IN)
                        .registerStoredProcedureParameter(3, Integer.class, ParameterMode.OUT)
                        .registerStoredProcedureParameter(4, Integer.class, ParameterMode.OUT)
                        .registerStoredProcedureParameter(5, String.class, ParameterMode.OUT)
                        .setParameter(1, app)
                        .setParameter(2, login.getIdUsuario().toString());

                storedProcedureQuery.execute();
                response.setIdFactura((Integer) storedProcedureQuery.getOutputParameterValue(3));
                response.setVal((Integer) storedProcedureQuery.getOutputParameterValue(4));
                response.setMensaje((String) storedProcedureQuery.getOutputParameterValue(5));
                log.info("resultado: " + response);
            } catch (Exception e) {
                log.error("Error en pro_carga_factura: ", e);
                response.setMensaje("Error en proceso pro_carga_factura, intente nuevamente");
                response.setVal(1);
                return response;
            }

            if (response.getVal() == 0 && response.getIdFactura() > 0) {
                try {
                    log.info("Update periodo en Factura : " + response.getIdFactura() + " : "
                            + ViewUtils.formatoFecha(dateI) + " " + ViewUtils.formatoFecha(dateF));
                    factura = entityManager.createQuery("from Factura f where f.facId = :nroFact", Factura.class)
                            .setParameter("nroFact", response.getIdFactura())
                            .getSingleResult();
                    factura.setFacFechaIniPeriodo(dateI);
                    factura.setFacFechaFinPeriodo(dateF);
                    if (tipoDocumento.matches("07")) {
                        factura.setFacObservaciones(observaciones);
                    } else {
                        observaciones = "Fecha del Periodo del " + ViewUtils.formatoFecha(dateI) + " al " + ViewUtils.formatoFecha(dateF);
                        factura.setFacObservaciones(observaciones);
                    }
                    entityManager.merge(factura);

                } catch (Exception e) {
                    log.error("error updating factura periodo " + e);
                    response.setVal(1);
                    response.setMensaje("Error ingresando periodo de factura, intente nuevamente ");
                    return response;
                }
                try {
                    //pmId = 1 -> Produccion, pmId = 2 -> Test Hacienda
                    ParametrosMh pm = entityManager
                            .createQuery("from ParametrosMh p where p.pmJsonFirmadorNit = :nitEmisor and p.pmId = 1", ParametrosMh.class)
                            .setParameter("nitEmisor", factura.getFacNitEmisor())
                            .getSingleResult();
                    log.info("parametros mh: " + pm);

                    TiposComprobantes tipoComp = entityManager
                            .createQuery("from TiposComprobantes t where t.tcpIdtipcom =:id", TiposComprobantes.class)
                            .setParameter("id", factura.getFacTipoComprobante())
                            .getSingleResult();

                    log.info("procesando factura nro: " + factura.getFacNroFactura() + " , "
                            + "tipo: " + factura.getFacTipoComprobante()
                            + " - " + tipoComp.getTcpComprobante() + " , idFactura: " + factura.getFacId());

                    GeneracionJson genJson = service.callGenerateJson(tipoComp.getTcpComprobante(), String.valueOf(factura.getFacId()));

                    if (genJson == null) {
                        log.info("Error en callGenerateJson ");
                        response.setVal(1);
                        response.setMensaje("Error en callGenerateJson");
                        return response;
                    }
                    log.info("json db: " + genJson);

                    GenericResponse validJson = validarSchema(genJson.getJson(), schemaName);
                    if (validJson.getVal() != 0) {
                        response.setVal(1);
                        response.setMensaje(validJson.getMensaje());
                        return response;
                    }
                    JsonObject jsonObject = getFirmaDocu(genJson.getJson(), pm);
                    if (jsonObject == null) {
                        response.setVal(1);
                        response.setMensaje("Error al intentar obtener firma documento , intente nuevamente");

                        return response;
                    }

                    if (jsonObject.get("status").getAsString().equals("OK")) {
                        String token;
                        JsonObject jsonAuth = getAuthorization(pm);
                        if (!jsonAuth.get("status").getAsString().equals("OK")) {
                            response.setVal(1);
                            response.setMensaje("Error al obtener autorización, intente nuevamente");

                            return response;
                        }

                        token = jsonAuth.getAsJsonObject("body").get("token").getAsString();
                        String uuid = genJson.getCodigoGeneracion();
                        JsonObject jsonFromMh = getProcesarMh(jsonObject.get("body"), factura.getFacTipoComprobante(), uuid, token, pm);
                        if (jsonFromMh == null || jsonFromMh.get("estado").getAsString() == null) {
                            response.setVal(1);
                            response.setMensaje("Error al enviar petición a MH, intente nuevamente");

                            return response;
                        }

                        String clasMsg = jsonFromMh.get("clasificaMsg").getAsString();
                        switch (clasMsg) {
                            case "10":
                                if (jsonFromMh.get("codigoMsg").getAsString().equals("001")
                                        || jsonFromMh.get("codigoMsg").getAsString().equals("002")) {
                                    response.setVal(0);
                                    response.setMensaje(jsonFromMh.get("estado").getAsString().concat(
                                            jsonFromMh.get("descripcionMsg").getAsString() != null
                                            ? " - " + jsonFromMh.get("descripcionMsg").getAsString() : " - SIN OBSERVACIONES"));
                                    String finProcesamiento = jsonFromMh.get("fhProcesamiento").getAsString();

                                    DateTimeFormatter dtf = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm:ss");
                                    LocalDateTime dateTime = LocalDateTime.parse(finProcesamiento, dtf);

                                    DateTimeFormatter outputFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
                                    String outputDateToString = dateTime.format(outputFormatter);

                                    String link = pm.getPmQrLink() + pm.getPmJsonFesvMhAmbiente() + "&codGen="
                                            + genJson.getCodigoGeneracion() + "&fechaEmi=" + outputDateToString;

                                    service.PersistMHResponse(
                                            String.valueOf(factura.getFacId()),
                                            jsonFromMh.get("codigoMsg").getAsString().equals("001") ? jsonFromMh.get("estado").getAsString() : "OBSERVADO",
                                            jsonFromMh.get("selloRecibido").getAsString(),
                                            genJson.getCodigoGeneracion(),
                                            genJson.getJson(),
                                            link, finProcesamiento);

                                    if (jsonFromMh.get("codigoMsg").getAsString().equals("001")) {
                                        response.setMensaje(response.getMensaje() );
                                        GenericResponse resMail = sendMail(email,
                                                String.valueOf(factura.getFacId()),
                                                genJson.getJson(),
                                                jsonFromMh.get("codigoGeneracion").getAsString(),
                                                tipoDocumento,
                                                observaciones);
                                        
                                        if (resMail.getVal() == 0) {
                                            response.setMensaje(response.getMensaje() + " " + resMail.getMensaje());
                                        } else {
                                            response.setMensaje(resMail.getMensaje());
                                        }
                                    } else if (jsonFromMh.get("codigoMsg").getAsString().equals("002")) {
                                        response.setMensaje(response.getMensaje().concat(", CONTROL: " + factura.getFacNumeroDeControl()));
                                    }
                                }
                                break;
                            case "11":
                            case "12":
                            case "13":
                            case "14":
                            case "15":
                            case "16":
                            case "17":
                            case "18":
                            case "19":
                            case "20":
                            case "21":
                            case "98":
                            case "99":
                                response.setVal(1);
                                response.setMensaje(jsonFromMh.get("estado").getAsString()
                                        + " - " + jsonFromMh.get("codigoMsg").getAsString()
                                        + " - " + jsonFromMh.get("descripcionMsg").getAsString());
                                return response;
                        }
                    }
                } catch (Exception e) {
                    response.setVal(1);
                    response.setMensaje(e.getMessage());
                    return response;
                }
            }
        } catch (Exception e) {
            log.error("ERROR en ProcesoEmitirDocumento: " + e);
            response.setVal(1);
            response.setMensaje(e.getMessage());
            return response;
        }
        return response;
    }

    private GenericResponse validarSchema(JsonObject jsonDte, String schemaName) {
        GenericResponse respuesta = new GenericResponse();
        String propertyName = System.getProperty("os.name").toUpperCase().contains("WINDOWS") ? "FOLDER_JSON_FILES_WINDOWS" : "FOLDER_JSON_FILES_LINUX";
        String jsonPath = ResourceBundle.getBundle("bundle").getString(propertyName).replace("${user.name}", System.getProperty("user.name"));
        log.info("jsonPath " + jsonPath + " schema: " + schemaName);
        ObjectMapper objectMapper = new ObjectMapper();
        JsonSchemaFactory schemaFactory = JsonSchemaFactory.getInstance(SpecVersion.VersionFlag.V7);

        try (FileWriter fw = new FileWriter(jsonPath + File.separator + "dteJson" + SUFFIX, StandardCharsets.UTF_8)) {
            fw.write(jsonDte.toString());
            fw.flush();
            fw.close();
        } catch (IOException e) {
            log.error("ERROR RECUPERANDO SCHEMA JSON", e);
            respuesta.setVal(1);
            respuesta.setMensaje(e.getMessage());
            return respuesta;
        }

        try (InputStream schemaStream = new FileInputStream(jsonPath + File.separator + schemaName); InputStream jsonStream = new FileInputStream(jsonPath + File.separator + "dteJson.json");) {
            jsonStreamToJsonNode(respuesta, objectMapper, schemaFactory, schemaStream, jsonStream);
        } catch (Exception e) {
            log.error("ERROR SCHEMA JSON", e);
            respuesta.setVal(1);
            respuesta.setMensaje("Error " + e.getMessage());
        }
        return respuesta;
    }

    public static void jsonStreamToJsonNode(GenericResponse respuesta, ObjectMapper objectMapper, JsonSchemaFactory schemaFactory, InputStream schemaStream, InputStream jsonStream) throws IOException {
        JsonNode jsonNode = objectMapper.readTree(jsonStream);
        JsonSchema schema = schemaFactory.getSchema(schemaStream);
        Set<ValidationMessage> validationResult = schema.validate(jsonNode);

        if (validationResult.isEmpty()) {
            respuesta.setVal(0);
            respuesta.setMensaje("no validation errors :-)");
            log.info("no validation errors :-)");
        } else {
            respuesta.setVal(1);
            final StringBuilder builder = new StringBuilder();
            validationResult.forEach(vm
                    -> builder.append(vm.getMessage()));

            respuesta.setMensaje(builder.toString());
        }
    }

    private JsonObject getFirmaDocu(JsonObject jsonDte, ParametrosMh pmh) {
        JsonObject signedJson = null;
        JsonObject jsonFirmador = new JsonObject();
        Gson parser = new Gson();

        jsonFirmador.addProperty("nit", pmh.getPmJsonFirmadorNit());
        jsonFirmador.addProperty("activo", true);
        jsonFirmador.addProperty("passwordPri", pmh.getPmJsonFirmadorPass());
        jsonFirmador.add("dteJson", jsonDte);

        try {
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(new URI(pmh.getPmJsonFirmadorUrl()))
                    .headers("Content-Type", "application/json")
                    .POST(HttpRequest.BodyPublishers
                            .ofString(jsonFirmador.toString()))
                    .build();

            HttpResponse<String> response = HttpClient.newHttpClient()
                    .send(request, HttpResponse.BodyHandlers.ofString());
            log.info("respuesta firmardocumento MH" + response.body());
            signedJson = parser.fromJson(response.body(), JsonObject.class);
            if (signedJson.get("status").getAsString().matches("OK")) {
                log.info("jsonFirmado: " + signedJson.get("body"));
            } else {
                log.error("error obteniendo jsonFirmado" + signedJson.get("status").getAsString() + ", "
                        + signedJson.get("body"));
            }
        } catch (URISyntaxException | IOException | InterruptedException e) {
            log.error("error en getFirmaDocumento", e);
        }

        return signedJson;
    }

    private JsonObject getAuthorization(ParametrosMh pmh) {
        JsonObject respuesta = new JsonObject();
        try {
            Map<String, String> params = new HashMap<>();
            params.put("user", pmh.getPmJsonAuthUser());
            params.put("pwd", pmh.getPmJsonAuthPass());

            String form = params.entrySet()
                    .stream()
                    .map(e -> e.getKey() + "=" + URLEncoder.encode(e.getValue(), StandardCharsets.UTF_8))
                    .collect(Collectors.joining("&"));

            HttpRequest request = HttpRequest.newBuilder()
                    .uri(new URI(pmh.getPmJsonAuthUrl()))
                    .headers("Content-Type", "application/x-www-form-urlencoded")
                    .POST(HttpRequest.BodyPublishers.ofString(form))
                    .build();

            HttpResponse<String> response = HttpClient.newHttpClient()
                    .send(request, HttpResponse.BodyHandlers.ofString());

            respuesta = JsonParser.parseString(response.body()).getAsJsonObject();

        } catch (URISyntaxException | IOException | InterruptedException ex) {
            log.error("error en getAuthorization", ex);
        }

        return respuesta;
    }

    private JsonObject getProcesarMh(JsonElement jsonFirmado, String tipoDoc, String uuid, String token, ParametrosMh pmh) {
        JsonObject response = new JsonObject();
        JsonObject jsonRequest = new JsonObject();
        try {
            TiposComprobantes version = entityManager
                    .createQuery("from TiposComprobantes tc where tc.tcpIdtipcom = :tipoComp", TiposComprobantes.class)
                    .setParameter("tipoComp", tipoDoc).getSingleResult();

            jsonRequest.addProperty("version", version.getTcpVersion());
            jsonRequest.addProperty("ambiente", pmh.getPmJsonFesvMhAmbiente());
            jsonRequest.addProperty("idEnvio", pmh.getPmJsonFesvMhIdenvio());
            jsonRequest.addProperty("tipoDte", tipoDoc);
            jsonRequest.addProperty("codigoGeneracion", uuid);
            jsonRequest.add("documento", jsonFirmado);

            log.info("Encabezado version: " + version.getTcpVersion() + ", ambiente: " + pmh.getPmJsonFesvMhAmbiente() + ", idEnvio: " + pmh.getPmJsonFesvMhIdenvio() + ", tipoDte: " + tipoDoc
                    + ", codigoGeneracion: " + uuid + ", documento: " + jsonFirmado.toString());

            HttpRequest request = HttpRequest.newBuilder()
                    .uri(new URI(pmh.getPmJsonFesvMhUrl()))
                    .headers("Content-Type", "application/json")
                    .headers("Authorization", token)
                    .POST(HttpRequest.BodyPublishers.ofString(new Gson().toJson(jsonRequest)))
                    .build();

            HttpResponse<String> resp = HttpClient.newHttpClient()
                    .send(request, HttpResponse.BodyHandlers.ofString());

            response = JsonParser.parseString(resp.body()).getAsJsonObject();
            log.info("response from mh: " + response);
        } catch (URISyntaxException e) {
            log.error("error getProcesarMh" + e.getMessage());
            return null;
        } catch (IOException | InterruptedException e) {
            throw new RuntimeException(e);
        }
        return response;
    }

    private GenericResponse sendMail(String mail, String nroFactura, JsonObject jsonObject, String nameJsonFile, String tipoDocumento, String observaciones) {
        String path;
        GenericResponse response = new GenericResponse();
        if (System.getProperty("os.name").toUpperCase().contains("WINDOWS")) {
            path = RESOURCE_BUNDLE.getString("PATH_REPORT_WINDOWS");
        } else {
            path = RESOURCE_BUNDLE.getString("PATH_REPORT_LINUX");
        }
        path = path.replace("SYSTEM_USER", System.getProperty("user.name"));
        log.info("report path: " + path);
        boolean sent = service.sendMail(mail, nroFactura, path, jsonObject, nameJsonFile, observaciones, tipoDocumento);
        if (sent) {
            Factura factura = service.recuperarFacturaById(Integer.valueOf(nroFactura));
            response.setVal(0);
            response.setMensaje("SE HA ENVIADO DOCUMENTO EMITIDO A: " + mail + ", CONTROL: " + factura.getFacNumeroDeControl());
            log.info("correo enviado a: " + mail);
        } else {
            response.setVal(1);
            response.setMensaje("FALLÓ EL ENVÍO DE DOCUMENTO EMITIDO A: " + mail);
            log.error("Falló envío de correo");
        }
        return response;
    }

}
