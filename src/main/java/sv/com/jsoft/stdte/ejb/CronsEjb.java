package sv.com.jsoft.stdte.ejb;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import net.sf.resultsetmapper.ReflectionResultSetMapper;
import net.sf.resultsetmapper.ResultSetMapper;
import org.apache.log4j.Logger;
import org.json.JSONArray;
import org.json.JSONObject;
import sv.com.jsoft.stdte.dto.EmailDTO;
import sv.com.jsoft.stdte.dto.GenericResponse;
import sv.com.jsoft.stdte.dto.LoginDto;
import sv.com.jsoft.stdte.dto.TransactionsCursor;
import sv.com.jsoft.stdte.model.json.GeneracionJson;
import sv.com.jsoft.stdte.persistence.Buzoncsv;
import sv.com.jsoft.stdte.persistence.Factura;
import sv.com.jsoft.stdte.persistence.ParametrosMh;
import sv.com.jsoft.stdte.persistence.TiposComprobantes;
import sv.com.jsoft.stdte.repository.AppService;
import sv.com.jsoft.stdte.utils.ViewUtils;

import javax.annotation.PostConstruct;
import javax.ejb.*;
import javax.inject.Inject;
import javax.persistence.EntityManager;
import javax.persistence.ParameterMode;
import javax.persistence.PersistenceContext;
import javax.persistence.StoredProcedureQuery;
import java.io.IOException;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.sql.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.ResourceBundle;
import java.util.logging.Level;

@Stateless
public class CronsEjb {

    protected final static Logger logger = Logger.getLogger(CronsEjb.class);
    private static final ResourceBundle RESOURCE_BUNDLE = ResourceBundle.getBundle("bundle");

    @Inject
    AppService service;

    //String mail_cron_estado = "";

    String reportPath = "", pathImg = "";

    Integer procesados;

    @PersistenceContext
    EntityManager entityManager;

    @PostConstruct
    public void init() {
        reportPath = System.getProperty("os.name").toUpperCase()
                .contains("WINDOWS") ? RESOURCE_BUNDLE.getString("PATH_REPORT_WINDOWS") : RESOURCE_BUNDLE.getString("PATH_REPORT_LINUX");
        pathImg = System.getProperty("os.name").toUpperCase()
                .contains("WINDOWS") ? RESOURCE_BUNDLE.getString("PATH_REPORT_WINDOWS_IMG") : RESOURCE_BUNDLE.getString("PATH_REPORT_LINUX_IMG");

        reportPath = reportPath.replace("SYSTEM_USER", System.getProperty("user.name"));
        pathImg = pathImg.replace("SYSTEM_USER", System.getProperty("user.name"));

        java.util.logging.Logger.getLogger("org.hibernate").setLevel(Level.WARNING);
        //mail_cron_estado = RESOURCE_BUNDLE.getString("DIR_MAIL_CRON_ESTADO");
    }

    private final LoginDto loginRpv = new LoginDto(RESOURCE_BUNDLE.getString("DS_USER_MH"), RESOURCE_BUNDLE.getString("DS_PASSWORD_MH"), "RPV");

    public void MigrationDataFromOracleToMysql() {
        logger.info("iniciando proceso");
        procesados = 0;
        List<TransactionsCursor> cursorList = new ArrayList<>();
        Date fechaPeriodo = new Date();
        try {
            //DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
            Connection conn = DriverManager.getConnection(RESOURCE_BUNDLE.getString("DB_URL"), loginRpv.getQuizUser(), loginRpv.getQuizPass());
            CallableStatement call = conn.prepareCall("{call PCKW_FACTURA_ELECTRONICA.PRO_EXA_VISUAL_FACT_ELECT(?,?, ?,?)}");
            //call.registerOutParameter(1, OracleTypes.CURSOR);
            call.registerOutParameter(2, Types.DATE);
            call.registerOutParameter(3, Types.INTEGER);
            call.registerOutParameter(4, Types.VARCHAR);
            call.execute();
            if (call.getInt(3) == 0) {
                ResultSet resultSet = (ResultSet) call.getObject(1);
                cursorList = resultSetMapper(resultSet);
                java.sql.Timestamp timestamp = call.getTimestamp(2);
                if (timestamp != null) {
                    fechaPeriodo = new java.util.Date(timestamp.getTime());
                }
                resultSet.close();
                call.close();
                conn.close();
                logger.info("registros encontrados: " + cursorList.size());
            } else {
                logger.info("PCKW_FACTURA_ELECTRONICA.PRO_EXA_VISUAL_FACT_ELECT devuelve: " + call.getInt(3) + " Mensaje: " + call.getString(4));
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        }

        if (!cursorList.isEmpty()) {
            final int batchSize = 10;
            try {
                for (int index = 0; index < cursorList.size(); index+= batchSize) {
                    int end = Math.min(cursorList.size(), index+ batchSize);
                    List<TransactionsCursor> batchList = cursorList.subList(index, end);
                    processBatch(batchList, fechaPeriodo);
                }
                ViewUtils.showMessageInfo("Proceso finalizado correctamente");
                logger.info("proceso finalizado con " + procesados + " registros procesados");

            } catch (Exception e) {
                logger.error(e.getMessage());
            }
        }
    }
    private void processBatch(List<TransactionsCursor> batchList, Date fechaPeriodo){
        for(TransactionsCursor cursorItem : batchList){
            processElement(cursorItem, fechaPeriodo, cursorItem.getFecha_cobro());
            procesados++;
        }

    }

    private static <T> List<T> resultSetMapper(ResultSet rs) throws Exception {
        List<T> list = new ArrayList<T>();
        try {
            if (rs != null) {
                ResultSetMapper<T> resultSetMapper = new ReflectionResultSetMapper<T>(TransactionsCursor.class);
                while (rs.next()) {
                    T t = resultSetMapper.mapRow(rs);
                    if (t instanceof TransactionsCursor) {
                        TransactionsCursor transactionsCursor = (TransactionsCursor) t;
                        transactionsCursor.setFecha_cobro(new Date(rs.getTimestamp("fecha_cobro").getTime()));
                    }
                    list.add(t);
                }
            }
        } catch (Exception ex) {
            throw ex;
        }
        return list;
    }


    @TransactionAttribute(TransactionAttributeType.REQUIRES_NEW)
    private void processElement(TransactionsCursor cursorItem, Date fechaPeriodo, Date fechaEmision) {

        JSONArray allDataArray = new JSONArray();
        JSONObject eachData = new JSONObject();
        String observaciones = "";
        try {
            eachData.put("fecha", ViewUtils.formatoFecha(cursorItem.getFecha()));
            eachData.put("cantidad", cursorItem.getCantidad());
            eachData.put("producto", cursorItem.getProducto());
            eachData.put("sucursal", cursorItem.getSucursal() != null ? cursorItem.getSucursal() : "null");
            eachData.put("cdc", cursorItem.getCdc_id());
            eachData.put("nombre", cursorItem.getNombre());
            allDataArray.put(eachData);

            logger.info("llamando a proceso pro_envio_examen_visual: " + allDataArray);
            StoredProcedureQuery spq = entityManager.createStoredProcedureQuery("pro_envio_examen_visual")
                    .registerStoredProcedureParameter(1, String.class, ParameterMode.IN)
                    .registerStoredProcedureParameter(2, Integer.class, ParameterMode.OUT)
                    .registerStoredProcedureParameter(3, String.class, ParameterMode.OUT)
                    .setParameter(1, new Gson().toJson(allDataArray));
            spq.execute();

            if ((Integer) spq.getOutputParameterValue(2) == 0) {
                logger.info("llamando a proceso pro_carga_facturas ");
                StoredProcedureQuery storedProcedureQuery = entityManager.createStoredProcedureQuery("pro_carga_facturas")
                        .registerStoredProcedureParameter(1, String.class, ParameterMode.IN)
                        .registerStoredProcedureParameter(2, String.class, ParameterMode.IN)
                        .registerStoredProcedureParameter(3, Integer.class, ParameterMode.OUT)
                        .registerStoredProcedureParameter(4, Integer.class, ParameterMode.OUT)
                        .registerStoredProcedureParameter(2, String.class, ParameterMode.OUT)
                        .setParameter(1, "CRONEXAMVISUALDTE")
                        .setParameter(2, loginRpv.getQuizUser());

                storedProcedureQuery.execute();
                if ((Integer) storedProcedureQuery.getOutputParameterValue(4) == 0) {
                    int id_factura = (Integer) storedProcedureQuery.getOutputParameterValue(3);
                    try {
                        Factura factura = updatingFacturaBuzon(id_factura, fechaPeriodo, fechaEmision, cursorItem);
                        observaciones = "Fecha del Periodo del " + ViewUtils.formatoFecha(fechaPeriodo) + " al " + ViewUtils.formatoFecha(fechaPeriodo);
                        //pmId = 1 -> Produccion, pmId = 2 -> Pruebas
                        ParametrosMh parametrosMh = entityManager.createQuery("from ParametrosMh p where p.pmJsonFirmadorNit = :nitEmisor and p.pmId = 1", ParametrosMh.class)
                                .setParameter("nitEmisor", factura.getFacNitEmisor())
                                .getSingleResult();
                        logger.info("parametros mh: " + parametrosMh);

                        TiposComprobantes tipoComp = entityManager
                                .createQuery("from TiposComprobantes t where t.tcpIdtipcom =:id", TiposComprobantes.class)
                                .setParameter("id", factura.getFacTipoComprobante())
                                .getSingleResult();
                        logger.info("procesando factura nro: " + factura.getFacNroFactura() + " , " + "tipo: " + factura.getFacTipoComprobante()
                                + " - " + tipoComp.getTcpComprobante() + " , idFactura: " + factura.getFacId());

                        if (factura.getFacEstadoFactura() == 1) { //factura pendiente de enviar
                            GeneracionJson genJson = callProGeneracionJson(tipoComp, factura);
                            if (genJson != null) {
                                String schemaName = "fe-schema.json";
                                GenericResponse validJson = service.validarSchema(genJson.getJson(), schemaName);
                                if (validJson.getVal() == 0) {
                                    JsonObject jsonObject = service.getFirmaDocu(genJson.getJson(), parametrosMh);
                                    if (jsonObject != null) {
                                        if (jsonObject.get("status").getAsString().equals("OK")) {
                                            String token;
                                            JsonObject jsonAuth = service.getAuthorization(parametrosMh);
                                            if (jsonAuth.get("status").getAsString().equals("OK")) {
                                                token = jsonAuth.getAsJsonObject("body").get("token").getAsString();
                                                String uuid = genJson.getCodigoGeneracion();
                                                JsonObject jsonFromMh = procesarMh(jsonObject.get("body"), factura.getFacTipoComprobante(), uuid, token, parametrosMh);
                                                if (jsonFromMh != null && jsonFromMh.get("estado").getAsString() != null) {
                                                    String clasMsg = jsonFromMh.get("clasificaMsg").getAsString();
                                                    switch (clasMsg) {
                                                        case "10":
                                                            service.procesarRespuestaMh(jsonFromMh, parametrosMh, genJson, factura, observaciones);
                                                            updatingFacturaEnviada(factura.getFacId());
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
                                                            logger.error(jsonFromMh.get("estado").getAsString() + " - " + jsonFromMh.get("codigoMsg").getAsString() + " - " + jsonFromMh.get("descripcionMsg").getAsString());
                                                            String detail = jsonFromMh.get("estado").getAsString() + " - " + jsonFromMh.get("codigoMsg").getAsString() + " - " + jsonFromMh.get("descripcionMsg").getAsString();
                                                            String body = "Falló el envío de correo de factura #: " + factura.getFacId();
                                                            EmailDTO request = new EmailDTO();
                                                            request.setBody(body + ", detalle: " + detail);
                                                            service.procesarRespuestaMh(jsonFromMh, parametrosMh, genJson, factura, observaciones);
                                                            sendErrorEmail(body);
                                                            break;
                                                    }
                                                } else {
                                                    sendErrorEmail("Falló el envío de correo de factura #: " + factura.getFacId() + ", no se obtuvo respuesta de MH");
                                                }
                                            } else {
                                                sendErrorEmail("Falló el envío de correo de factura #: " + factura.getFacId() + ", no se obtuvo autorización de MH");
                                            }
                                        } else {
                                            sendErrorEmail("Falló el envío de correo de factura #: " + factura.getFacId() + ", no se obtuvo firma de docuemnto");
                                        }
                                    } else {
                                        sendErrorEmail("Falló el envío de correo de factura #: " + factura.getFacId() + ", no se obtuvo autorización de MH");
                                    }
                                } else {
                                    sendErrorEmail("Falló el envío de correo de factura #: " + factura.getFacId() + ", fallo la validacion schemajson");
                                }
                            } else {
                                sendErrorEmail("Falló el envío de correo de factura #: " + factura.getFacId() + ", proceso genera json");
                            }
                        } else {
                            logger.info("ID Factura: " + factura.getFacId() + " ya ha sido enviada a MH");
                        }
                    } catch (Exception e) {
                        sendErrorEmail("Falló el envío de correo de factura #: " + id_factura + ", error " + e.getMessage());
                    }
                } else {
                    sendErrorEmail("Falló proceso pro_carga_factura: " + "proceso devuelve 1 ");
                }
            } else {
                sendErrorEmail("Falló proceso pro_envio_examen_visual");
            }
        } catch (Exception e) {
            e.printStackTrace();
            sendErrorEmail("Falló proceso pro_envio_examen_visual " + e.getMessage());
        }
    }

    private Factura updatingFacturaBuzon(Integer id_factura, Date fechaPeriodo, Date fechaEmision, TransactionsCursor cursorItem) {
        logger.info("Update periodo factura #: " + id_factura + " fechaPeriodo : "
                + ViewUtils.formatoFecha(fechaPeriodo) + " fechaEmision: " + ViewUtils.formatoFecha(fechaEmision));

        Factura factura = entityManager.createQuery("from Factura f where f.facId = :nroFact", Factura.class)
                .setParameter("nroFact", id_factura)
                .getSingleResult();

        factura.setFacFechaIniPeriodo(fechaPeriodo);
        factura.setFacFechaFinPeriodo(fechaPeriodo);
        factura.setFacFechaEmision(fechaEmision);
        entityManager.merge(factura);
        entityManager.flush();

        //update tabla buzoncsv
        try {
            List<Buzoncsv> buzoncsv = entityManager.createQuery("from Buzoncsv b where b.cdcId = :cdcId", Buzoncsv.class)
                    .setParameter("cdcId", Integer.valueOf(cursorItem.getCdc_id()))
                    .getResultList();
            logger.info("updating buzoncsv, registros encontrados: " + buzoncsv.size());
            if (buzoncsv.size() > 0) {
                buzoncsv.forEach(i -> {
                    i.setIdFactura(id_factura);
                    entityManager.merge(i);
                });
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return factura;
    }

    private GeneracionJson callProGeneracionJson(TiposComprobantes tipoComp, Factura factura) {
        GeneracionJson genJson = null;
        try {
            StoredProcedureQuery storedP = entityManager.createStoredProcedureQuery("pro_generacion_json")
                    .registerStoredProcedureParameter(1, String.class, ParameterMode.IN)
                    .registerStoredProcedureParameter(2, String.class, ParameterMode.IN)
                    .registerStoredProcedureParameter(3, String.class, ParameterMode.OUT)
                    .registerStoredProcedureParameter(4, String.class, ParameterMode.OUT)
                    .setParameter(1, tipoComp.getTcpComprobante())
                    .setParameter(2, String.valueOf(factura.getFacId()));

            storedP.execute();
            String jsonStr = (String) storedP.getOutputParameterValue(3);
            if (jsonStr != null && jsonStr.length() > 0 && storedP.getOutputParameterValue(4) != null) {
                genJson = new GeneracionJson();
                genJson.setCodigoGeneracion((String) storedP.getOutputParameterValue(4));
                genJson.setJson(JsonParser.parseString(jsonStr).getAsJsonObject());
            } else {
                logger.error("proceso pro_generacion_json no devuelve json a enviar a mh");
            }
        } catch (Exception e) {
            logger.error("fallo la llamada al proceso pro_generacion_json: " + e.getMessage());
        }
        return genJson;
    }

    private JsonObject procesarMh(JsonElement jsonFirmado, String tipoDoc, String uuid, String token, ParametrosMh pmh) {
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

            HttpRequest request = HttpRequest.newBuilder()
                    .uri(new URI(pmh.getPmJsonFesvMhUrl())).headers("Content-Type", "application/json")
                    .headers("Authorization", token)
                    .POST(HttpRequest.BodyPublishers.ofString(new Gson().toJson(jsonRequest))).build();

            HttpResponse<String> resp = HttpClient.newHttpClient().send(request, HttpResponse.BodyHandlers.ofString());

            response = JsonParser.parseString(resp.body()).getAsJsonObject();
            logger.info("response from mh: " + response);
        } catch (URISyntaxException e) {
            logger.error("error getProcesarMh" + e.getMessage());
            return null;
        } catch (IOException | InterruptedException e) {
            throw new RuntimeException(e);
        }
        return response;
    }

    private void sendErrorEmail(String error) {
        logger.error(error);
//        EmailDTO request = new EmailDTO();
//        request.setTo(mail_cron_estado);
//        request.setBody(error);
//        request.setSubject("Falló el envío automático de correo, proceso exámenes visuales");
//        request.setUsuario("CRONEXAMVISUALDTE");
//        service.sendMail(request);
    }

    public void triggerScheduleTask() {
        //Manually trigger the schedule task
        MigrationDataFromOracleToMysql();
    }

    private void updatingFacturaEnviada(Integer id_factura) {
        logger.info("Update fac_estado_factura para id_factura : " + id_factura);

        Factura factura = entityManager.createQuery("from Factura f where f.facId = :idFactura", Factura.class)
                .setParameter("idFactura", id_factura)
                .getSingleResult();

        factura.setFacEstadoFactura(2);
        entityManager.merge(factura);
    }
}