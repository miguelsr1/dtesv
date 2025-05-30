package sv.com.jsoft.stdte.view;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.List;
import javax.annotation.PostConstruct;
import javax.faces.application.FacesMessage;
import javax.faces.context.FacesContext;
import javax.faces.view.ViewScoped;
import javax.inject.Inject;
import javax.inject.Named;
import lombok.Getter;
import lombok.Setter;
import org.primefaces.PrimeFaces;
import org.primefaces.event.FileUploadEvent;
import org.primefaces.model.file.UploadedFile;
import sv.com.jsoft.stdte.persistence.Empresa;
import sv.com.jsoft.stdte.persistence.UbicacionesGeograficas;
import sv.com.jsoft.stdte.repository.EmisorService;
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
    private Empresa selectedEmisor;

    @Getter
    @Setter
    private List<UbicacionesGeograficas> municipios;

    @Inject
    MttoService service;
    @Inject
    LoginBean loginBean;
    @Inject
    EmisorService emisorService;

    @PostConstruct
    public void init() {
        String usuario = loginBean.getLogin().getUsuario();
        selectedEmisor = emisorService.getEmisorByUsuario(usuario);
        if (selectedEmisor.getIdEmpresa() == null) {
            selectedEmisor.setActivo(Boolean.TRUE);
            selectedEmisor.setEstado(Boolean.TRUE);
            selectedEmisor.setFechaCreacion(LocalDateTime.now());
            selectedEmisor.setUsuario(usuario);
        }
    }

    public void findMunicipioCode(Empresa c) {
        selectedEmisor = c;
        municipios = service.municipios(Integer.valueOf(c.getCodigoDepartamento()));
        selectedEmisor.setCodigoMunicipio(service.municipioCode(c));
    }

    public void save() {
        if (selectedEmisor != null) {
            Integer resultado = 0;
            if (selectedEmisor.getIdEmpresa() == null) {
                emisorService.save(selectedEmisor);
                resultado = selectedEmisor.getIdEmpresa();
                if (resultado > 0) {
                    FacesContext.getCurrentInstance().addMessage(null, new FacesMessage("EMISOR REGISTRADO CORRECTAMENTE"));
                } else {
                    FacesContext.getCurrentInstance().addMessage(null,
                            new FacesMessage("FALLÓ REGISTRO DE EMISOR, VERIFIQUE E INTENTE NUEVAMENTE"));
                }
            } else {
                emisorService.update(selectedEmisor);
                FacesContext.getCurrentInstance().addMessage(null, new FacesMessage("EMISOR ACTUALIZADO CORRECTAMENTE"));
            }
        } else {
            FacesContext.getCurrentInstance().addMessage(null, new FacesMessage("NO SE ENCONTRO EMISOR A CREAR"));
        }
        PrimeFaces.current().executeScript("PF('manageEmisorDialog').hide()");
        PrimeFaces.current().ajax().update("frmEmisores:messages", "frmEmisores:tblEmisores");
    }

    public void handleFileUpload(FileUploadEvent event) {
        UploadedFile file = event.getFile();

        if (file != null && file.getContent() != null && file.getContent().length > 0 && file.getFileName() != null) {

        }
    }
}
