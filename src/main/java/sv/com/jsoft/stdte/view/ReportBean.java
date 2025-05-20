package sv.com.jsoft.stdte.view;

import lombok.Getter;
import lombok.Setter;
import org.apache.log4j.Logger;
import org.primefaces.PrimeFaces;
import sv.com.jsoft.stdte.persistence.CatalogoOrigenes;
import sv.com.jsoft.stdte.repository.CatalogosService;
import sv.com.jsoft.stdte.utils.CookiesUtil;
import sv.com.jsoft.stdte.utils.JasperReportUtil;
import sv.com.jsoft.stdte.utils.ViewUtils;

import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.faces.context.FacesContext;
import javax.faces.view.ViewScoped;
import javax.inject.Named;
import javax.servlet.ServletContext;
import java.io.Serializable;
import java.util.*;

@Named("report")
@ViewScoped
public class ReportBean implements Serializable {

    protected static String REPORT_PATH;
    protected final static Logger logger = Logger.getLogger(ReportBean.class);

    @EJB
    CatalogosService catalogosService;

    @Getter
    @Setter
    private Date startDate, endDate;

    @Getter
    @Setter
    private Date horaInicio, horaFinal;

    @Getter @Setter
    private List<CatalogoOrigenes> origenes;

    @Getter @Setter
    private String codSucursal;

    @Getter @Setter
    private String usuario;

    @PostConstruct
    public void init() {
        startDate = new Date();
        endDate = new Date();
        Calendar calendar = Calendar.getInstance();
        //Set horaInicio to 07:00:00
        calendar.set(Calendar.HOUR_OF_DAY, 7);
        calendar.set(Calendar.MINUTE, 0);
        calendar.set(Calendar.SECOND, 0);
        calendar.set(Calendar.MILLISECOND, 0);
        horaInicio = calendar.getTime();

        //Set horaFinal to 18:00:00
        calendar.set(Calendar.HOUR_OF_DAY, 18);
        horaFinal = calendar.getTime();

        origenes = catalogosService.getAllCatalogoOrigenes();
        ServletContext servletContext = (ServletContext) FacesContext.getCurrentInstance().getExternalContext().getContext();
        REPORT_PATH = servletContext.getRealPath("/WEB-INF/classes/reports/");
    }

    public void doReport() {
        if(startDate != null && endDate != null && codSucursal != null) {
            if(startDate.after(endDate)){
                ViewUtils.addError("La fecha inicial debe ser anterior a la fecha final", null);
            }else {
                Map<String, Object> hm = new HashMap<>();
                JasperReportUtil jru = new JasperReportUtil();
                String sucDescription = getSelectedAbrDescription();

                hm.put("PFECHAI", ViewUtils.formatoFecha(startDate));
                hm.put("PFECHAF", ViewUtils.formatoFecha(endDate));
                hm.put("PHORAI", ViewUtils.formatDateTimeToString(horaInicio));
                hm.put("PHORAF", ViewUtils.formatDateTimeToString(horaFinal));
                hm.put("PCOD_SUCURSAL", codSucursal);
                hm.put("PSUC_DESCRIPCION", sucDescription);
                hm.put("PUSUARIO", usuario.isBlank() ? null : usuario);

                try {
                    byte[] reportBytes = jru.getReportToPdf(REPORT_PATH, hm, "REPCUADREXSUC");
                    if (reportBytes != null) {
                        CookiesUtil.addSessionAttribute("REPORT", reportBytes);
                        PrimeFaces.current().executeScript("PF('DialogImprimir').show();");
                        PrimeFaces.current().ajax().update("frmPrint");
                    }
                } catch (Exception e) {
                    logger.error("Error al generar el reporte " + e.getMessage());
                }
            }
        }else {
            ViewUtils.addError("DEBE INGRESAR PERIODO Y SUCURSAL A CONSULTAR", null);
        }

    }

    private String getSelectedAbrDescription() {
        return origenes.stream()
                .filter(item -> item.getCoAbreviatura().equals(codSucursal))
                .map(item -> item.getCoAbreviatura() + " - " + item.getCoDescripcion())
                .findFirst().orElse("NOT FOUND");
    }

}
