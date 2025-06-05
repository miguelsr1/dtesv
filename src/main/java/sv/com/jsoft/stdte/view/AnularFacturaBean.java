package sv.com.jsoft.stdte.view;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.networknt.schema.JsonSchemaFactory;
import com.networknt.schema.SpecVersion;
import lombok.Getter;
import lombok.Setter;
import org.primefaces.PrimeFaces;
import org.primefaces.event.SelectEvent;
import sv.com.jsoft.stdte.dto.GenericResponse;
import sv.com.jsoft.stdte.persistence.BitacoraDeclaracionHacienda;
import sv.com.jsoft.stdte.persistence.CatalogoTipoInvalidacion;
import sv.com.jsoft.stdte.persistence.Factura;
import sv.com.jsoft.stdte.persistence.ParametrosMh;
import sv.com.jsoft.stdte.repository.AppService;
import sv.com.jsoft.stdte.repository.BitacoraService;
import sv.com.jsoft.stdte.repository.FacturaService;
import sv.com.jsoft.stdte.utils.ViewUtils;

import javax.annotation.PostConstruct;
import javax.faces.view.ViewScoped;
import javax.inject.Inject;
import javax.inject.Named;
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
import java.util.stream.Collectors;
import lombok.extern.slf4j.Slf4j;

@ViewScoped
@Named("anular")
@Slf4j
public class AnularFacturaBean implements Serializable {

    private static final String SUFFIX = ".json";

    @Inject
    AppService service;
    @Inject
    BitacoraService bservice;
    @Inject
    LoginBean login;

    @Getter
    @Setter
    private boolean continuar = Boolean.FALSE;

    @Getter
    @Setter
    private String codigoGen, tipoAnulacion, motivoAnulacion, idFactura, mensaje;

    @Getter
    @Setter
    private List<CatalogoTipoInvalidacion> tipoInvalidacionList;

    @Getter
    @Setter
    private List<BitacoraDeclaracionHacienda> docEmitidosList;

    @Getter
    @Setter
    private BitacoraDeclaracionHacienda selectedFactura;

    @Getter
    @Setter
    private ParametrosMh pmh;
    
    @Getter
    @Setter
    private String nombreRes;
    @Getter
    @Setter
    private String tipoDocRes;
    @Getter
    @Setter
    private String numDocRes;
    
    @Getter
    @Setter
    private String nombreSol;
    @Getter
    @Setter
    private String tipoDocSol;
    @Getter
    @Setter
    private String numDocSol;

    @PostConstruct
    public void init() {
        tipoInvalidacionList = service.findAllTiposInvalidacion();
    }

    public void continuarListener() {
        continuar = Boolean.TRUE;
        PrimeFaces.current().ajax().update("frmAnular");
    }

    public List<String> completeText(String query) {
        String queryLowerCase = query.toLowerCase();
        List<String> codGenList = new ArrayList<>();
        docEmitidosList = bservice.findLikeByCodGeneracion(query, login.getUsuario(), login.getLogin().getIdEmpresa());
        for (BitacoraDeclaracionHacienda bdh : docEmitidosList) {
            codGenList.add(bdh.getCodigoGeneracion());
        }
        return codGenList.stream().filter(t -> t.toLowerCase().startsWith(queryLowerCase)).collect(Collectors.toList());
    }

    public void onRowSelect(SelectEvent<BitacoraDeclaracionHacienda> event) {
        log.info("Factura Seleccionada " + event.getObject().getIdFac());
        if (codigoGen != null) {
            if (event.getObject().getCodigoGeneracion().matches(codigoGen)) {
                ViewUtils.showMessageError("DEBE SELECCIONAR UNA FACTURA DIFERENTE A LA QUE DESEA ANULAR");
            }
        }
    }

    public String ingresarDatosListener() {
        login.setOpcionSeleccionada("/procesos/ingresoDatos.xhtml");
        return "index?faces-redirect=true";
    }

    public void enviarAnulacion() {
        if (codigoGen != null) {
            if (!tipoAnulacion.matches("2")) {
                if (selectedFactura.getCodigoGeneracion().matches(codigoGen)) {
                    ViewUtils.showMessageError("DEBE SELECCIONAR UNA FACTURA DIFERENTE A LA QUE DESEA ANULAR");
                }
            } else {
                Integer codFactPrevia;
                codFactPrevia = bservice.findIdFacturaByCodGeneracion(codigoGen, login.getUsuario());
                if (codFactPrevia > 0) {
                    GenericResponse resp = service.insertAnulacion(motivoAnulacion, codFactPrevia, Integer.parseInt(tipoAnulacion), tipoAnulacion.matches("2") ? null : selectedFactura.getCodigoGeneracion(), login,
                            nombreRes, tipoDocRes, numDocRes, nombreSol, tipoDocSol, numDocSol);
                    if (resp.getVal() == 0) {
                        log.info("parametros: TipoFact: " + "ANU" + " IdFactura: " + codFactPrevia);
                        JsonObject jsonToInvalidate = service.getJsonToInvalidate("ANU", String.valueOf(codFactPrevia), login.getLogin().getIdEmpresa());
                        if (jsonToInvalidate != null) {
                            GenericResponse valido = validarSchema(jsonToInvalidate);
                            if (valido.getVal() == 0) {
                                String codigoGeneracion = jsonToInvalidate.getAsJsonObject("identificacion").get("codigoGeneracion").getAsString(); //CODIGO DE PETICION ANULACION DE fun_retorna_json
                                Factura factura;
                                if (tipoAnulacion.matches("2")) {
                                    factura = service.searchFacturaById(codFactPrevia);
                                } else {
                                    factura = service.searchFacturaById(selectedFactura.getIdFac());
                                }
                                pmh = service.findParametrosByNitEmisor(factura.getFacNitEmisor());
                                JsonObject jsonObject = getFirmaDocumento(jsonToInvalidate);
                                if (jsonObject != null) {
                                    if (jsonObject.get("status").getAsString().equals("OK")) {
                                        String token;
                                        JsonObject jsonAuth = getAuth();
                                        if (jsonAuth.get("status").getAsString().equals("OK")) {
                                            token = jsonAuth.getAsJsonObject("body").get("token").getAsString();
                                            JsonObject jsonFromMh = getProcesarAnulacion(jsonObject.get("body"), token);
                                            if (jsonFromMh != null && jsonFromMh.get("estado").getAsString() != null) {
                                                if (jsonFromMh.get("estado").getAsString().equalsIgnoreCase("PROCESADO")) {
                                                    String finProcesamiento = jsonFromMh.get("fhProcesamiento").getAsString();

                                                    DateTimeFormatter dtf = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm:ss");
                                                    LocalDateTime dateTime = LocalDateTime.parse(finProcesamiento, dtf);

                                                    DateTimeFormatter outputFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
                                                    String outputDateToString = dateTime.format(outputFormatter);

                                                    String link = pmh.getPmQrLink() + pmh.getPmJsonFesvMhAmbiente() + "&codGen=" + codigoGeneracion + "&fechaEmi=" + outputDateToString;
                                                    GenericResponse response = service.PersistMHResponse(String.valueOf(codFactPrevia), //ID DEBE SER DE FACTURA ANTERIOR
                                                            "ANULADA", //ESTADO DEBE SER ANULADA
                                                            jsonFromMh.get("selloRecibido").getAsString(), codigoGeneracion,//CODIGO GENERACION DE PETICION DE ANULACION
                                                            jsonToInvalidate,//JSON ANULACION
                                                            link, finProcesamiento);
                                                    if (response.getVal() == 0) {
                                                        confirmDialog();
                                                    }
                                                } else {
                                                    ViewUtils.showMessageError("FALLO AL INTENTAR PROCESAR DOCUMENTO");
                                                }
                                            } else {
                                                ViewUtils.showMessageError("NO SE PROCESO DOCUMENTO: , " + jsonFromMh.get("descripcionMsg").getAsString());
                                            }
                                        } else {
                                            ViewUtils.showMessageError("Ocurrió un error al intentar validar Json: " + jsonAuth.get("descripcionMsg").getAsString());
                                        }
                                    }
                                }
                            } else {
                                ViewUtils.showMessageError("Ocurrió un error al intentar validar Json: " + valido.getMensaje());
                            }
                        } else {
                            ViewUtils.showMessageError("Ocurrió un Error en fun_retorna_json");
                        }
                    } else {
                        ViewUtils.showMessageError(resp.getMensaje());
                    }
                } else {
                    ViewUtils.showMessageError("NO SE ENCONTRÓ DOCUMENTO EMITIDO CON CODIGO GENERACIÓN " + codigoGen + ", FAVOR VERIFIQUE O INFORME EL INCONVENIENTE");
                }

            }
        }
    }

    private void confirmDialog() {
        mensaje = "SE HA FINALIZADO PROCESO CORRECTAMENTE ";
        PrimeFaces.current().executeScript("PF('DialogConfirm').show();");
        PrimeFaces.current().ajax().update("frmAnular");
    }

    private JsonObject getProcesarAnulacion(JsonElement jsonFirmado, String token) {
        JsonObject response = new JsonObject();
        JsonObject jsonRequest = new JsonObject();
        try {
            jsonRequest.addProperty("version", pmh.getPmAnulaciondteVersion());
            jsonRequest.addProperty("ambiente", pmh.getPmJsonFesvMhAmbiente());
            jsonRequest.addProperty("idEnvio", pmh.getPmJsonFesvMhIdenvio());
            jsonRequest.add("documento", jsonFirmado);

            HttpRequest request = HttpRequest.newBuilder().uri(new URI(pmh.getPmAnulaciondteUrl())).headers("Content-Type", "application/json").headers("Authorization", token).POST(HttpRequest.BodyPublishers.ofString(new Gson().toJson(jsonRequest))).build();

            HttpResponse<String> resp = HttpClient.newHttpClient().send(request, HttpResponse.BodyHandlers.ofString());

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

    private GenericResponse validarSchema(JsonObject jsonDte) {
        GenericResponse respuesta = new GenericResponse();
        String jsonPath;
        String propertyName = System.getProperty("os.name").toUpperCase().contains("WINDOWS") ? "FOLDER_JSON_FILES_WINDOWS" : "FOLDER_JSON_FILES_LINUX";
        jsonPath = ResourceBundle.getBundle("bundle").getString(propertyName).replace("${user.name}", System.getProperty("user.name"));
        log.info("jsonPath " + jsonPath);
        ObjectMapper objectMapper = new ObjectMapper();
        JsonSchemaFactory schemaFactory = JsonSchemaFactory.getInstance(SpecVersion.VersionFlag.V7);
        try (FileWriter fw = new FileWriter(jsonPath + File.separator + "dteJson" + SUFFIX, StandardCharsets.UTF_8)) {
            fw.write(jsonDte.toString());
            fw.flush();
            fw.close();
        } catch (IOException e) {
            log.error("ERROR RECUPERANDO SCHEMA JSON", e);
        }

        try (InputStream schemaStream = new FileInputStream(jsonPath + File.separator + "anulacion-schema.json"); InputStream jsonStream = new FileInputStream(jsonPath + File.separator + "dteJson.json");) {
            FacturaService.jsonStreamToJsonNode(respuesta, objectMapper, schemaFactory, schemaStream, jsonStream);

        } catch (Exception e) {
            log.error("ERROR SCHEMA JSON", e);
            respuesta.setVal(1);
            respuesta.setMensaje("Error " + e.getMessage());
        }
        return respuesta;
    }

    public JsonObject getFirmaDocumento(JsonObject jsonDte) {
        JsonObject signedJson = null;
        JsonObject jsonFirmador = new JsonObject();
        Gson parser = new Gson();

        jsonFirmador.addProperty("nit", pmh.getPmJsonFirmadorNit());
        jsonFirmador.addProperty("activo", true);
        jsonFirmador.addProperty("passwordPri", pmh.getPmJsonFirmadorPass());
        jsonFirmador.add("dteJson", jsonDte);

        try {
            HttpRequest request = HttpRequest.newBuilder().uri(new URI(pmh.getPmJsonFirmadorUrl())).headers("Content-Type", "application/json").POST(HttpRequest.BodyPublishers.ofString(jsonFirmador.toString())).build();

            HttpResponse<String> response = HttpClient.newHttpClient().send(request, HttpResponse.BodyHandlers.ofString());
            log.info("respuesta firmardocumento " + response.body());
            signedJson = parser.fromJson(response.body(), JsonObject.class);
            if (signedJson.get("status").getAsString().matches("OK")) {
                log.info("jsonFirmado: " + signedJson.get("body"));
            } else {
                log.error("error obteniendo jsonFirmado" + signedJson.get("status").getAsString() + ", " + signedJson.get("body"));
            }
        } catch (URISyntaxException | IOException | InterruptedException e) {
            log.error("error en getFirmaDocumento", e);
        }

        return signedJson;
    }

    private JsonObject getAuth() {
        JsonObject respuesta = new JsonObject();
        try {
            Map<String, String> params = new HashMap<>();
            params.put("user", pmh.getPmJsonAuthUser());
            params.put("pwd", pmh.getPmJsonAuthPass());

            String form = params.entrySet().stream().map(e -> e.getKey() + "=" + URLEncoder.encode(e.getValue(), StandardCharsets.UTF_8)).collect(Collectors.joining("&"));

            HttpRequest request = HttpRequest.newBuilder().uri(new URI(pmh.getPmJsonAuthUrl())).headers("Content-Type", "application/x-www-form-urlencoded").POST(HttpRequest.BodyPublishers.ofString(form)).build();

            HttpResponse<String> response = HttpClient.newHttpClient().send(request, HttpResponse.BodyHandlers.ofString());

            respuesta = JsonParser.parseString(response.body()).getAsJsonObject();

        } catch (URISyntaxException | IOException | InterruptedException ex) {
            log.error("error en getAuth", ex);
        }

        return respuesta;
    }

    public void clean() {
        continuar = Boolean.FALSE;
        codigoGen = null;
        tipoAnulacion = null;
        motivoAnulacion = null;
        selectedFactura = new BitacoraDeclaracionHacienda();
        mensaje = null;
        PrimeFaces.current().executeScript("PF('DialogConfirm').hide();");
        PrimeFaces.current().ajax().update("frmAnular");
        init();
    }

}
