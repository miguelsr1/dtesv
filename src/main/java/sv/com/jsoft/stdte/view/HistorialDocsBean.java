package sv.com.jsoft.stdte.view;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.google.gson.JsonSyntaxException;
import com.lowagie.text.DocumentException;
import lombok.Getter;
import lombok.Setter;
import net.sf.jasperreports.engine.JasperExportManager;
import org.apache.poi.ss.usermodel.Workbook;
import org.primefaces.PrimeFaces;
import org.primefaces.model.DefaultStreamedContent;
import org.primefaces.model.LazyDataModel;
import org.primefaces.model.StreamedContent;
import sv.com.jsoft.stdte.dto.ArchivosPDFsDTO;
import sv.com.jsoft.stdte.dto.ExcelFileDTO;
import sv.com.jsoft.stdte.persistence.BitacoraDeclaracionHacienda;
import sv.com.jsoft.stdte.persistence.Contribuyentes;
import sv.com.jsoft.stdte.persistence.Factura;
import sv.com.jsoft.stdte.persistence.TiposComprobantes;
import sv.com.jsoft.stdte.repository.AppService;
import sv.com.jsoft.stdte.repository.BitacoraService;
import sv.com.jsoft.stdte.utils.CookiesUtil;
import sv.com.jsoft.stdte.utils.CsvFileWriter;
import sv.com.jsoft.stdte.utils.JasperReportUtil;
import sv.com.jsoft.stdte.utils.ViewUtils;

import javax.annotation.PostConstruct;
import javax.faces.view.ViewScoped;
import javax.inject.Inject;
import javax.inject.Named;
import java.io.*;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.*;
import java.util.stream.Collectors;
import javax.naming.NamingException;
import lombok.extern.slf4j.Slf4j;
import net.sf.jasperreports.engine.JRException;

@Named(value = "history")
@ViewScoped
@Slf4j
public class HistorialDocsBean implements Serializable {

    private static final ResourceBundle RESOURCE_BUNDLE = ResourceBundle.getBundle("bundle");

    @Getter
    @Setter
    private List<BitacoraDeclaracionHacienda> emitidosList;

    @Getter
    @Setter
    private BitacoraDeclaracionHacienda itemSelected;

    @Getter
    @Setter
    private String email;

    @Inject
    LoginBean loginBean;

    @Inject
    AppService service;

    @Inject
    JasperReportUtil jr;

    @Getter
    @Setter
    DefaultStreamedContent exportFile;

    @Getter
    @Setter
    private String jsonData, jsonName;

    @Getter
    @Setter
    private List<BitacoraDeclaracionHacienda> filteredList;

    @Getter
    @Setter
    private Date fechaIni, fechaFin;

    @Getter
    @Setter
    private String filename;

    @Getter
    @Setter
    private Integer progress;

    private boolean procesoExitoso;

    private int processedCount;

    @Getter
    @Setter
    private boolean displayParams;

    @Getter
    @Setter
    private Date startDate, endDate;

    @Getter
    @Setter
    private String tipoDoc, dte, nitReceptor, estado;

    @Getter
    @Setter
    private List<TiposComprobantes> tiposComprobantesLs;

    @Getter
    @Setter
    private LazyDataModel<BitacoraDeclaracionHacienda> lazyModel;

    @Inject
    BitacoraService bitacoraService;

    @Getter
    @Setter
    private List<Contribuyentes> receptores;

    @Getter
    @Setter
    private Integer opcionExcel;

    @PostConstruct
    public void init() {
        itemSelected = new BitacoraDeclaracionHacienda();
        progress = 0;
        processedCount = 0;
        displayParams = true;
        tipoDoc = null;
        dte = null;
        nitReceptor = null;
        estado = null;
        tiposComprobantesLs = service.findAllTiposComprobantes();
        receptores = service.findAllReceptoresByIdEmp(loginBean.getLogin().getIdEmpresa());
        opcionExcel = 0;
    }

    public void verFactura(BitacoraDeclaracionHacienda item) {
        try {
            String path;
            filename = item.getCodigoGeneracion();
            if (System.getProperty("os.name").toUpperCase().contains("WINDOWS")) {
                path = RESOURCE_BUNDLE.getString("PATH_REPORT_WINDOWS");
            } else {
                path = RESOURCE_BUNDLE.getString("PATH_REPORT_LINUX");
            }
            path = path.replace("SYSTEM_USER", System.getProperty("user.name"));
            log.info("report path: " + path);
            String observaciones = service.findFacturaById(item.getIdFac());
            Factura factura = service.recuperarFacturaById(item.getIdFac());
            if (factura.getFacTipoComprobante().matches("07")) {
                observaciones = factura.getFacObservaciones();
            }
            Map<String, Object> hm = new HashMap<>();
            hm.put("PNRO_FACTURA", item.getIdFac().toString());
            hm.put("POBSERVACIONES", observaciones);
            hm.put("PLOGO", CookiesUtil.getServletContext().getRealPath("/resources"));
            String reportName = factura.getFacTipoComprobante().matches("07") ? "REPCOMPRET" : "REPNOTAREMELEC";
            byte[] reportBytes = jr.getReportToPdf(path, hm, reportName);
            if (reportBytes != null) {
                CookiesUtil.addSessionAttribute("REPORT", reportBytes);
                PrimeFaces.current().executeScript("PF('DialogImprimir').show();");
                PrimeFaces.current().ajax().update("frmPrint");
            }
        } catch (SQLException | NamingException e) {
            log.error("USER: " + loginBean.getUsuario());
            log.error("ERROR EN verFactura", e);
        }
    }

    public void verJson(BitacoraDeclaracionHacienda item) throws DocumentException {
        try {
            jsonData = item.getJsonDoc();
            jsonName = item.getCodigoGeneracion();
            PrimeFaces.current().ajax().update("dlgJson");
            PrimeFaces.current().executeScript("PF('DialogJson').show();");
            PrimeFaces.current().ajax().update("frmJson");

        } catch (Exception e) {
            log.error("USER: " + loginBean.getUsuario());
            log.error("ERROR EN verJson", e);
        }
    }

    public StreamedContent getDownloadFile() {
        InputStream stream = new ByteArrayInputStream(jsonData.getBytes());
        return DefaultStreamedContent.builder()
                .name(jsonName + ".json")
                .contentType("application/json")
                .stream(() -> stream)
                .build();
    }

    public void enviarListener(BitacoraDeclaracionHacienda item) {
        itemSelected = item;
        log.info("itemSelected: " + itemSelected.toString());
    }

    public void sendEmailTo() {
        if (email != null && !email.isBlank()) {
            log.info("Enviando correo a " + email);
            String path;
            if (System.getProperty("os.name").toUpperCase().contains("WINDOWS")) {
                path = RESOURCE_BUNDLE.getString("PATH_REPORT_WINDOWS");
            } else {
                path = RESOURCE_BUNDLE.getString("PATH_REPORT_LINUX");
            }
            path = path.replace("SYSTEM_USER", System.getProperty("user.name"));
            log.info("report path: " + path);
            if (itemSelected.getJsonDoc() != null) {
                try {
                    JsonObject jsonObject = JsonParser.parseString(itemSelected.getJsonDoc()).getAsJsonObject();
                    Factura factura = service.recuperarFacturaById(itemSelected.getIdFac());
                    String observaciones = service.findFacturaById(itemSelected.getIdFac());
                    if (factura.getFacTipoComprobante().matches("07")) {
                        observaciones = factura.getFacObservaciones();
                    }
                    boolean sent = service
                            .sendMail(email, itemSelected.getIdFac().toString(), path,
                                    jsonObject, itemSelected.getCodigoGeneracion(), observaciones, factura.getFacTipoComprobante());
                    if (sent) {
                        log.info("Se ha enviado correo exitosamente a: " + email);
                        PrimeFaces.current().executeScript("PF('DialogEmailTo').hide();");
                        ViewUtils.showMessageInfo("CORREO ENVIADO EXITÓSAMENTE A " + email);
                        itemSelected = new BitacoraDeclaracionHacienda();
                    } else {
                        log.info("Fallo el envio de correo ");
                        ViewUtils.showMessageError("FALLO EL ENVIO DE CORREO A: " + email + ", VERIFIQUE E INTENTE NUEVAMENTE");
                    }
                } catch (JsonSyntaxException e) {
                    log.error("USER: " + loginBean.getUsuario());
                    log.error("ERROR EN sendEmailTo", e);
                }
            }
        }
    }

    public Workbook generateWorkbook() {
        log.info("procesando archivo excel, periodo del " + ViewUtils.formatoFecha(fechaIni) + " al " + ViewUtils.formatoFecha(fechaFin));
        try {
            java.sql.Date fecIni = new java.sql.Date(fechaIni.getTime());
            java.sql.Date fecFin = new java.sql.Date(fechaFin.getTime());
            List<ExcelFileDTO> resultList = service.findFacturasExcel(fecIni, fecFin);
            if (!resultList.isEmpty()) {
                Workbook workbook;
                log.info("registros encontrados: " + resultList.size());
                if (opcionExcel == 1) {
                    workbook = CsvFileWriter.generateExcelFileBrillo(resultList);
                } else {
                    workbook = CsvFileWriter.generateExcelFile(resultList);
                }

                if (workbook != null) {
                    try {
                        log.info("Excel file download initiated.");
                        return workbook;
                    } catch (Exception e) {
                        log.error("USER: " + loginBean.getUsuario());
                        log.error("ERROR EN generateWorkbook - 2", e);
                    }
                }
            } else {
                return null;
            }
        } catch (Exception e) {
            log.error("USER: " + loginBean.getUsuario());
            log.error("ERROR EN generateWorkbook", e);
        }
        return null;
    }

    public InputStream workbookToInputStream(Workbook workbook) throws IOException {
        ByteArrayOutputStream bos = new ByteArrayOutputStream();
        workbook.write(bos);
        return new ByteArrayInputStream(bos.toByteArray());
    }

    public StreamedContent createDownloadableFile() throws IOException {
        if (fechaIni != null && !fechaIni.toString().isEmpty() && fechaFin != null && !fechaFin.toString().isEmpty()) {
            if (fechaFin.after(fechaIni) || fechaIni.equals(fechaFin)) {
                Workbook workbook = generateWorkbook();
                if (workbook != null) {
                    InputStream inputStream = workbookToInputStream(workbook);
                    return DefaultStreamedContent.builder()
                            .name(opcionExcel == 1 ? "Facturacion.xlsx" : "FacturaDecImp.xlsx")
                            .contentType("application/vnd.ms-excel")
                            .stream(() -> inputStream)
                            .build();
                } else {
                    ViewUtils.showMessageError("NO SE ENCONTRARON REGISTROS PARA PERIODO INGRESADO, VERIFIQUE");
                }
            } else {
                ViewUtils.showMessageError("FECHA FIN DEBE SER IGUAL O MAYOR QUE FECHA INICIAL, VERIFIQUE");
            }
        } else {
            ViewUtils.showMessageError("DEBE INGRESAR FECHAS PARA CONTINUAR");
        }
        return null;
    }

    public void procesoDescargaPeriodo() {
        progress = 0;
        if (fechaIni != null && !fechaIni.toString().isEmpty() && fechaFin != null && !fechaFin.toString().isEmpty()) {
            if (fechaFin.after(fechaIni) || fechaIni.equals(fechaFin)) {
                log.info("inicio proceso descarga masiva de archivos, periodo del " + ViewUtils.formatoFecha(fechaIni) + " al " + ViewUtils.formatoFecha(fechaFin));
                try {
                    List<BitacoraDeclaracionHacienda> filteredLst = filterListByDate(fechaIni, fechaFin, emitidosList);
                    if (!filteredLst.isEmpty()) {
                        List<ArchivosPDFsDTO> jasperPrintList = new ArrayList<>();
                        String path;
                        if (System.getProperty("os.name").toUpperCase().contains("WINDOWS")) {
                            path = RESOURCE_BUNDLE.getString("PATH_REPORT_WINDOWS");
                        } else {
                            path = RESOURCE_BUNDLE.getString("PATH_REPORT_LINUX");
                        }
                        path = path.replace("SYSTEM_USER", System.getProperty("user.name"));
                        log.info("report path: " + path);
                        log.info("generando archivos pdf...");

                        String finalPath = path;
                        filteredLst.forEach(item -> {
                            try {
                                ArchivosPDFsDTO archivosPDFsDTO = new ArchivosPDFsDTO();
                                filename = "#" + item.getNroControlDte() + " " + item.getCodigoGeneracion();
                                String observaciones = service.findFacturaById(item.getIdFac());
                                Factura factura = service.recuperarFacturaById(item.getIdFac());
                                if (factura.getFacTipoComprobante().matches("07")) {
                                    observaciones = factura.getFacObservaciones();
                                }
                                Map<String, Object> hm = new HashMap<>();
                                hm.put("PNRO_FACTURA", item.getIdFac().toString());
                                hm.put("POBSERVACIONES", observaciones);
                                hm.put("PLOGO", CookiesUtil.getServletContext().getRealPath("/resources"));
                                String reportName = factura.getFacTipoComprobante().matches("07") ? "REPCOMPRET" : "REPNOTAREMELEC";
                                archivosPDFsDTO.setJasperPrint(jr.getJasperPrintReport(hm, reportName, finalPath));
                                archivosPDFsDTO.setFileName(filename);
                                archivosPDFsDTO.setJsonDocument(item.getJsonDoc());
                                jasperPrintList.add(archivosPDFsDTO);
                            } catch (Exception e) {
                                log.error("USER: " + loginBean.getUsuario());
                                log.error("ERROR EN procesoDescargaPeriodo - 2", e);
                            }
                        });

                        log.info("iniciando descarga de reportes en pdf...");
                        boolean result;
                        result = savePdfJsonFiles(jasperPrintList);
                        if (result) {
                            ViewUtils.showMessageInfo("ARCHIVOS FUERON GENERADOS Y DESCARGADOS A SU EQUIPO CORRECTAMENTE, VERIFIQUE EN SU CARPETA DE DESCARGAS");
                        } else {
                            ViewUtils.showMessageError("OCURRIÓ UN ERROR AL PROCESAR LOS FICHEROS, FAVOR INFORME A SERTRACEN.");
                        }
                    } else {
                        ViewUtils.showMessageError("NO SE ENCONTRARON DOCUMENTOS EMITIDOS PARA EL PERIODO SELECCIONADO, VERIFIQUE");
                    }
                } catch (Exception e) {
                    log.error("USER: " + loginBean.getUsuario());
                    log.error("ERROR EN procesoDescargaPeriodo", e);
                }
            } else {
                ViewUtils.showMessageError("FECHA FIN DEBE SER IGUAL O MAYOR QUE FECHA INICIAL, VERIFIQUE");
            }
        } else {
            ViewUtils.showMessageError("DEBE INGRESAR FECHAS PARA CONTINUAR");
        }
    }

    private boolean savePdfJsonFiles(List<ArchivosPDFsDTO> jasperPrintList) {
        procesoExitoso = Boolean.FALSE;
        processedCount = 0;

        String carpetaDescargas = System.getProperty("user.home") + File.separator + "Downloads";
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMdd_HHmmss");
        String fechaHoraActual = simpleDateFormat.format(new Date());

        String rutaCarpetaPDFs = carpetaDescargas + File.separator + fechaHoraActual;
        File carpeta = new File(rutaCarpetaPDFs);
        if (!carpeta.exists()) {
            carpeta.mkdirs();
        }

        //procesar listado de ficheros
        try {
            jasperPrintList.forEach(jasperPrint -> {
                guardarFacturaJson(jasperPrint, rutaCarpetaPDFs);
                processedCount++;
                try {
                    Thread.sleep(500);
                } catch (InterruptedException e) {
                    log.error("USER: " + loginBean.getUsuario());
                    log.error("ERROR EN Thread sleep", e);
                }
                progress = (int) Math.round((double) processedCount / jasperPrintList.size() * 100);
            });

            procesoExitoso = true;
        } catch (Exception e) {
            log.error("USER: " + loginBean.getUsuario());
            log.error("ERROR EN savePdfJsonFiles", e);
        }
        return procesoExitoso;
    }

    private void guardarFacturaJson(ArchivosPDFsDTO archivosPDFsDTO, String rutaCarpetaPDFs) {
        String nombreArchivo = archivosPDFsDTO.getFileName();
        String rutaCompletaPDF = rutaCarpetaPDFs + File.separator + nombreArchivo;
        try {
            //savePDF
            JasperExportManager.exportReportToPdfFile(archivosPDFsDTO.getJasperPrint(), rutaCompletaPDF + ".pdf");
            //saveJson
            try (FileWriter fileWriter = new FileWriter(rutaCompletaPDF + ".json")) {
                fileWriter.write(archivosPDFsDTO.getJsonDocument());
            } catch (Exception e) {
                log.error("ocurrió un error al intentar guardar archivo json", e);
            }
        } catch (JRException e) {
            log.error("USER: " + loginBean.getUsuario());
            log.error("ERROR EN guardarFacturaJson", e);
        }
    }

    //proceso que devuelve la lista filtrada por el periodo seleccionado
    private List<BitacoraDeclaracionHacienda> filterListByDate(Date startDate, Date endDate, List<BitacoraDeclaracionHacienda> list) {
        LocalDate localStartDate = startDate.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
        LocalDate localEndDate = endDate.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();

        return list.stream()
                .filter(entry -> {
                    LocalDate fechaIngreso = entry.getFechaIngreso().toLocalDateTime().toLocalDate();
                    return !fechaIngreso.isBefore(localStartDate) && !fechaIngreso.isAfter(localEndDate);
                })
                .collect(Collectors.toList());
    }

    public void findHistoryByFilters() {
        if (startDate != null && endDate != null) {
            if (startDate.after(endDate)) {
                ViewUtils.showMessageError("Fecha inicial debe ser menor o igual a fecha final");
            } else {
                emitidosList = bitacoraService.findAllDocEmitidos(loginBean.getLogin().getIdEmpresa(),
                        getFormattedDates(startDate), getFormattedDates(endDate),
                        tipoDoc, dte, nitReceptor, estado, loginBean.getUsuario());
                if (!emitidosList.isEmpty()) {
                    displayParams = false;
                }
            }
        } else {
            ViewUtils.showMessageError("Fecha inicio y fin son obligatorios");
        }
    }

    private String getFormattedDates(Date dateToFormat) {
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        return format.format(dateToFormat);
    }

    public void clean() {
        startDate = null;
        endDate = null;
        tipoDoc = null;
        dte = null;
        nitReceptor = null;
        estado = null;
        displayParams = true;
        emitidosList = new ArrayList<>();
        opcionExcel = 0;
    }

    public void excelOptionListener(Integer opcion) {
        this.setOpcionExcel(opcion);
        log.info("opción excel: " + opcionExcel);
    }
}
