package sv.com.jsoft.stdte.repository;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.*;
import com.networknt.schema.JsonSchema;
import com.networknt.schema.JsonSchemaFactory;
import com.networknt.schema.SpecVersion;
import com.networknt.schema.ValidationMessage;
import org.apache.commons.io.IOUtils;
import sv.com.jsoft.stdte.view.LoginBean;
import sv.com.jsoft.stdte.dto.*;
import sv.com.jsoft.stdte.model.json.GeneracionJson;
import sv.com.jsoft.stdte.persistence.*;
import sv.com.jsoft.stdte.utils.JasperReportUtil;
import sv.com.jsoft.stdte.utils.ViewUtils;

import javax.activation.DataHandler;
import javax.annotation.PostConstruct;
import javax.annotation.Resource;
import javax.ejb.Stateless;
import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.mail.util.ByteArrayDataSource;
import javax.persistence.*;
import java.io.*;
import java.math.BigDecimal;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.URLEncoder;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;
import java.sql.SQLException;
import java.sql.Time;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.logging.Level;
import java.util.stream.Collectors;
import javax.inject.Inject;
import javax.naming.NamingException;
import lombok.extern.slf4j.Slf4j;
import sv.com.jsoft.stdte.utils.QueryUtils;

@Stateless
@Slf4j
public class AppService {

    public static final String SUFFIX = ".json";
    private static final ResourceBundle RESOURCE_BUNDLE = ResourceBundle.getBundle("application");
    private static final ResourceBundle RESOURCE_BUNDLE_MAIL = ResourceBundle.getBundle("bundle");

    @Resource(name = "java:jboss/mail/Default")
    private Session mailSession;

    @PersistenceContext
    private EntityManager em;

    @Inject
    JasperReportUtil jr;

    String reportPath = "", pathImg = "";

    @PostConstruct
    public void init() {
        reportPath = System.getProperty("os.name").toUpperCase()
                .contains("WINDOWS") ? RESOURCE_BUNDLE_MAIL.getString("PATH_REPORT_WINDOWS") : RESOURCE_BUNDLE_MAIL.getString("PATH_REPORT_LINUX");
        pathImg = System.getProperty("os.name").toUpperCase()
                .contains("WINDOWS") ? RESOURCE_BUNDLE_MAIL.getString("PATH_REPORT_WINDOWS_IMG") : RESOURCE_BUNDLE_MAIL.getString("PATH_REPORT_LINUX_IMG");

        reportPath = reportPath.replace("SYSTEM_USER", System.getProperty("user.name"));
        pathImg = pathImg.replace("SYSTEM_USER", System.getProperty("user.name"));

        java.util.logging.Logger.getLogger("org.hibernate").setLevel(Level.WARNING);
    }

    public GeneracionJson callGenerateJson(String tipoFact, String factura) {
        GeneracionJson response = new GeneracionJson();
        String jsonStr;

        StoredProcedureQuery storedProcedureQuery = em.createStoredProcedureQuery("pro_generacion_json");
        storedProcedureQuery.registerStoredProcedureParameter(1, String.class, ParameterMode.IN);
        storedProcedureQuery.registerStoredProcedureParameter(2, String.class, ParameterMode.IN);
        storedProcedureQuery.registerStoredProcedureParameter(3, String.class, ParameterMode.OUT);
        storedProcedureQuery.registerStoredProcedureParameter(4, String.class, ParameterMode.OUT);

        storedProcedureQuery.setParameter(1, tipoFact);
        storedProcedureQuery.setParameter(2, factura);

        storedProcedureQuery.execute();

        jsonStr = (String) storedProcedureQuery.getOutputParameterValue(3);
        response.setCodigoGeneracion((String) storedProcedureQuery.getOutputParameterValue(4));
        response.setJson(JsonParser.parseString(jsonStr).getAsJsonObject());

        return response;
    }

    public GenericResponse ejecutarProcesoCargaFacturas(String app, LoginDto login) {
        GenericResponse response = new GenericResponse();
        try {
            StoredProcedureQuery storedProcedureQuery = em.createStoredProcedureQuery("pro_carga_facturas");
            storedProcedureQuery.registerStoredProcedureParameter(1, String.class, ParameterMode.IN);
            storedProcedureQuery.registerStoredProcedureParameter(2, String.class, ParameterMode.IN);
            storedProcedureQuery.registerStoredProcedureParameter(3, Integer.class, ParameterMode.OUT);
            storedProcedureQuery.registerStoredProcedureParameter(4, Integer.class, ParameterMode.OUT);
            storedProcedureQuery.registerStoredProcedureParameter(5, String.class, ParameterMode.OUT);

            storedProcedureQuery.setParameter(1, app);
            storedProcedureQuery.setParameter(2, login.getUsuario());

            storedProcedureQuery.execute();

            response.setIdFactura((Integer) storedProcedureQuery.getOutputParameterValue(3));
            response.setVal((Integer) storedProcedureQuery.getOutputParameterValue(4));
            response.setMensaje((String) storedProcedureQuery.getOutputParameterValue(5));
            log.info("respuesta pro_carga_facturas: " + response);

        } catch (Exception e) {
            log.error("ERROR en ejecutarProcesoCargaFacturas", e);
            response.setMensaje(e.getMessage());
            response.setVal(1);
        }

        return response;
    }

    public int PersistBuzonCsv(Buzoncsv buzoncsv) {
        Buzoncsv buzon = buzoncsv;
        em.persist(buzon);
        em.flush();
        
        return buzon.getIdBuzon();
    }

    public List<Factura> findAllFacturas() {
        List<Factura> resultado = em
                .createQuery("from Factura f WHERE NOT EXISTS ( FROM BitacoraDeclaracionHacienda b where b.idFac = f.facId )")
                .getResultList();
        return resultado;
    }

    public TiposComprobantes findComprobanteById(String id) {
        TiposComprobantes response;
        try {
            Query query = em
                    .createQuery("from TiposComprobantes t where t.tcpIdtipcom =:id", TiposComprobantes.class);
            query.setParameter("id", id);
            response = (TiposComprobantes) query.getSingleResult();

        } catch (Exception e) {
            log.error("ERROR en findComprobanteById", e);
            return null;
        }
        return response;
    }

    public List<TiposComprobantes> findPlantBrillo(String fechaIni, String fechaFin, String sucursal) {
        List<TiposComprobantes> response;
        try {
            response = em
                    .createQuery("from TiposComprobantes t where t.tcpIdtipcom =:id", TiposComprobantes.class)
                    //.setParameter("id", id)
                    .getResultList();
        } catch (Exception e) {
            log.error("ERROR en findPlantBrillo", e);
            return null;
        }
        return response;
    }

    public boolean sendMail(String email, String nroFactura, String reportPath, JsonObject jsonObject, String nameJsonFile, String observaciones, String tipoDocumento) {
        boolean sent;
        try {
            //Reporte Factura Electrónica
            byte[] attachment1 = buildReport(nroFactura, reportPath, observaciones, tipoDocumento);

            //Archivo json
            File jsonFile = buildJsonFile(jsonObject, nameJsonFile);
            FileInputStream fis = new FileInputStream(jsonFile);
            byte[] attachment2 = new byte[(int) jsonFile.length()];
            fis.read(attachment2);
            fis.close();

            String mail = email;
            String subject = "Factura Electrónica DTE " + nameJsonFile;
            String body = getBodyMailToSendReport(nroFactura);

            log.info("sending mail to: " + mail);
            sent = sendDte(mail, subject, body, attachment1, attachment2);

        } catch (IOException e) {
            sent = Boolean.FALSE;
            log.error("ERROR en sendMail: ", e);
        }
        return sent;
    }

    private byte[] buildReport(String nroFactura, String path, String observaciones, String tipoDocumento) {
        Map<String, Object> hm = new HashMap<>();

        String pathI = System.getProperty("os.name").toUpperCase()
                .contains("WINDOWS") ? RESOURCE_BUNDLE_MAIL.getString("PATH_REPORT_WINDOWS_IMG")
                : RESOURCE_BUNDLE_MAIL.getString("PATH_REPORT_LINUX_IMG");
        try {
            pathI = pathI.replace("SYSTEM_USER", System.getProperty("user.name"));
            hm.put("PNRO_FACTURA", nroFactura);
            hm.put("POBSERVACIONES", observaciones);
            hm.put("PLOGO", pathI);
            log.info("building report with params: " + hm);
            return jr.getReportToPdf(path, hm, tipoDocumento.matches("07") ? "REPCOMPRET" : "REPNOTAREMELEC");

        } catch (SQLException | NamingException e) {
            log.error("ERROR en buildReport", e);
        }
        return null;

    }

    public GenericResponse PersistMHResponse(String nroControl, String estado, String sello_rec, String codigo_gen, JsonObject pjson, String link, String finProcesamiento) {
        GenericResponse response = new GenericResponse();

        StoredProcedureQuery storedProcedureQuery = em.createStoredProcedureQuery("pro_respuesta_json");
        storedProcedureQuery.registerStoredProcedureParameter(1, String.class, ParameterMode.IN);
        storedProcedureQuery.registerStoredProcedureParameter(2, String.class, ParameterMode.IN);
        storedProcedureQuery.registerStoredProcedureParameter(3, String.class, ParameterMode.IN);
        storedProcedureQuery.registerStoredProcedureParameter(4, String.class, ParameterMode.IN);
        storedProcedureQuery.registerStoredProcedureParameter(5, String.class, ParameterMode.IN);
        storedProcedureQuery.registerStoredProcedureParameter(6, String.class, ParameterMode.IN);
        storedProcedureQuery.registerStoredProcedureParameter(7, String.class, ParameterMode.IN);

        storedProcedureQuery.registerStoredProcedureParameter(8, Integer.class, ParameterMode.OUT);
        storedProcedureQuery.registerStoredProcedureParameter(9, String.class, ParameterMode.OUT);

        storedProcedureQuery.setParameter(1, nroControl);
        storedProcedureQuery.setParameter(2, estado);
        storedProcedureQuery.setParameter(3, sello_rec);
        storedProcedureQuery.setParameter(4, codigo_gen);
        storedProcedureQuery.setParameter(5, finProcesamiento);
        storedProcedureQuery.setParameter(6, pjson.toString());
        storedProcedureQuery.setParameter(7, link);

        storedProcedureQuery.execute();

        response.setVal((Integer) storedProcedureQuery.getOutputParameterValue(8));
        response.setMensaje((String) storedProcedureQuery.getOutputParameterValue(9));

        return response;
    }

    public String getBodyMailToSendReport(String idFactura) {
        String body = "";
        try {
            body = (String) em.createNativeQuery("select fun_retorna_correomh(:idFactura) as texto_correo from dual")
                    .setParameter("idFactura", Integer.valueOf(idFactura))
                    .getSingleResult();

        } catch (NumberFormatException e) {
            log.error("ERROR en getBodyMailToSendReport", e);
        }
        return body;
    }

    public File buildJsonFile(JsonObject jsonObject, String nameJsonFile) throws IOException {
        final File tempFile = File.createTempFile(nameJsonFile, SUFFIX);
        String str = jsonObject.toString();
        InputStream in = new ByteArrayInputStream(str.getBytes());
        tempFile.deleteOnExit();
        try (FileOutputStream out = new FileOutputStream(tempFile)) {
            IOUtils.copy(in, out);
        } catch (Exception e) {
            log.error("ERROR en buildJsonFile", e);
        }
        return tempFile;
    }

    public String findDepartamentoDescByCod(String codigo) {
        String departamento;
        Departamentos depto;
        try {
            Query query = em
                    .createQuery("from Departamentos d where d.codMh = :codigo", Departamentos.class);
            query.setParameter("codigo", codigo);
            depto = (Departamentos) query.getSingleResult();
            departamento = depto.getValor();
        } catch (Exception e) {
            log.error("ERROR en findDepartamentoDescByCod", e);
            return null;
        }
        return departamento;
    }

    public String findMunicipioDescByCod(String codDepto, String codMun) {
        String municipio;
        UbicacionesGeograficas ubicacion;
        try {
            log.info("parametros CodDepto: " + codDepto + ", CodMun: " + codMun);
            int deptoId;
            Query query = em.createQuery("from Departamentos d where d.codMh = :codDepto", Departamentos.class);
            query.setParameter("codDepto", codDepto);
            Departamentos depto = (Departamentos) query.getSingleResult();
            deptoId = depto.getIddepto();

            query = em
                    .createQuery("from UbicacionesGeograficas ug where ug.ugbIddepto = :codDepto and ug.ubgCodigo = :codMun", UbicacionesGeograficas.class);
            query.setParameter("codDepto", deptoId).setParameter("codMun", codMun);

            ubicacion = (UbicacionesGeograficas) query.getSingleResult();
            municipio = ubicacion.getUbgDescripcion();

        } catch (Exception e) {
            log.error("ERROR en findMunicipioDescByCod", e);
            return null;
        }
        return municipio;
    }

    public List<TiposComprobantes> findAllTiposComprobantes() {
        List<TiposComprobantes> resultado = new ArrayList<>();
        try {
            resultado = em.createQuery("from TiposComprobantes ").getResultList();
        } catch (Exception e) {
            log.error("error findAllTiposComprobantes " + e.getMessage());
        }
        return resultado;
    }

    public List<CatalogoProductos> findCatalogoProductosByIdEmp(Integer idEmp) {
        List<CatalogoProductos> resultado = new ArrayList<>();
        try {
            resultado = em.createQuery("SELECT c FROM CatalogoProductos c WHERE c.idEmpresa = :idEmp")
                    .setParameter("idEmp", idEmp)
                    .getResultList();
        } catch (Exception e) {
            log.error("error findCatalogoProductos: " + e.getMessage());
        }
        return resultado;
    }

    public CatalogoProductos findProductoById(String codProducto) {
        CatalogoProductos resultado;
        try {
            Query query = em.createQuery("from CatalogoProductos cp where cp.codigoProd = :codProducto", CatalogoProductos.class);
            query.setParameter("codProducto", codProducto);

            resultado = (CatalogoProductos) query.getSingleResult();

        } catch (Exception e) {
            resultado = null;
            log.error("ERROR en findProductoById", e);
        }
        return resultado;
    }

    public List<CatalogoTributos> findTributosByCod(String codigoTrib) {
        List<CatalogoTributos> resultado;
        try {
            Query query = em.createQuery("from CatalogoTributos ct where ct.codigo = :codTributo", CatalogoTributos.class);
            query.setParameter("codTributo", codigoTrib);
            resultado = query.getResultList();

        } catch (Exception e) {
            resultado = null;
            log.error("ERROR en findTributosByCod", e);
        }
        return resultado;
    }

    public List<Contribuyentes> findAllEmisores() {
        List<Contribuyentes> resultado = new ArrayList<>();
        try {
            resultado = em.createQuery("from Contribuyentes c where c.rucTipoContribuyente = 'EMISOR'").getResultList();
        } catch (Exception e) {
            log.error("error findAllEmisores " + e.getMessage());
        }
        return resultado;
    }

    public List<Contribuyentes> findAllReceptoresByIdEmp(Integer idEmp) {
        List<Contribuyentes> resultado = new ArrayList<>();
        try {
            resultado = em.createQuery("from Contribuyentes c where c.rucTipoContribuyente = 'RECEPTOR'").getResultList();
        } catch (Exception e) {
            log.error("error findAllEmisores " + e.getMessage());
        }
        return resultado;
    }

    public List<CatalogoCondicionOperacion> findAllCondicionesOp() {
        List<CatalogoCondicionOperacion> resultado = new ArrayList<>();
        try {
            resultado = em.createQuery("from CatalogoCondicionOperacion").getResultList();
        } catch (Exception e) {
            log.error("error findAllCondicionesOp " + e.getMessage());
        }
        return resultado;
    }

    public List<CatalogoPlazos> findAllCatalogoPlazos() {
        List<CatalogoPlazos> resultado = new ArrayList<>();
        try {
            resultado = em.createQuery("from CatalogoPlazos ").getResultList();
        } catch (Exception e) {
            log.error("error findAllCatalogoPlazos " + e.getMessage());
        }
        return resultado;
    }

    public List<CatalogoFormaPago> findAllCatalogoFormaPago() {
        List<CatalogoFormaPago> resultado = new ArrayList<>();
        try {
            resultado = em.createQuery("from CatalogoFormaPago ").getResultList();
        } catch (Exception e) {
            log.error("error findAllCatalogoFormaPago " + e.getMessage());
        }
        return resultado;
    }

    public List<UnidadesMedida> findAllUnidadesMedida() {
        List<UnidadesMedida> resultado = new ArrayList<>();
        try {
            resultado = em.createQuery("from UnidadesMedida ").getResultList();
        } catch (Exception e) {
            log.error("error findAllUnidadesMedida " + e.getMessage());
        }
        return resultado;
    }

    public int findTipoDocById(Integer id) {
        int tipoDoc = 36;
        TiposDocumentos result;
        try {
            Query query = em.createQuery("from TiposDocumentos td where td.id = :codigo", TiposDocumentos.class);
            query.setParameter("codigo", id);
            result = (TiposDocumentos) query.getSingleResult();
            tipoDoc = result.getDocIdtipoDocumento();
        } catch (Exception e) {
            log.error("error en findTipoDocById", e);
        }
        return tipoDoc;
    }

    public Factura findFacturaByNum(String nroComprobante) {
        Factura resultado = new Factura();
        try {
            Query query = em.createQuery("from Factura f where f.facNroFactura = :nroFactura", Factura.class);
            query.setParameter("nroFactura", nroComprobante);
            resultado = (Factura) query.getSingleResult();
        } catch (Exception e) {
            log.error("error findFacturaByNum " + e.getMessage());
        }
        return resultado;
    }

    public Factura updatePeriodoFactura(Date fechaIni, Date fechaFin, Factura factura) {
        try {
            em.find(Factura.class, factura.getFacId());
            factura.setFacFechaIniPeriodo(fechaIni);
            factura.setFacFechaFinPeriodo(fechaFin);
            em.merge(factura);
        } catch (Exception e) {
            log.error("error en updatePeriodoFactura: " + e.getMessage());
        }
        return factura;
    }

    public String findFacturaById(Integer id) {
        String periodo;
        try {
            Factura factura = em.find(Factura.class, id);
            if (factura.getFacObservaciones() == null) {
                periodo = "Fecha del Periodo del " + ViewUtils.formatoFecha(factura.getFacFechaIniPeriodo()) + " al "
                        + ViewUtils.formatoFecha(factura.getFacFechaFinPeriodo());
            } else {
                periodo = factura.getFacObservaciones();
            }
            return periodo;
        } catch (Exception e) {
            log.error("ERROR en findFacturaById", e);
            return null;
        }
    }

    public ParametrosMh findParametrosByNitEmisor(String nitEmisor) {
        ParametrosMh result;
        try {
            Query query = em.createQuery("from ParametrosMh p where p.pmJsonFirmadorNit = :nitEmisor and p.pmId = 1", ParametrosMh.class);
            query.setParameter("nitEmisor", nitEmisor);
            result = (ParametrosMh) query.getSingleResult();
        } catch (Exception e) {
            log.error("ERROR en findParametrosByNitEmisor", e);
            return null;
        }
        return result;
    }

    //ANULACION
    public List<CatalogoTipoInvalidacion> findAllTiposInvalidacion() {
        List<CatalogoTipoInvalidacion> resultado = new ArrayList<>();
        try {
            resultado = em.createQuery("from CatalogoTipoInvalidacion ").getResultList();
        } catch (Exception e) {
            log.error("error findAllTiposInvalidacion " + e.getMessage());
        }
        return resultado;
    }

    public GenericResponse insertAnulacion(String motivo, int facId, int tipo, String codigoN, LoginBean login) {
        GenericResponse respuesta = new GenericResponse();
        try {
            log.info("ejecutando proceso pro_inserta_anulacion, usuario " + login.getUsuario());
            StoredProcedureQuery storedProcedureQuery = em.createStoredProcedureQuery("pro_inserta_anulacion");

            storedProcedureQuery.registerStoredProcedureParameter(1, String.class, ParameterMode.IN);
            storedProcedureQuery.registerStoredProcedureParameter(2, Integer.class, ParameterMode.IN);
            storedProcedureQuery.registerStoredProcedureParameter(3, Integer.class, ParameterMode.IN);
            storedProcedureQuery.registerStoredProcedureParameter(4, String.class, ParameterMode.IN);

            storedProcedureQuery.registerStoredProcedureParameter(5, Integer.class, ParameterMode.OUT);
            storedProcedureQuery.registerStoredProcedureParameter(6, String.class, ParameterMode.OUT);

            storedProcedureQuery.setParameter(1, motivo);
            storedProcedureQuery.setParameter(2, facId);
            storedProcedureQuery.setParameter(3, tipo);
            storedProcedureQuery.setParameter(4, codigoN != null ? codigoN : "");

            storedProcedureQuery.execute();

            respuesta.setVal((Integer) storedProcedureQuery.getOutputParameterValue(5));
            respuesta.setMensaje((String) storedProcedureQuery.getOutputParameterValue(6));

        } catch (Exception e) {
            log.error("ERROR en insertAnulacion", e);
            respuesta.setMensaje("Ocurrió un error al procesar datos, verifique ó contacte a Sertracen");
            respuesta.setVal(1);
        }
        return respuesta;
    }

    public JsonObject getJsonToInvalidate(String tipoFact, String nroFact) {
        String json = "";
        try {
            Query query = em.createNativeQuery("SELECT fun_retorna_json(:param1, :param2)");
            query.setParameter("param1", tipoFact);
            query.setParameter("param2", nroFact);

            json = (String) query.getSingleResult();

            log.info("json to invalidate: " + json);
            return JsonParser.parseString(json).getAsJsonObject();

        } catch (JsonSyntaxException e) {
            log.error("ERROR en getJsonToInvalidate", e);
            return null;
        }
    }

    public Factura searchFacturaById(Integer idFactura) {
        Factura resultado = new Factura();
        try {
            Query query = em
                    .createQuery("from Factura f where f.facId = :idFactura", Factura.class);
            query.setParameter("idFactura", idFactura);
            resultado = (Factura) query.getSingleResult();
        } catch (Exception e) {
            log.error("error searchFacturaById " + e.getMessage());
        }
        return resultado;
    }

    public GenericResponse callProValidaIngreso(String nroDocumento) {
        GenericResponse response = new GenericResponse();
        try {
            StoredProcedureQuery storedProcedureQuery = em.createStoredProcedureQuery("pro_valida_ingreso");
            storedProcedureQuery.registerStoredProcedureParameter(1, String.class, ParameterMode.IN);
            storedProcedureQuery.registerStoredProcedureParameter(2, Integer.class, ParameterMode.OUT);
            storedProcedureQuery.registerStoredProcedureParameter(3, String.class, ParameterMode.OUT);
            storedProcedureQuery.setParameter(1, nroDocumento);
            storedProcedureQuery.execute();

            response.setVal((Integer) storedProcedureQuery.getOutputParameterValue(2));
            response.setMensaje((String) storedProcedureQuery.getOutputParameterValue(3));

        } catch (Exception e) {
            log.error("ERROR en callProValidaIngreso", e);
            response.setVal(1);
            response.setMensaje(e.getMessage());
        }

        return response;
    }

    private Boolean sendDte(String to, String subject, String body, byte[] bDtePdf, byte[] bDteJson) {
        Boolean result = Boolean.FALSE;
        try {

            MailDto mailDto = new MailDto();

            mailDto.setBody(body);
            mailDto.setMfa(null);
            mailDto.setSubject(subject);
            mailDto.setTo("miguelsr1@gmail.com");

            MailAttachment dtePdf = new MailAttachment();

            dtePdf.setBase64(Base64.getEncoder().encodeToString(bDtePdf));
            dtePdf.setFileName("dte.pdf");
            dtePdf.setMimeType("application/pdf");

            MailAttachment dteJson = new MailAttachment();

            dteJson.setBase64(Base64.getEncoder().encodeToString(bDteJson));
            dteJson.setFileName("dte.json");
            dteJson.setMimeType("application/json");

            mailDto.getFiles().add(dtePdf);
            mailDto.getFiles().add(dteJson);

            Gson gson = new Gson();
            HttpClient httpClient = HttpClient.newHttpClient();
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(new URI(RESOURCE_BUNDLE.getString("greeting.mail.url")))
                    .headers("Content-Type", "application/json;charseT=UTF-8")
                    .POST(HttpRequest.BodyPublishers.ofString(gson.toJson(mailDto)))
                    .build();

            HttpResponse response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
            if (response.statusCode() == 200) {
                result = Boolean.TRUE;
            } else {
                log.error("response error: " + response.statusCode() + ", full response: " + response);
            }

        } catch (URISyntaxException | IOException | InterruptedException e) {
            log.error("Error enviando email: " + e.getMessage());
        }
        return result;
    }

    public GenericResponse callProValidaDocRelacionado(Buzoncsv factura) {
        GenericResponse response = new GenericResponse();
        try {
            StoredProcedureQuery storedProcedureQuery = em.createStoredProcedureQuery("pro_valida_documento_rel");
            storedProcedureQuery.registerStoredProcedureParameter(1, String.class, ParameterMode.IN);
            storedProcedureQuery.registerStoredProcedureParameter(2, String.class, ParameterMode.IN);
            storedProcedureQuery.registerStoredProcedureParameter(3, Integer.class, ParameterMode.OUT);
            storedProcedureQuery.registerStoredProcedureParameter(4, String.class, ParameterMode.OUT);

            storedProcedureQuery.setParameter(1, factura.getDocRelacionado());
            storedProcedureQuery.setParameter(2, factura.getTipoDocRelacionado());

            storedProcedureQuery.execute();

            response.setVal((Integer) storedProcedureQuery.getOutputParameterValue(3));
            response.setMensaje((String) storedProcedureQuery.getOutputParameterValue(4));

        } catch (Exception e) {
            log.error("ERROR en callProValidaDocRelacionado", e);

            response.setVal(1);
            response.setMensaje(e.getMessage());
        }
        return response;
    }

    public GenericResponse callProTicketCortesia(Integer correlativo, LoginDto login, String app) {
        GenericResponse response = new GenericResponse();
        try {
            StoredProcedureQuery storedProcedureQuery = em.createStoredProcedureQuery("pro_ticket_cortesia");
            storedProcedureQuery.registerStoredProcedureParameter(1, Integer.class, ParameterMode.IN);
            storedProcedureQuery.registerStoredProcedureParameter(2, String.class, ParameterMode.IN);
            storedProcedureQuery.registerStoredProcedureParameter(3, String.class, ParameterMode.IN);
            storedProcedureQuery.registerStoredProcedureParameter(4, Integer.class, ParameterMode.OUT);
            storedProcedureQuery.registerStoredProcedureParameter(5, String.class, ParameterMode.OUT);

            storedProcedureQuery.setParameter(1, correlativo);
            storedProcedureQuery.setParameter(2, login.getUsuario());
            storedProcedureQuery.setParameter(3, app);

            storedProcedureQuery.execute();

            response.setVal((Integer) storedProcedureQuery.getOutputParameterValue(4));
            response.setMensaje((String) storedProcedureQuery.getOutputParameterValue(5));

        } catch (Exception e) {
            log.error("ERROR en callProTicketCortesia", e);

            response.setVal(1);
            response.setMensaje(e.getMessage());
        }
        return response;
    }

    public Contribuyentes findEmisorByNit(String nit) {
        Contribuyentes resultado = null;
        resultado = (Contribuyentes) em
                .createQuery("from Contribuyentes c where c.rucTipoContribuyente = 'RECEPTOR' and c.rucNitContribuyente = :nit")
                .setParameter("nit", nit)
                .getSingleResult();
        return resultado;
    }

    public List<ExcelFileDTO> findFacturasExcel(java.sql.Date fechaIni, java.sql.Date fechaFin) {
        Query query = em.createNativeQuery("SELECT estado,tcp_comprobante as documento,DATE(fac_fecha_emision) as fecha,TIME(fac_fecha_emision) as hora,fac_numero_de_control as control,\n"
                + "fac_codigo_generacion as codigoGeneracion, selloRecibido as selloRecepcion, fac_nit_receptor as identificacionReceptor, fac_razonsocial as nombre, Valor as condicionVenta, '1.00' as tipoCambio, \n"
                + "(SELECT pgn_valor FROM fact.parametros_generales where pgn_campo='tipoMoneda') as moneda, fac_total_iva as montoImpuesto,fac_montototaloperacion as montoTotal, det_fac_cantidad, "
                + "det_fac_preciounitario,(select cp_codigo_brilo from catalogo_productos where codigo_prod = det_codigo) as det_codigo, fac_fecha_emision, det_fac_descripcion, (select us_usuario from usuarios where us_id = fac_us_id_usuario) as usuario\n"
                + "FROM fact.factura f, fact.bitacora_declaracion_hacienda b,fact.tipos_comprobantes c, fact.catalogo_condicion_operacion o, "
                + "fact.factura_detalle fd\n"
                + "where DATE(f.fac_fecha_emision) between ? and ? \n"
                + "and b.id_fac=f.fac_id and c.tcp_idtipcom=f.fac_tipo_comprobante and o.idcondicion_operacion=f.fac_condicion_operacion and f.fac_id = fd.det_fac_id");
        query.setParameter(1, fechaIni);
        query.setParameter(2, fechaFin);

        List<Object[]> resultList = query.getResultList();
        List<ExcelFileDTO> dtos = new ArrayList<>();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm:ss");
        SimpleDateFormat dateTimeFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        for (Object[] row : resultList) {
            ExcelFileDTO dto = new ExcelFileDTO();
            dto.setEstado((String) row[0]);
            dto.setDocumento((String) row[1]);
            java.sql.Date date = (java.sql.Date) row[2];
            String formattedDate = dateFormat.format(date);
            dto.setFecha(formattedDate);
            Time time = (Time) row[3];
            String formattedTime = timeFormat.format(time);
            dto.setHora(formattedTime);
            dto.setControl((String) row[4]);
            dto.setCodigoGeneracion((String) row[5]);
            dto.setSelloRecepcion((String) row[6]);
            dto.setIdentificacionReceptor((String) row[7]);
            dto.setNombre((String) row[8]);
            dto.setCondicionVenta((String) row[9]);
            dto.setTipoCambio((String) row[10]);
            dto.setMoneda((String) row[11]);
            BigDecimal impuesto = (BigDecimal) row[12];
            dto.setMontoImpuesto(impuesto);
            BigDecimal total = (BigDecimal) row[13];
            dto.setMontoTotal(total);
            dto.setDetFacCantidad(String.valueOf(row[14]));
            dto.setDetFacPreciounitario((BigDecimal) row[15]);
            dto.setDetCodigo((String) row[16]);
            Timestamp tm = (Timestamp) row[17];
            String dateTimeFor = dateTimeFormat.format(tm);
            dto.setFacFechaEmision(dateTimeFor);
            dto.setDetFacDescripcion((String) row[18]);
            dto.setUsuario((String) row[19]);
            dtos.add(dto);
        }
        return dtos;
    }

    public GenericResponse validarSchema(JsonObject jsonDte, String schemaName) {
        GenericResponse respuesta = new GenericResponse();
        String jsonPath = "";
        String propertyName = System.getProperty("os.name").toUpperCase().contains("WINDOWS") ? "FOLDER_JSON_FILES_WINDOWS" : "FOLDER_JSON_FILES_LINUX";
        jsonPath = ResourceBundle.getBundle("bundle").getString(propertyName).replace("${user.name}", System.getProperty("user.name"));
        log.info("jsonPath " + jsonPath + " schema: " + schemaName);
        ObjectMapper objectMapper = new ObjectMapper();
        JsonSchemaFactory schemaFactory = JsonSchemaFactory.getInstance(SpecVersion.VersionFlag.V7);
        try {
            FileWriter fw = new FileWriter(jsonPath + File.separator + "dteJson" + SUFFIX, StandardCharsets.UTF_8);
            fw.write(jsonDte.toString());
            fw.flush();
            fw.close();
        } catch (IOException e) {
            log.error("ERROR en validarSchema", e);

            respuesta.setVal(1);
            respuesta.setMensaje(e.getMessage());
        }
        try (InputStream schemaStream = new FileInputStream(jsonPath + File.separator + schemaName); InputStream jsonStream = new FileInputStream(jsonPath + File.separator + "dteJson.json")) {
            jsonStreamToJsonNode(respuesta, objectMapper, schemaFactory, schemaStream, jsonStream);

        } catch (Exception e) {
            log.error("ERROR en validarSchema-2", e);
            respuesta.setVal(1);
            respuesta.setMensaje("Error " + e.getMessage());
        }
        return respuesta;
    }

    private static void jsonStreamToJsonNode(GenericResponse respuesta, ObjectMapper objectMapper, JsonSchemaFactory schemaFactory, InputStream schemaStream, InputStream jsonStream) throws IOException {
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
            validationResult.forEach(vm -> builder.append(vm.getMessage()));

            respuesta.setMensaje(builder.toString());
        }
    }

    public JsonObject getFirmaDocu(JsonObject jsonDte, ParametrosMh pmh) {
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
            log.info("respuesta firmardocumento MH" + response.body());
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

    public JsonObject getAuthorization(ParametrosMh pmh) {
        log.info("getAuthorization method ");
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

    //Proceso generico para envío de correos utilizando mailSession
    public boolean sendMail(EmailDTO emailDTO) {
        boolean enviado = Boolean.FALSE;
        try {
            MimeMessage m = new MimeMessage(mailSession);
            m.setFrom(new InternetAddress("no-reply@sertracen.com", "Sertracen El Salvador"));
            m.addRecipient(Message.RecipientType.TO, new InternetAddress(emailDTO.getTo()));
            //Agregar otros recipientes
            addRecipients(emailDTO, m);
            m.setSubject(emailDTO.getSubject());
            m.setSentDate(new Date());
            Multipart multipart = new MimeMultipart();
            MimeBodyPart messageBodyPart = new MimeBodyPart();
            messageBodyPart.setText(emailDTO.getBody(), "utf-8", "html");
            multipart.addBodyPart(messageBodyPart);

            if (emailDTO.getAttachmentPDF() != null) {
                InputStream isArray = new ByteArrayInputStream(emailDTO.getAttachmentPDF());
                MimeBodyPart attach = new MimeBodyPart();
                ByteArrayDataSource ds = new ByteArrayDataSource(isArray, "application/pdf");
                attach.setDataHandler(new DataHandler(ds));
                attach.setFileName(emailDTO.getAttachNamePDF());
                multipart.addBodyPart(attach);
            }

            if (emailDTO.getAttachmentJson() != null) {
                InputStream isArray = new ByteArrayInputStream(emailDTO.getAttachmentJson());
                MimeBodyPart attach = new MimeBodyPart();
                ByteArrayDataSource ds = new ByteArrayDataSource(isArray, "application/json");
                attach.setDataHandler(new DataHandler(ds));
                attach.setFileName(emailDTO.getAttachNameJson());
                multipart.addBodyPart(attach);
            }

            m.setContent(multipart);
            Transport.send(m);
            log.info("usuario : " + emailDTO.getUsuario() + " enviando correo a " + emailDTO.getTo());
            enviado = Boolean.TRUE;
        } catch (IOException | MessagingException e) {
            log.error("ERROR en sendMail", e);
        }
        return enviado;
    }

    private MimeMessage addRecipients(EmailDTO emailDTO, MimeMessage m) {
        try {
            //Agregar copia
            if (emailDTO.getCc() != null && !emailDTO.getBcc().trim().isEmpty()) {
                String[] correosArray = emailDTO.getCc().split(",");
                InternetAddress[] direcciones = Arrays.stream(correosArray)
                        .map(correo -> {
                            try {
                                return new InternetAddress(correo.trim());
                            } catch (javax.mail.internet.AddressException e) {
                                log.error("ERROR en addRecipients", e);
                                return null;
                            }
                        })
                        .toArray(InternetAddress[]::new);
                m.addRecipients(Message.RecipientType.CC, direcciones);
            }
            //Agregar copia oculta
            if (emailDTO.getBcc() != null && !emailDTO.getBcc().trim().isEmpty()) {
                String[] correosArray = emailDTO.getBcc().split(",");
                InternetAddress[] direcciones = Arrays.stream(correosArray)
                        .map(correo -> {
                            try {
                                return new InternetAddress(correo.trim());
                            } catch (javax.mail.internet.AddressException e) {
                                log.error("ERROR en addRecipients-2", e);
                                return null;
                            }
                        })
                        .toArray(InternetAddress[]::new);
                m.addRecipients(Message.RecipientType.BCC, direcciones);
            }
        } catch (MessagingException e) {
            log.error("ERROR en addRecipients-3", e);
        }
        return m;
    }

    public boolean procesarRespuestaMh(JsonObject jsonFromMh, ParametrosMh parametrosMh, GeneracionJson genJson, Factura factura, String observaciones) throws IOException {
        log.info(jsonFromMh.get("estado").getAsString().concat(jsonFromMh.get("descripcionMsg").getAsString() != null ? " - " + jsonFromMh.get("descripcionMsg").getAsString() : " - SIN OBSERVACIONES"));
        String finProcesamiento = jsonFromMh.get("fhProcesamiento").getAsString();

        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm:ss");
        LocalDateTime dateTime = LocalDateTime.parse(finProcesamiento, dtf);

        DateTimeFormatter outputFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        String outputDateToString = dateTime.format(outputFormatter);

        String link = null;

        if (genJson.getCodigoGeneracion() != null) {
            link = parametrosMh.getPmQrLink() + parametrosMh.getPmJsonFesvMhAmbiente() + "&codGen="
                    + genJson.getCodigoGeneracion() + "&fechaEmi=" + outputDateToString;
        }

        PersistMHResponse(String.valueOf(factura.getFacId()),
                jsonFromMh.get("estado").getAsString(),
                jsonFromMh.get("selloRecibido").getAsString().isEmpty() ? null : jsonFromMh.get("selloRecibido").getAsString(),
                genJson.getCodigoGeneracion().isEmpty() ? null : genJson.getCodigoGeneracion(),
                genJson.getJson(),
                link,
                outputDateToString);

        if (jsonFromMh.get("codigoMsg").getAsString().equals("001") || jsonFromMh.get("codigoMsg").getAsString().equals("002")) {
            String mail;
            Contribuyentes receptor = findEmisorByNit(factura.getFacNitReceptor());
            mail = receptor.getRucEmailContribuyente();
            EmailDTO request = new EmailDTO();
            request.setTo(mail);
            request.setUsuario("CRONEXAMVISUALDTE");
            request.setAttachmentPDF(construirPdf(factura, observaciones));
            request.setAttachNamePDF("Factura Electrónica - " + jsonFromMh.get("codigoGeneracion").getAsString() + ".pdf");
            request.setAttachmentJson(construirJson(genJson.getJson(), jsonFromMh.get("codigoGeneracion").getAsString()));
            request.setAttachNameJson(jsonFromMh.get("codigoGeneracion").getAsString() + ".json");
            request.setBody(getBodyMailToSendReport(String.valueOf(factura.getFacId())));
            request.setSubject("Factura Electrónica DTE " + jsonFromMh.get("codigoGeneracion").getAsString());
            if (sendMail(request)) {
                log.info("Correo enviado correctamente a: " + mail);
                return true;
            } else {
                log.info("falló el envío de correo a: " + mail);
                return false;
            }
        }
//        }
        return false;
    }

    private byte[] construirPdf(Factura factura, String observaciones) {
        Map<String, Object> hm = new HashMap<>();
        hm.put("PNRO_FACTURA", factura.getFacId().toString());
        hm.put("PLOGO", pathImg);
        hm.put("POBSERVACIONES", factura.getFacObservaciones() != null ? factura.getFacObservaciones() : observaciones);
        log.info("path reporte: " + reportPath);
        log.info("fecha emision en factura: " + ViewUtils.formatoFecha(factura.getFacFechaEmision()));
        try {
            return jr.getReportToPdf(reportPath, hm, factura.getFacTipoComprobante().matches("07") ? "REPCOMPRET" : "REPNOTAREMELEC");
        } catch (SQLException | NamingException e) {
            log.error("ERROR en construirPdf", e);
            return null;
        }
    }

    private byte[] construirJson(JsonObject jsonObject, String nameJsonFile) throws IOException {
        byte[] result;
        final File tempFile = File.createTempFile(nameJsonFile, SUFFIX);
        String str = jsonObject.toString();
        InputStream in = new ByteArrayInputStream(str.getBytes());
        tempFile.deleteOnExit();
        try (FileOutputStream out = new FileOutputStream(tempFile)) {
            IOUtils.copy(in, out);
        } catch (Exception e) {
            log.error("ERROR en construirJson", e);
        }
        FileInputStream fis = new FileInputStream(tempFile);
        result = new byte[(int) tempFile.length()];
        fis.read(result);
        fis.close();
        return result;
    }

    public Factura recuperarFacturaById(Integer id) {
        Factura factura;
        try {
            factura = em.find(Factura.class, id);
        } catch (Exception e) {
            log.error("ERROR en construirJson-2", e);
            return null;
        }
        return factura;
    }

    public List getInfoDte(Long idFact) {
        Query q = em.createNativeQuery(QueryUtils.INFO_DTE);
        q.setParameter("idFac", idFact);
        return q.getResultList();
    }
}
