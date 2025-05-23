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
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.time.LocalDate;
import java.time.YearMonth;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.ResourceBundle;

public class CronFinMes {

    protected final static Logger logger = Logger.getLogger(CronsEjb.class);
    private static final ResourceBundle RESOURCE_BUNDLE = ResourceBundle.getBundle("bundle");
    private final LoginDto loginRpv = new LoginDto(RESOURCE_BUNDLE.getString("DS_USER_MH"), RESOURCE_BUNDLE.getString("DS_PASSWORD_MH"), "RPV");
    //private final String mail_cron_estado = RESOURCE_BUNDLE.getString("DIR_MAIL_CRON_ESTADO");

    @Inject
    AppService service;

    @PersistenceContext
    EntityManager entityManager;

    private Integer procesados;

    String reportPath = "", pathImg = "";

    public void init() {
        reportPath = System.getProperty("os.name").toUpperCase()
                .contains("WINDOWS") ? reportPath = RESOURCE_BUNDLE.getString("PATH_REPORT_WINDOWS") : RESOURCE_BUNDLE.getString("PATH_REPORT_LINUX");
        pathImg = System.getProperty("os.name").toUpperCase()
                .contains("WINDOWS") ? RESOURCE_BUNDLE.getString("PATH_REPORT_WINDOWS_IMG") : RESOURCE_BUNDLE.getString("PATH_REPORT_LINUX_IMG");

        reportPath = reportPath.replace("SYSTEM_USER", System.getProperty("user.name"));
        pathImg = pathImg.replace("SYSTEM_USER", System.getProperty("user.name"));

    }

    private static LocalDate getLastDayOfMonth(LocalDate currentDate) {
        // Calculate the last day of the month
        YearMonth yearMonth = YearMonth.from(currentDate);
        return yearMonth.atEndOfMonth();
    }

    public void CronFacturacionMensual() {
        logger.info("iniciando proceso facturacion mensual");
        List<TransactionsCursor> cursorList = null;
        LocalDate currentDate = LocalDate.now();
        LocalDate previousDay = currentDate.minusDays(1);

        logger.info("fecha actual: " + currentDate);
        logger.info("fecha previa: " + previousDay);

        LocalDate lastDayOfMonth = getLastDayOfMonth(previousDay);
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
        //Variable a utilizar en observaciones
        String formattedLastDay = lastDayOfMonth.format(formatter);
        //Convertir a Date para hacer el update en facturas
        Date fecha = java.sql.Date.valueOf(lastDayOfMonth);
        try {
            /*Estableciendo conexion a BD Oracle*/
            //DriverManager.registerDriver(new OracleDriver());
            Connection conn = DriverManager.getConnection(RESOURCE_BUNDLE.getString("DB_URL"),
                    loginRpv.getQuizUser(), loginRpv.getQuizPass());

            CallableStatement call = conn.prepareCall("{call PCKW_FACTURA_ELECTRONICA.PRO_ENVIO_FACTURA_ELECTRONICA(?)}");
            call.registerOutParameter(1, null);
            call.execute();

            ResultSet resultSet = (ResultSet) call.getObject(1);
            cursorList = resultSetMapper(resultSet, TransactionsCursor.class);

            resultSet.close();
            call.close();
            conn.close();
        } catch (Exception e) {
            logger.error("Ocurrió un error en llamada a proceso almacenado de oracle: " + e.getMessage());
        }

        if (cursorList != null && cursorList.size() > 0) {
            int tamañoLote = 50;// tamaño de lote a procesar
            logger.info("Se encontraron : " + cursorList.size() + " registros ");
            procesados = 0;
            for (int index = 0; index < cursorList.size(); index += tamañoLote) {
                try {
                    for (int j = index; j < index + tamañoLote && j < cursorList.size(); j++) {
                        procesarItem(cursorList.get(j), fecha, formattedLastDay);
                        procesados++;
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            logger.info("Se procesaron: " + procesados + " registros");
        } else {
            logger.info("No se encontraron registros en PRO_ENVIO_FACTURA_ELECTRONICA ");
        }
    }

    private static <T> List<T> resultSetMapper(ResultSet rs, Class<T> type) throws Exception {
        List<T> list = new ArrayList<T>();
        try {
            if (rs != null) {
                ResultSetMapper<T> resultSetMapper = new ReflectionResultSetMapper<T>(type);
                while (rs.next()) {
                    T t = resultSetMapper.mapRow(rs);
                    list.add(t);
                }
            }
        } catch (Exception ex) {
            throw ex;
        }
        return list;
    }

    private void procesarItem(TransactionsCursor cursor, Date fecha, String strFecha) {
        JSONArray allDataArray = new JSONArray();
        JSONObject eachData = new JSONObject();
        String observaciones = "";
        try {
            eachData.put("fecha", ViewUtils.formatoFecha(cursor.getFecha()));
            eachData.put("cantidad", cursor.getCantidad());
            eachData.put("producto", cursor.getProducto());
            eachData.put("sucursal", cursor.getSucursal() != null ? cursor.getSucursal() : "null");
            allDataArray.put(eachData);

            StoredProcedureQuery spq = entityManager.createStoredProcedureQuery("pro_aut_facturas_fin_mes")
                    .registerStoredProcedureParameter(1, String.class, ParameterMode.IN)
                    .registerStoredProcedureParameter(2, Integer.class, ParameterMode.OUT)
                    .registerStoredProcedureParameter(3, String.class, ParameterMode.OUT)
                    .setParameter(1, new Gson().toJson(allDataArray));
            spq.execute();

            if ((Integer) spq.getOutputParameterValue(2) == 0) {
                logger.info("llamada a proceso PRO_CARGA_FACTURA");
                StoredProcedureQuery storedpq = entityManager.createStoredProcedureQuery("pro_carga_facturas")
                        .registerStoredProcedureParameter(1, String.class, ParameterMode.IN)
                        .registerStoredProcedureParameter(2, String.class, ParameterMode.IN)
                        .registerStoredProcedureParameter(3, Integer.class, ParameterMode.OUT)
                        .registerStoredProcedureParameter(4, Integer.class, ParameterMode.OUT)
                        .registerStoredProcedureParameter(5, String.class, ParameterMode.OUT)
                        .setParameter(1, "CRONFINMES")
                        .setParameter(2, loginRpv.getQuizUser());
                storedpq.execute();

                if ((Integer) storedpq.getOutputParameterValue(4) == 0
                        && (Integer) storedpq.getOutputParameterValue(3) > 0) {
                    int idFactura = (Integer) storedpq.getOutputParameterValue(3);
                    logger.info("Update periodo factura #:" + idFactura + " fecha: " + fecha);
                    Factura factura = entityManager
                            .createQuery("from Factura f where f.facId = :nroFact", Factura.class)
                            .setParameter("nroFact", idFactura)
                            .getSingleResult();
                    factura.setFacFechaIniPeriodo(fecha);
                    factura.setFacFechaFinPeriodo(fecha);
                    entityManager.merge(factura);

                    observaciones = "Fecha del Periodo del " + strFecha + " al " + strFecha;
                    ParametrosMh parametrosMh = entityManager
                            .createQuery("from ParametrosMh p where p.pmJsonFirmadorNit = :nitEmisor and p.pmId = 1", ParametrosMh.class)
                            .setParameter("nitEmisor", factura.getFacNitEmisor())
                            .getSingleResult();
                    logger.info("parametros mh: " + parametrosMh);

                    TiposComprobantes tipoComp = entityManager.createQuery("from TiposComprobantes t where t.tcpIdtipcom =:id", TiposComprobantes.class)
                            .setParameter("id", factura.getFacTipoComprobante())
                            .getSingleResult();

                    logger.info("procesando factura nro: " + factura.getFacNroFactura() + " , " + "tipo: "
                            + factura.getFacTipoComprobante() + " - "
                            + tipoComp.getTcpComprobante() + " , idFactura: "
                            + factura.getFacId());
                    GeneracionJson genJson = callProGeneracionJson(tipoComp, factura);
                    if (genJson != null) {
                        String schemaName = "ccfe-schema.json";
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
                                        JsonObject jsonFromMh = getProcesarMh(jsonObject.get("body"), factura.getFacTipoComprobante(), uuid, token, parametrosMh);
                                        if (jsonFromMh != null && jsonFromMh.get("estado").getAsString() != null) {
                                            String clasMsg = jsonFromMh.get("clasificaMsg").getAsString();
                                            switch (clasMsg) {
                                                case "10":
                                                    service.procesarRespuestaMh(jsonFromMh, parametrosMh, genJson, factura, observaciones);
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
                                    sendErrorEmail("Falló el envío de correo de factura #: " + factura.getFacId() + ", no se obtuvo firma de docuemnto, status " + jsonObject.get("status").getAsString());
                                }
                            } else {
                                sendErrorEmail("Falló el envío de correo de factura #: " + factura.getFacId() + ", no se obtuvo firma de docuemnto");
                            }
                        } else {
                            sendErrorEmail("Falló la validación del esquema json ");
                        }
                    } else {
                        sendErrorEmail("Falló pro_generacion_json ");
                    }
                } else {
                    sendErrorEmail("Falló proceso pro_carga_facturas, mensaje proceso:" + storedpq.getOutputParameterValue(5));
                }
            } else {
                sendErrorEmail("Falló proceso pro_aut_facturas_fin_mes, proceso devuelve val 1, mensaje: " + spq.getOutputParameterValue(3));
            }
        } catch (Exception e) {
            sendErrorEmail("Falló proceso CronFinMes " + e.getMessage());
        }
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

            HttpRequest request = HttpRequest.newBuilder().uri(new URI(pmh.getPmJsonFesvMhUrl())).headers("Content-Type", "application/json").headers("Authorization", token).POST(HttpRequest.BodyPublishers.ofString(new Gson().toJson(jsonRequest))).build();
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
    }

    public void triggerScheduleTask() {
        
    }
}
