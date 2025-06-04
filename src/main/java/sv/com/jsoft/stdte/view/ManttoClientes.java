package sv.com.jsoft.stdte.view;

import lombok.Getter;
import lombok.Setter;
import org.primefaces.PrimeFaces;
import sv.com.jsoft.stdte.dao.CatCodActEconomicaDAO;
import sv.com.jsoft.stdte.dao.ContribuyentesDAO;
import sv.com.jsoft.stdte.dao.TiposDocumentosDAO;
import sv.com.jsoft.stdte.dto.CatCodActEconomicaDTO;
import sv.com.jsoft.stdte.dto.TiposDocumentosDTO;
import sv.com.jsoft.stdte.persistence.Contribuyentes;
import sv.com.jsoft.stdte.persistence.UbicacionesGeograficas;
import sv.com.jsoft.stdte.repository.MttoService;
import javax.annotation.PostConstruct;
import javax.faces.application.FacesMessage;
import javax.faces.event.AjaxBehaviorEvent;
import javax.faces.view.ViewScoped;
import javax.inject.Inject;
import javax.inject.Named;
import javax.transaction.Transactional;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import lombok.extern.slf4j.Slf4j;

@Named("mttoClts")
@ViewScoped
@Slf4j
public class ManttoClientes implements Serializable {

    @Inject
    MttoService service;

    /**@Getter
    @Setter
    private CustomLazyDataModel<Contribuyentes> lazyDataModelRec;*/
    @Getter
    @Setter
    private List<Contribuyentes> lstContribuyentes;

    @Getter
    @Setter
    private Contribuyentes selectedReceptor;
    @Getter
    @Setter
    private List<UbicacionesGeograficas> departmentList;
    @Getter
    @Setter
    private List<UbicacionesGeograficas> municipiosList;
    @Getter
    @Setter
    private boolean displayListRec;
    @Getter
    @Setter
    private boolean displayEditRec;
    @Getter
    @Setter
    private boolean displayNewRec;
    @Getter
    @Setter
    private List<TiposDocumentosDTO> tiposDocumentosList;
    @Getter
    @Setter
    private List<CatCodActEconomicaDTO> actEconomicaDTOList;
    @Inject
    TiposDocumentosDAO tiposDocumentosDAO;
    @Inject
    CatCodActEconomicaDAO actEconomicaDAO;
    @Inject
    ContribuyentesDAO contribuyentesDAO;
    @Inject
    LoginBean login;

    @PostConstruct
    public void init() {
        displayListRec = Boolean.TRUE;
        displayEditRec = Boolean.FALSE;
        displayNewRec = Boolean.FALSE;
        departmentList = service.departamentos();
        tiposDocumentosList = tiposDocumentosDAO.findAll();
        actEconomicaDTOList = actEconomicaDAO.findAll();

        loadLazyDataModel();
    }

    private void loadLazyDataModel() {
        lstContribuyentes = service.findReceptores(login.getLogin().getIdEmpresa());
        //lazyDataModelRec = new CustomLazyDataModel<>(entityManager, Contribuyentes.class, "rucId", login.getLogin().getIdEmpresa());
    }

    public void nuevoReceptor() {
        displayListRec = Boolean.FALSE;
        displayEditRec = Boolean.FALSE;
        displayNewRec = Boolean.TRUE;
        selectedReceptor = new Contribuyentes();
        municipiosList = new ArrayList<>();
    }

    public void editReceptor() {
        displayListRec = Boolean.FALSE;
        displayEditRec = Boolean.TRUE;
        displayNewRec = Boolean.FALSE;
        deptListener();
    }

    public void deptListener() {
        municipiosList = service.municipios(Integer.valueOf(selectedReceptor.getRucCodigoDepartamento()));
    }

    public void cancelar() {
        displayListRec = Boolean.TRUE;
        displayEditRec = Boolean.FALSE;
        displayNewRec = Boolean.FALSE;
    }

    @Transactional
    public void saveReceptor() {
        log.info("Datos del receptor: " + selectedReceptor);
        try {
            selectedReceptor.setIdEmpresa(login.getLogin().getIdEmpresa());
            selectedReceptor.setRucTipoContribuyente("RECEPTOR");
            contribuyentesDAO.save(selectedReceptor);
            log.info("REGISTRO HA SIDO " + (displayNewRec ? "GUARDADO" : "ACTUALIZADO") + " CORRECTAMENTE");
            loadLazyDataModel();
            FacesMessage message = new FacesMessage(FacesMessage.SEVERITY_INFO, "MENSAJE", "PROCESO FINALIZÓ CORRECTAMENTE");
            PrimeFaces.current().dialog().showMessageDynamic(message);
            clean();
        } catch (Exception e) {
            log.error("ocurrió un error al intentar guardar/actualizar el registro: ", e);
        }

    }

    private void clean() {
        displayListRec = Boolean.TRUE;
        displayNewRec = Boolean.FALSE;
        displayEditRec = Boolean.FALSE;
    }

    public void validateNrc(AjaxBehaviorEvent event) {
        String nrc = this.selectedReceptor.getRucNrc();
        if (nrc == null || !nrc.matches("^[0-9]{1,8}$")) {
            this.selectedReceptor.setRucNrc(null);
            FacesMessage message = new FacesMessage(FacesMessage.SEVERITY_ERROR, "ERROR", "El campo NRC debe contener entre 1 y 8 dígitos numéricos.");
            PrimeFaces.current().dialog().showMessageDynamic(message);
            PrimeFaces.current().executeScript("PF('txtNrc').focus();");
        }
    }
}
