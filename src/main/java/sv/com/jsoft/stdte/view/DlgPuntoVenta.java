package sv.com.jsoft.stdte.view;

import java.io.Serializable;
import javax.annotation.PostConstruct;
import javax.faces.context.FacesContext;
import javax.faces.view.ViewScoped;
import javax.inject.Named;
import lombok.Getter;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import org.primefaces.PrimeFaces;
import sv.com.jsoft.stdte.persistence.PuntoVenta;

/**
 *
 * @author msanchez
 */
@ViewScoped
@Named
@Slf4j
public class DlgPuntoVenta implements Serializable {

    @Getter
    @Setter
    private PuntoVenta puntoVentaDto;
    @Getter
    private String nombreEstable;
    private Integer idEstablecimiento;

    @PostConstruct
    public void init() {
        nombreEstable = (String) FacesContext.getCurrentInstance().getExternalContext().getSessionMap().get("nombreEstable");
        idEstablecimiento = (Integer) FacesContext.getCurrentInstance().getExternalContext().getSessionMap().get("idEstablecimiento");

        FacesContext.getCurrentInstance().getExternalContext().getSessionMap().remove("nombreEstable");
        FacesContext.getCurrentInstance().getExternalContext().getSessionMap().remove("idEstablecimiento");

        puntoVentaDto = new PuntoVenta();
        puntoVentaDto.setIdEstablecimiento(idEstablecimiento);
        puntoVentaDto.setActivo(Boolean.TRUE);
    }

    public void add() {

        save();

        PrimeFaces.current().dialog().closeDynamic(puntoVentaDto);
    }

    private void save() {

    }

    public void closeDgl() {
        PrimeFaces.current().dialog().closeDynamic(null);
    }
}
