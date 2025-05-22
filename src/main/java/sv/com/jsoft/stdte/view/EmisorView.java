package sv.com.jsoft.stdte.view;

import java.io.Serializable;
import javax.annotation.PostConstruct;
import javax.faces.application.FacesMessage;
import javax.faces.context.FacesContext;
import javax.faces.view.ViewScoped;
import javax.inject.Inject;
import javax.inject.Named;
import lombok.Getter;
import lombok.Setter;
import org.primefaces.PrimeFaces;
import sv.com.jsoft.stdte.persistence.CatalogoCodigoActividadEconomica;
import sv.com.jsoft.stdte.persistence.Contribuyentes;
import sv.com.jsoft.stdte.repository.MttoService;

/**
 *
 * @author migue
 */
@Named
@ViewScoped
public class EmisorView implements Serializable {
    
    @Getter
    @Setter
    private Contribuyentes selectedEmisor;
    @Inject
    MttoService service;
    
    @PostConstruct
    public void init(){
        selectedEmisor = new Contribuyentes();
    }

    public void findMunicipioCode(Contribuyentes c) {
        selectedEmisor = c;
        municipios = service.municipios(Integer.valueOf(c.getRucCodigoDepartamento()));
        selectedEmisor.setRucCodigoMunicipio(service.municipioCode(c));
    }
    
    public void saveEmisor() {
        if (selectedEmisor != null) {
            int resultado = 0;
            if (selectedEmisor.getRucId() == null) {
                resultado = service.saveContribuyente(selectedEmisor, "EMISOR");
                if (resultado > 0) {
                    FacesContext.getCurrentInstance().addMessage(null, new FacesMessage("EMISOR REGISTRADO CORRECTAMENTE"));
                    emisores = service.findEmisores();
                } else {
                    FacesContext.getCurrentInstance().addMessage(null,
                            new FacesMessage("FALLÓ REGISTRO DE EMISOR, VERIFIQUE E INTENTE NUEVAMENTE"));
                }
            } else {
                resultado = service.saveContribuyente(selectedEmisor, "EMISOR");
                if (resultado > 0) {
                    FacesContext.getCurrentInstance().addMessage(null, new FacesMessage("EMISOR ACTUALIZADO CORRECTAMENTE"));
                } else {
                    FacesContext.getCurrentInstance().addMessage(null, new FacesMessage("FALLÓ ACTUALIZACIÓN DE EMISOR"));
                }
            }
        } else {
            FacesContext.getCurrentInstance().addMessage(null, new FacesMessage("NO SE ENCONTRO EMISOR A CREAR"));
        }
        PrimeFaces.current().executeScript("PF('manageEmisorDialog').hide()");
        PrimeFaces.current().ajax().update("frmEmisores:messages", "frmEmisores:tblEmisores");
    }
    
    public void getActividadDescEmisor(CatalogoCodigoActividadEconomica item) {
        selectedEmisor.setRucDesactividad(item.getCcaeValor());
    }
}
