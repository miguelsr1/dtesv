package sv.com.jsoft.stdte.view;

import lombok.Getter;
import lombok.Setter;
import org.primefaces.PrimeFaces;
import sv.com.jsoft.stdte.persistence.*;
import sv.com.jsoft.stdte.repository.CatalogosService;
import sv.com.jsoft.stdte.repository.MttoService;
import javax.annotation.PostConstruct;
import javax.faces.application.FacesMessage;
import javax.faces.context.FacesContext;
import javax.faces.view.ViewScoped;
import javax.inject.Inject;
import javax.inject.Named;
import java.io.Serializable;
import java.util.List;
import lombok.extern.slf4j.Slf4j;

@ViewScoped
@Named(value = "mtto")
@Slf4j
public class MantenimientoBean implements Serializable {

    @Getter
    @Setter
    private List<Contribuyentes> emisores, selectedEmisores, receptores, selectedReceptores;

    @Getter
    @Setter
    private Contribuyentes selectedEmisor, selectedReceptor;

    @Getter
    @Setter
    private List<Usuario> usuariosList, selectedUsuarios;

    private Usuario selectedUsuario;

    @Inject
    MttoService service;
    @Inject
    LoginBean login;
    @Inject
    CatalogosService catalogoService;

    @Getter
    @Setter
    private List<UbicacionesGeograficas> departamentos, municipios;

    @Getter
    @Setter
    private List<CatalogoCodigoActividadEconomica> actividadEconomicaList;

    @Getter
    @Setter
    private List<CatalogoProductos> productosList, selectedProductos;

    @Getter
    @Setter
    private CatalogoProductos selectedProducto;

    @Getter
    @Setter
    private List<UnidadesMedida> undMedidasList;

    @Getter
    @Setter
    private List<CatalogoTipoItem> tipoItemsList;

    @Getter
    @Setter
    private List<TiposDocumentos> tiposDocumentosList;
    @Getter
    @Setter
    private TiposDocumentos selectedTipoDocumento;

    @Getter
    @Setter
    private List<CatalogoOrigenes> origenesList;
    @Getter
    @Setter
    private List<CatalogoPuestosUsuarios> puestosList;
    @Getter
    @Setter
    private List<UnidadesLaborales> unidadesLaboList;

    @PostConstruct
    public void init() {
        usuariosList = service.retrieveUsers();
        emisores = service.findEmisores();
        selectedUsuario = new Usuario();
        departamentos = service.departamentos();
        actividadEconomicaList = service.actividadEconomicaList();
        receptores = service.findReceptores();
        tiposDocumentosList = catalogoService.getAllTiposDocumentos();
        selectedEmisor = new Contribuyentes();
        selectedReceptor = new Contribuyentes();
        selectedTipoDocumento = new TiposDocumentos();

        origenesList = service.retrieveOrigenesUsers();
        puestosList = service.retrievePuestosUsers();
        unidadesLaboList = service.retrieveUniLaboralesUsers();
    }

    public Usuario getSelectedUsuario() {
        return selectedUsuario;
    }

    public void setSelectedUsuario(Usuario selectedUsuario) {
        /*if(selectedUsuario.getUsUlbId() == null){
            selectedUsuario.setUsUlbId(new UnidadesLaborales());
        }
        if(selectedUsuario.getUsPuesto() == null){
            selectedUsuario.setUsPuesto(new CatalogoPuestosUsuarios());
        }
        if(selectedUsuario.getUsUbicacion() == null){
            selectedUsuario.setUsUbicacion(new CatalogoOrigenes());
        }*/
        this.selectedUsuario = selectedUsuario;
    }

    public String getDeleteEmisoresButtonMessage() {
        if (hasSelectedEmisores()) {
            int size = this.selectedEmisores.size();
            return size > 1 ? size + " Emisores Seleccionados " : "1 Emisor Seleccionado";
        }
        return "ELIMINAR";
    }

    public String getDeleteUserButtonMessage() {
        if (hasSelectedUsuarios()) {
            int size = this.selectedUsuarios.size();
            return size > 1 ? size + " Usuarios Seleccionados" : "1 Usuario Seleccionado";
        }
        return "ELIMINAR";
    }

    public String getDeleteReceptoresButtonMessage() {
        if (hasSelectedReceptores()) {
            int size = this.selectedReceptores.size();
            return size > 1 ? size + " Receptores Seleccionados" : "1 Receptor Seleccionado";
        }
        return "ELIMINAR";
    }

    public boolean hasSelectedEmisores() {
        return this.selectedEmisores != null && !this.selectedEmisores.isEmpty();
    }

    public boolean hasSelectedUsuarios() {
        return this.selectedUsuarios != null && !this.selectedUsuarios.isEmpty();
    }

    public boolean hasSelectedReceptores() {
        return this.selectedReceptores != null && !this.selectedReceptores.isEmpty();
    }

    public void saveUsuario() {
        log.info(selectedUsuario.getCorreoElectronico() == null ? "saveUsuario " + selectedUsuario : "updateUsuario: " + selectedUsuario);
        int result = 0;

        if (selectedUsuario.getCorreoElectronico() == null) {
            //selectedUsuario.setUsRucId(1); //TODO Buscar id de emisor para relacionarlo al usuario
            /*Usuarios existe = loginService.findUserByEmail(selectedUsuario.getUsCorreo());
            if (existe != null) {
                FacesContext.getCurrentInstance().addMessage(null, new FacesMessage("YA EXISTE UN USUARIO REGISTRADO CON ESE CORREO, VERIFIQUE..."));
                return;
            }*/
            //result = service.saveUser(selectedUsuario);
            if (result > 0) {
                FacesContext.getCurrentInstance().addMessage(null, new FacesMessage("USUARIO AGREGADO CORRECTAMENTE"));
                usuariosList = service.retrieveUsers();
            } else {
                FacesContext.getCurrentInstance().addMessage(null, new FacesMessage("FALLÓ REGISTRO DE USUARIO"));
            }
        } else {
            //result = service.saveUser(selectedUsuario);
            if (result > 0) {
                FacesContext.getCurrentInstance().addMessage(null, new FacesMessage("USUARIO ACTUALIZADO CORRECTAMENTE"));
            } else {
                FacesContext.getCurrentInstance().addMessage(null, new FacesMessage("FALLÓ ACTUALIZACIÓN DE USUARIO"));
            }
        }
        PrimeFaces.current().executeScript("PF('manageUsuarioDialog').hide()");
        usuariosList = service.retrieveUsers();
        PrimeFaces.current().ajax().update("frmUsuarios:messages", "frmUsuarios:tblUsuarios");
    }

    public void deleteUsuario() {
        try {
            if (selectedUsuario != null) {
                if (!login.getUsuario().matches(selectedUsuario.getCorreoElectronico())) {
                    String resultado = service.deleteUsuario(selectedUsuario);
                    if (resultado.matches("OK")) {
                        FacesContext.getCurrentInstance().addMessage(null, new FacesMessage("USUARIO ELIMINADO CORRECTAMENTE"));
                    }
                } else {
                    FacesContext.getCurrentInstance().addMessage(null, new FacesMessage("NO PUEDE ELIMINAR USUARIO LOGUEADO, CONTACTE AL PROVEEDOR"));
                }
            }
        } catch (Exception e) {
            log.error("ERROR ELIMINADO USUARIO: " + selectedUsuario, e);
            FacesContext.getCurrentInstance().addMessage(null, new FacesMessage("FALLÓ ELIMINACIÓN DE USUARIO"));
        } finally {
            usuariosList = service.retrieveUsers();
            PrimeFaces.current().ajax().update("frmUsuarios:messages", "frmUsuarios:tblUsuarios");
        }
    }

    public void openNewUsuario() {
        this.selectedUsuario = new Usuario();
    }

    public void openNewEmisor() {
        this.selectedEmisor = new Contribuyentes();
    }

    public void openNewReceptor() {
        this.selectedReceptor = new Contribuyentes();
    }

    public void deleteSelectedEmisores() {

    }

    public void deleteSelectedReceptores() {

    }

    public void findMunicipiosByDeptoCod(String codDepto) {
        if (codDepto != null && !codDepto.isBlank()) {
            municipios = service.municipios(Integer.valueOf(codDepto));
        }
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

    public void saveReceptor() {
        if (selectedReceptor != null) {
            int resultado = 0;
            if (selectedReceptor.getRucId() == null) {
                resultado = service.saveContribuyente(selectedReceptor, "RECEPTOR");
                if (resultado > 0) {
                    FacesContext.getCurrentInstance().addMessage(null, new FacesMessage("RECEPTOR REGISTRADO CORRECTAMENTE"));
                    receptores = service.findReceptores();
                } else {
                    FacesContext.getCurrentInstance().addMessage(null,
                            new FacesMessage("FALLÓ REGISTRO DE RECEPTOR, VERIFIQUE E INTENTE NUEVAMENTE"));
                }
            } else {
                resultado = service.saveContribuyente(selectedReceptor, "RECEPTOR");
                if (resultado > 0) {
                    FacesContext.getCurrentInstance().addMessage(null, new FacesMessage("RECEPTOR ACTUALIZADO CORRECTAMENTE"));
                } else {
                    FacesContext.getCurrentInstance().addMessage(null, new FacesMessage("FALLÓ ACTUALIZACIÓN DE RECEPTOR"));
                }
            }
        } else {
            FacesContext.getCurrentInstance().addMessage(null, new FacesMessage("NO SE ENCONTRO RECEPTOR A CREAR"));
        }
        PrimeFaces.current().executeScript("PF('manageReceptorDialog').hide()");
        PrimeFaces.current().ajax().update("frmReceptores:messages", "frmReceptores:tblReceptores");
    }

    public void getActividadDescReceptor() {
        String code = selectedReceptor.getRucCodactividad();
        CatalogoCodigoActividadEconomica item = service.findActividadEconomicaByCode(code);
        if (item != null) {
            selectedReceptor.setRucDesactividad(item.getCcaeValor());
        }
    }

    public void getActividadDescEmisor(CatalogoCodigoActividadEconomica item) {
        selectedEmisor.setRucDesactividad(item.getCcaeValor());
    }
}
