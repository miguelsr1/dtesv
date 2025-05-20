package sv.com.jsoft.stdte.view;

import java.io.Serializable;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import javax.faces.view.ViewScoped;
import javax.inject.Named;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import javax.ejb.EJB;
import lombok.Getter;
import lombok.Setter;
import org.primefaces.PrimeFaces;
import sv.com.jsoft.stdte.persistence.TiposComprobantes;
import sv.com.jsoft.stdte.repository.AppService;
import sv.com.jsoft.stdte.utils.ViewUtils;

/**
 *
 * @author aarias_id
 */
@Named("plantBril")
@ViewScoped
public class PlantillaBrilloBean implements Serializable {
    
    private static final DateFormat FORMAT_DATE_RPT = new SimpleDateFormat("dd-MMM-yy_HHmmss");
    private final String typeFile = "text/csv";
    
    @Getter
    @Setter
    private Date fechaInicio, fechaFin;
    
    @Getter
    @Setter
    private String sucursal;
    
    @EJB
    AppService service;
    
    public void execRepSolCarAutDen() {
        String encabTable;
        String csv = null;
        int total = 0;

        String lineas = "SOLICITUDES CARNET AUTORIZADO O DENEGADO" + System.lineSeparator();
        encabTable = "SOLICITUD;NOMBRE SOLICITANTE;TIPO SOLICITUD;TIPO TRAMITE;FECHA SOLICITUD;ESTADO";
        csv = "SOLICITUDES CARNET AUTORIZADO O DENEGADO " + getFechaGeneracionReporte();
        lineas += "" + System.lineSeparator();
        lineas += encabTable + System.lineSeparator();
        
        List<TiposComprobantes> result = service.findPlantBrillo(ViewUtils.formatoFecha(fechaInicio), ViewUtils.formatoFecha(fechaFin), sucursal);
        
        if (result != null && !result.isEmpty() && result.size() > 0) {
            Date FechaDet = null;
            for (TiposComprobantes tp : result) {
                lineas += String.format("%S;%S;%S;%S;%S;%S", (tp.getTcpComprobante() != null ? tp.getTcpComprobante() : ""), (tp.getTcpDescomprobante() != null ? tp.getTcpDescomprobante() : ""),
                        (tp.getTcpIdtipcom() != null ? tp.getTcpIdtipcom() : ""), 
                        (tp.getTcpComprobante() != null ? tp.getTcpComprobante() : ""), 
                        //(tp[4] != null ? ViewUtils.formatoFecha(FechaDet = (Date) tp[4]) : ""), (tp[5] != null ? (tp[5].equals("APV") ? "APROBADA VMT" : "RECHAZADA VMT") : "") + System.lineSeparator());
                        (tp.getTcpDescomprobante() != null ? ViewUtils.formatoFecha(FechaDet = (Date) FechaDet) : ""), 
                        (tp.getTcpIdtipcom() != null ? (tp.getTcpIdtipcom().equals("APV") ? "APROBADA VMT" : "RECHAZADA VMT") : "") + System.lineSeparator());
            }
            total = result.size();
            lineas += "" + System.lineSeparator();
            lineas += String.format("%S;%S", "TOTAL", total);

            downloadReport(lineas, csv);
        }
        fechaInicio = null;
        fechaFin = null;
        sucursal = null;
    }
    
    private void downloadReport(String lineas, String nombre) {
        if (lineas != null && nombre != null) {
            HashMap<String, Object> report = new HashMap();
            report.put("data", lineas);
            report.put("type", typeFile);
            ViewUtils.addSessionAttribute(nombre, report);
            PrimeFaces.current().executeScript("download('" + nombre + "','" + nombre + "')");
            ViewUtils.addMessage("GENERACION DE ARCHIVO FINALIZADA", null);
            ViewUtils.addMessage("ARCHIVO GENERADO: " + nombre + ".csv", null);
        } else {
            ViewUtils.addMessage("TRANSACCION HA TARDADO DEMASIADO EN COMPLETARSE, VUELVA A INTENTARLO", null);
        }
    }
    
    public static String getFechaGeneracionReporte() {
        return FORMAT_DATE_RPT.format(new Date());
    }
}
