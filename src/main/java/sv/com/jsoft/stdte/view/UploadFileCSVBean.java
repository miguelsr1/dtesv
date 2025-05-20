package sv.com.jsoft.stdte.view;

import com.google.gson.*;
import com.opencsv.bean.CsvToBeanBuilder;
import io.github.millij.poi.ss.reader.XlsxReader;
import lombok.Getter;
import lombok.Setter;
import org.apache.commons.io.IOUtils;
import org.apache.log4j.Logger;
import org.primefaces.PrimeFaces;
import org.primefaces.event.FileUploadEvent;
import org.primefaces.model.file.UploadedFile;
import sv.com.jsoft.stdte.dto.FacturaDTO;
import sv.com.jsoft.stdte.dto.FirmaResponse;
import sv.com.jsoft.stdte.dto.GenericResponse;
import sv.com.jsoft.stdte.model.csv.PlantillaSV;
import sv.com.jsoft.stdte.model.json.DteJson;
import sv.com.jsoft.stdte.model.json.GeneracionJson;
import sv.com.jsoft.stdte.model.json.JsonRequest;
import sv.com.jsoft.stdte.model.json.JsonResponse;
import sv.com.jsoft.stdte.persistence.Buzoncsv;
import sv.com.jsoft.stdte.persistence.Factura;
import sv.com.jsoft.stdte.persistence.ParametrosMh;
import sv.com.jsoft.stdte.persistence.TiposComprobantes;
import sv.com.jsoft.stdte.repository.AppService;
import sv.com.jsoft.stdte.utils.ViewUtils;

import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.faces.application.FacesMessage;
import javax.faces.context.FacesContext;
import javax.faces.view.ViewScoped;
import javax.inject.Inject;
import javax.inject.Named;
import javax.json.Json;
import javax.servlet.ServletContext;
import javax.swing.text.View;
import java.io.*;
import java.math.BigDecimal;
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

@ViewScoped
@Named("upload")
public class UploadFileCSVBean implements Serializable {

    @EJB
    private AppService service;

    @Getter
    @Setter
    private String uploadOutcome, email, tipodoc;

    @Getter
    @Setter
    private int success = 0, failed = 0, progressId = 0;

    @Getter
    @Setter
    private List<PlantillaSV> plantillaLs = new ArrayList<>();

    @Getter
    @Setter
    private List<Factura> facturasLs = new ArrayList<>();

    @Getter
    @Setter
    private Factura itemSelected;

    @Getter
    @Setter
    private List<Factura> facturasProcLs = new ArrayList<>();

    @Inject
    LoginBean loginBean;

    GeneracionJson genJson;
    JsonRequest jsonRequest;

    protected static final Logger logger = Logger.getLogger(UploadFileCSVBean.class);

    public static final String PREFIX = "stream2file";
    public static final String SUFFIX = ".xlsx";
    public static final String APP = "PROCARGACSV";

    @Getter
    @Setter
    private Date fechaInicio, fechaFin;

    @Getter
    @Setter
    private List<TiposComprobantes> tiposComprobantesLs;

    @Getter
    @Setter
    private ParametrosMh pmh;

    @PostConstruct
    public void init() {
        tiposComprobantesLs = service.findAllTiposComprobantes();
        itemSelected = new Factura();
    }

    public void handleFileUpload(FileUploadEvent event) {
        UploadedFile file = event.getFile();
        List<PlantillaSV> lista;
        if (file != null && file.getContent() != null && file.getContent().length > 0 && file.getFileName() != null) {
            if (file.getFileName().endsWith("xlsx")) {
                //PROCESO DE LECTURA Y PERSISTENCIA DE ARCHIVO XLSX EN LA BASE DE DATOS
                try {
                    InputStream inputStream = file.getInputStream();
                    File xlsxFile = stream2File(inputStream);
                    XlsxReader reader = new XlsxReader();
                    lista = reader
                            .read(PlantillaSV.class, xlsxFile);
                    plantillaLs = lista;
                    logger.info("Registros totales: " + plantillaLs.size());
                    if (plantillaLs.size() > 0) {
                        logger.info("persistiendo registros en tabla buzoncsv ");
                        int[] resultado = insertIntoBuzonCsv();
                        if (resultado[0] > 0) {
                            GenericResponse genericResponse = procesoCargaFacturas();
                            if (genericResponse.getVal() == 0) {
                                facturasLs = buscarFacturasPendProc();
                                FacesMessage message = new FacesMessage("Mensaje ",
                                        event.getFile().getFileName() + " Archivo procesado, se insertaron " + resultado[0] + " registros con éxito \n " +
                                                "Fallaron " + resultado[1] + " registros.");
                                FacesContext.getCurrentInstance().addMessage(null, message);
                            }
                        }
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }

                //PROCESO CARGA FACTURAS SIN PASAR POR PROCESAMIENTO DE XLSX PARA PRUEBAS
//                GenericResponse genericResponse = procesoCargaFacturas();
//                if (genericResponse.getVal() == 0) {
//                    logger.info("Proceso carga facturas ejecutado correctamente, realizar busqueda de facturas pendientes de procesar");
//                    facturasLs = buscarFacturasPendProc();
//                }//FIN PROCESO CARGA FACTURAS

            } else {
                try {
                    List<PlantillaSV> facturas = new CsvToBeanBuilder(new InputStreamReader(file.getInputStream(), StandardCharsets.UTF_8))
                            .withType(PlantillaSV.class)
                            .build()
                            .parse();
                    plantillaLs = facturas.stream().skip(2).collect(Collectors.toList());
                    logger.info("Registros: ");
                    plantillaLs.forEach(c -> System.out.println(c.toString()));
                    update("mainFrm");
                } catch (Exception e) {
                    logger.error(e.getMessage());
                }
                FacesMessage message = new FacesMessage("Mensaje ",
                        event.getFile().getFileName() + " Archivo cargado correctamente con " + plantillaLs.size() + " éxito");
                FacesContext.getCurrentInstance().addMessage(null, message);
            }
        }
    }

    public File stream2File(InputStream in) throws IOException {
        final File tempFile = File.createTempFile(PREFIX, SUFFIX);
        tempFile.deleteOnExit();
        try (FileOutputStream out = new FileOutputStream(tempFile)) {
            IOUtils.copy(in, out);
        }
        return tempFile;
    }

    private void update(String component) {
        PrimeFaces.current().ajax().update(component);
    }

    //Persist Data into BuzonCsv
    private int[] insertIntoBuzonCsv() {
        int[] resultado = new int[2];

        plantillaLs.forEach(c -> {
            int proc = 0;
            Buzoncsv buzoncsv = new Buzoncsv();
            buzoncsv.setCodFactura(c.getDocumento());
            buzoncsv.setCodEmisor(c.getCodEmisor());
            buzoncsv.setTipodoc(c.getTipoDoc());
            buzoncsv.setTipodocrec(Integer.parseInt(c.getTipoDocRec()));
            buzoncsv.setNit(c.getNit());
            buzoncsv.setNrc(Integer.parseInt(c.getNrc()));
            buzoncsv.setNombrecliente(c.getNombreCliente());
            buzoncsv.setCorreo(c.getCorreo());
            buzoncsv.setTelefono(c.getTelefono());
            buzoncsv.setMoneda(c.getMoneda());
            buzoncsv.setTipocambio(Integer.parseInt(c.getTipoCambio()));
            buzoncsv.setDepart(c.getDepart());
            buzoncsv.setMunicipio(Integer.parseInt(c.getMunicipio()));
            buzoncsv.setComplemento(c.getComplemento());
            buzoncsv.setCodactcom(c.getCodActCom());
            buzoncsv.setCodigo(c.getCodigo());
            buzoncsv.setDetalle(c.getDetalle());
            buzoncsv.setUnidadMedida(Integer.parseInt(c.getUnidadMedida()));
            buzoncsv.setTipo(Integer.parseInt(c.getTipo()));
            buzoncsv.setCantidad(new BigDecimal(c.getCantidad()));
            buzoncsv.setPrecioUnitario(c.getPrecioUnitario());
            buzoncsv.setDescuento(new BigDecimal(c.getDescuento()));
            buzoncsv.setExento(c.getExento());
            buzoncsv.setCodigoImp(Integer.valueOf(c.getCodigoImp()));
            buzoncsv.setPorcentaje(Integer.parseInt(c.getPorcentaje()));
            buzoncsv.setValor(c.getValor());
            buzoncsv.setCondicionpago(Integer.parseInt(c.getCondicionPago()));
            buzoncsv.setMediopago(c.getMedioPago());
            buzoncsv.setReferencia(c.getReferencia());
            buzoncsv.setPlazo(c.getPlazo());
            buzoncsv.setPeriodo(c.getPeriodo());
            buzoncsv.setTipogeneracion(c.getTipoGeneracion());
            buzoncsv.setTipodte(c.getTipoDte());
            buzoncsv.setNumeroautorizacion(c.getNumeroAutorizacion());
            buzoncsv.setFechahoraemision(c.getFechaHoraEmision());
            buzoncsv.setTipodocidreceptor(c.getTipoDocIdReceptor());
            buzoncsv.setMonto(c.getMonto());
            email = c.getCorreo();
            proc = service.PersistBuzonCsv(buzoncsv);
            if (proc > 0)
                resultado[0]++; //incrementar procesados
            else
                resultado[1]++; //incrementar noprocesados
        });

        return resultado;

    }

    private GenericResponse procesoCargaFacturas() {
        GenericResponse respuesta;
        respuesta = service.ejecutarProcesoCargaFacturas(APP, loginBean.getLogin());
        return respuesta;
    }

    private List<Factura> buscarFacturasPendProc() {
        List<Factura> response;
        response = service.findAllFacturas();
        logger.info("total facturas: " + response.size());
        update("mainFrm");
        return response;
    }

    public synchronized void processFactura(Factura item) {
        try {
            TiposComprobantes tiposComprobantes = service.findComprobanteById(item.getFacTipoComprobante());
            logger.info("procesando factura nro: " + item.getFacNroFactura() + " , " +
                    "tipo: " + item.getFacTipoComprobante() + " - " + tiposComprobantes.getTcpComprobante() + " , idFactura: " + item.getFacId());
            genJson = new GeneracionJson();
            genJson = service.callGenerateJson(tiposComprobantes.getTcpComprobante(), String.valueOf(item.getFacId()));
            if (genJson != null) {
                //logger.info("json from database: " + genJson);
                JsonObject jsonObject = getFirmaDocumento(genJson.getJson());
                if (jsonObject != null) {
                    if (jsonObject.get("status").getAsString().equals("OK")) {
                        String token;
                        JsonObject jsonAuth = getAuth();
                        if (jsonAuth.get("status").getAsString().equals("OK")) {
                            token = jsonAuth.getAsJsonObject("body").get("token").getAsString();
                            //logger.info("token " + token);
                            String uuid = genJson.getCodigoGeneracion();
                            JsonObject jsonFromMh = getProcesarMh(jsonObject.get("body"), uuid, token);

                            assert jsonFromMh != null;
                            if (jsonFromMh.get("estado").getAsString() != null) {
                                if (jsonFromMh.get("estado").getAsString().equalsIgnoreCase("PROCESADO")) {
                                    String finProcesamiento = jsonFromMh.get("fhProcesamiento").getAsString();

                                    DateTimeFormatter dtf = DateTimeFormatter.ofPattern("d/MM/yyyy HH:mm:ss");
                                    LocalDateTime dateTime = LocalDateTime.parse(finProcesamiento,dtf);

                                    DateTimeFormatter outputFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
                                    String outputDateToString = dateTime.format(outputFormatter);

                                    String link = pmh.getPmQrLink() + pmh.getPmJsonFesvMhAmbiente() + "&codGen="
                                            + genJson.getCodigoGeneracion() + "&fechaEmi=" + outputDateToString;
                                    GenericResponse response = service.PersistMHResponse(
                                            String.valueOf(item.getFacId()),
                                            jsonFromMh.get("estado").getAsString(),
                                            jsonFromMh.get("selloRecibido").getAsString(),
                                            genJson.getCodigoGeneracion(),
                                            genJson.getJson(),
                                            link,finProcesamiento);
                                    if (response.getVal() == 0) {
                                        String nameJsonFile = jsonFromMh.get("codigoGeneracion").getAsString();
                                        sendMail(String.valueOf(item.getFacId()), genJson.getJson(), nameJsonFile, item.getFacTipoComprobante());
                                        FacesMessage message = new FacesMessage("MENSAJE APLICACIÓN ", " DOCUMENTO PROCESADO, SE HA ENVIADO A SU CORREO LA FACTURA DIGITAL");
                                        FacesContext.getCurrentInstance().addMessage(null, message);
                                        addFacturaProcesada(item);
                                        //update("mainFrm");
                                    }
                                } else {
                                    FacesMessage message = new FacesMessage("MENSAJE APLICACIÓN ", "FALLO AL INTENTAR PROCESAR DOCUMENTO");
                                    FacesContext.getCurrentInstance().addMessage(null, message);
                                    update("mainFrm");
                                }
                            } else {
                                FacesMessage message = new FacesMessage("MENSAJE APLICACIÓN ", "NO SE PROCESO DOCUMENTO, "
                                        + jsonFromMh.get("descripcionMsg").getAsString());
                                FacesContext.getCurrentInstance().addMessage(null, message);
                                update("mainFrm");
                            }
                        }
                    } else {
                        FacesMessage message = new FacesMessage("MENSAJE APLICACIÓN ", " FALLO AL INTENTAR OBTENER FIRMA DE DOCUMENTO");
                        FacesContext.getCurrentInstance().addMessage(null, message);
                    }
                }
            } else {
                logger.error("error al obtener json desde db");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void addFacturaProcesada(Factura item) {
        facturasProcLs.add(item);
        if (facturasLs.size() > 0) {
            facturasLs.remove(item);
        } else {
            facturasLs = new ArrayList<>();
        }
        update("mainFrm");
    }

    private JsonObject getFirmaDocumento(JsonObject jsonDte) {
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
            logger.info("respuesta firmardocumento " + response.body());
            signedJson = parser.fromJson(response.body(), JsonObject.class);
            if (signedJson.get("status").getAsString().matches("OK")) {
                logger.info("jsonFirmado: " + signedJson.get("body"));
            } else {
                logger.error("error obteniendo jsonFirmado" + signedJson.get("status").getAsString() + ", "
                        + signedJson.get("body"));
            }
        } catch (URISyntaxException | IOException | InterruptedException e) {
            logger.error("error en getFirmaDocumento");
            e.printStackTrace();
        }

        return signedJson;
    }

    private JsonObject getAuth() {
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
            logger.error("error en getAuth");
            ex.printStackTrace();
        }

        return respuesta;
    }

    private JsonObject getProcesarMh(JsonElement jsonFirmado, String uuid, String token) {
        JsonObject response = new JsonObject();
        JsonObject jsonRequest = new JsonObject();
        try {
            jsonRequest.addProperty("version", pmh.getPmJsonFesvMhVersion());
            jsonRequest.addProperty("ambiente", pmh.getPmJsonFesvMhAmbiente());
            jsonRequest.addProperty("idEnvio", pmh.getPmJsonFesvMhIdenvio());
            jsonRequest.addProperty("tipoDte", itemSelected.getFacTipoComprobante());
            jsonRequest.addProperty("codigoGeneracion", uuid);
            jsonRequest.add("documento", jsonFirmado);

            HttpRequest request = HttpRequest.newBuilder()
                    .uri(new URI(pmh.getPmJsonFesvMhUrl()))
                    .headers("Content-Type", "application/json")
                    .headers("Authorization", token)
                    .POST(HttpRequest.BodyPublishers.ofString(new Gson().toJson(jsonRequest)))
                    .build();

            HttpResponse<String> resp = HttpClient.newHttpClient()
                    .send(request, HttpResponse.BodyHandlers.ofString());

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

    public void sendMail(String nroFactura, JsonObject jsonObject, String nameJsonFile, String tipoDocumento) {
        String path = "";
        ServletContext servletContext = (ServletContext) FacesContext.getCurrentInstance().getExternalContext().getContext();
        path = servletContext.getRealPath("/WEB-INF/reportsrc/");
        String observaciones = "Fecha del Periodo del " + ViewUtils.formatoFecha(itemSelected.getFacFechaIniPeriodo())
                + " al " + ViewUtils.formatoFecha(itemSelected.getFacFechaFinPeriodo());
        boolean sent = service.sendMail(this.email, nroFactura, path, jsonObject, nameJsonFile, observaciones, tipoDocumento);
        if (sent) {
            logger.info("Correo enviado exitósamente");
        } else {
            logger.error("Falló envío de correo");
        }
    }

    public void insertPeriodo() {
        if (fechaInicio != null && fechaFin != null
                && !fechaFin.toString().isEmpty() && !fechaInicio.toString().isEmpty()) {
            if (fechaFin.after(fechaInicio) || fechaInicio.equals(fechaFin)) {
                itemSelected = service.updatePeriodoFactura(fechaInicio, fechaFin, itemSelected);
                if (itemSelected != null) {
                    logger.info("itemSelected after updating period: " + itemSelected);
                    PrimeFaces.current().executeScript("PF('DialogPeriodo').hide();");
                    processFactura(itemSelected);
                } else {
                    itemSelected = new Factura();
                    ViewUtils.showMessageError("OCURRIO UN ERROR AL INTENTAR INGRESAR PERIODO," +
                            " VERIFIQUE E INTENTE NUEVAMENTE");
                }
            } else {
                ViewUtils.addError("FECHA INICIO NO PUEDE SER POSTERIOR A FECHA FIN", null);
                PrimeFaces.current().ajax().update("frmPeriodo");
            }
        } else {
            ViewUtils.addError("DEBE INGRESAR FECHA INICIO Y FIN PARA CONTINUAR", null);
            PrimeFaces.current().ajax().update("frmPeriodo");
        }
    }

    public void procesarListener(Factura item) {
        itemSelected = item;
        logger.info("itemSelected before updating period: " + itemSelected);
        pmh = service.findParametrosByNitEmisor(item.getFacNitEmisor());
        logger.info("parametros mh: " + pmh);
    }

}
