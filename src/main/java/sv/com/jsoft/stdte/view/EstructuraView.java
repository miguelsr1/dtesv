package sv.com.jsoft.stdte.view;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import javax.annotation.PostConstruct;
import javax.faces.application.FacesMessage;
import javax.faces.context.FacesContext;
import javax.faces.view.ViewScoped;
import javax.inject.Named;
import lombok.Getter;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import org.primefaces.PrimeFaces;
import org.primefaces.event.SelectEvent;
import org.primefaces.model.DialogFrameworkOptions;
import sv.com.jsoft.stdte.persistence.Establecimiento;
import sv.com.jsoft.stdte.persistence.PuntoVenta;
import sv.com.jsoft.stdte.utils.MessageUtil;

/**
 *
 * @author migue
 */
@ViewScoped
@Named
@Slf4j
public class EstructuraView implements Serializable {

    private Integer idEstablecimiento;

    @Getter
    @Setter
    private Establecimiento estable;
    @Getter
    @Setter
    private List<Establecimiento> lstEstable;
    private List<PuntoVenta> lstPuntosVentas;
    

    @PostConstruct
    public void init() {
        estable = new Establecimiento();
        lstPuntosVentas = new ArrayList();
        loadEstablecimientos();
    }

    public void onRowSelect(SelectEvent<Establecimiento> event) {
        estable = event.getObject();
        idEstablecimiento = estable.getIdEstablecimiento();
        loadPuntosVenta();
    }

    public void loadPuntosVenta() {
        //lstPuntosVentas = estableService.getLstPuntosVentas(securityService.getToken(), idEstablecimiento);
    }

    private void loadEstablecimientos() {
        //lstEstable = estableService.getLstEstablecimiento(securityService.getToken());
    }

    public void showDlgEstablecimiento() {

        DialogFrameworkOptions options = DialogFrameworkOptions.builder()
                .draggable(false)
                .resizable(false)
                .maximizable(false)
                .modal(true)
                .width("400px")
                .height("460px")
                .build();

        PrimeFaces.current().dialog().openDynamic("mantenimientos/dialog/dlg-establecimiento", options, null);
    }

    public void showDlgPuntoVenta() {
        if (estable == null) {
            MessageUtil.builder()
                    .message("DEBE SELECCIONAR UN ESTABLECIMIENTO")
                    .severity(FacesMessage.SEVERITY_WARN)
                    .title("ERROR")
                    .build()
                    .showMessage();
            return;
        }
        
        this.idEstablecimiento = estable.getIdEstablecimiento();

        FacesContext.getCurrentInstance().getExternalContext().getSessionMap().put("idEstablecimiento", idEstablecimiento);
        FacesContext.getCurrentInstance().getExternalContext().getSessionMap().put("nombreEstable", estable.getNombreSucursal());

        DialogFrameworkOptions options = DialogFrameworkOptions.builder()
                .draggable(false)
                .resizable(false)
                .maximizable(false)
                .modal(true)
                .width("400px")
                .height("460px")
                .build();

        PrimeFaces.current().dialog().openDynamic("dialog/dlg-punto-venta", options, null);
    }

    public void onEstablecimiento(SelectEvent<Establecimiento> event) {
        if (event.getObject() != null) {
            Establecimiento establecimientoDto = event.getObject();
            lstEstable.add(establecimientoDto);
        }
    }

    public void agregarEstablecimiento() {
        lstEstable.add(estable);
        estable = new Establecimiento();
    }

    public List<PuntoVenta> getLstPuntosVentas() {
        return lstPuntosVentas;
    }
}
