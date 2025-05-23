package sv.com.jsoft.stdte.view;

import lombok.Getter;
import lombok.Setter;
import org.primefaces.PrimeFaces;
import sv.com.jsoft.stdte.persistence.CatalogoProductos;
import sv.com.jsoft.stdte.persistence.CatalogoTipoItem;
import sv.com.jsoft.stdte.persistence.UnidadesMedida;
import sv.com.jsoft.stdte.repository.AppService;
import sv.com.jsoft.stdte.repository.CatalogosService;
import sv.com.jsoft.stdte.repository.MttoService;
import javax.annotation.PostConstruct;
import javax.faces.application.FacesMessage;
import javax.faces.component.UIComponent;
import javax.faces.component.UIInput;
import javax.faces.context.FacesContext;
import javax.faces.event.AjaxBehaviorEvent;
import javax.faces.view.ViewScoped;
import javax.inject.Inject;
import javax.inject.Named;
import java.io.Serializable;
import java.util.List;
import lombok.extern.slf4j.Slf4j;
import sv.com.jsoft.stdte.repository.CatalogosProductosService;

@ViewScoped
@Named("prodBean")
@Slf4j
public class ProductoBean implements Serializable {

    @Inject
    MttoService service;

    @Inject
    LoginBean login;

    @Inject
    AppService appService;

    @Inject
    CatalogosProductosService catProService;

    @Inject
    CatalogosService catalogoService;

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

    @PostConstruct
    public void init() {
        tipoItemsList = catalogoService.getCatalogoTipoItem();
        productosList = catProService.findAllProductosByEmpresa(login.getLogin().getIdEmpresa());
        productosList.forEach(c -> {
            if (c.getCpExento() != null) {
                c.setExento(c.getCpExento().matches("S")
                        ? Boolean.TRUE : Boolean.FALSE);
            } else {
                c.setExento(Boolean.FALSE);
            }

            if (c.getCpActivo() != null) {
                c.setActivo(c.getCpActivo().matches("S")
                        ? Boolean.TRUE : Boolean.FALSE);
            } else {
                c.setActivo(Boolean.FALSE);
            }
        });

        undMedidasList = appService.findAllUnidadesMedida();
        selectedProducto = new CatalogoProductos();
    }

    public String getDeleteProductosButtonMessage() {
        if (hasSelectedProductos()) {
            int size = this.selectedProductos.size();
            return size > 1 ? size + " Productos Seleccionados" : "1 Producto Seleccionado";
        }
        return "ELIMINAR";
    }

    public boolean hasSelectedProductos() {
        return this.selectedProductos != null && !this.selectedProductos.isEmpty();
    }

    public void saveProducto() {
        log.info(selectedProducto.getIdcatProd() == null ? "saveProducto " + selectedProducto : "updateProducto: " + selectedProducto);
        int result = 0;
        if (selectedProducto.getIdcatProd() == null) {
            CatalogoProductos prod = service.findProductoByCodigo(selectedProducto.getCodigoProd());
            if (prod != null) {
                FacesContext.getCurrentInstance().addMessage(null, new FacesMessage("YA EXISTE UN PRODUCTO REGISTRADO CON ESE CÓDIGO, VERIFIQUE..."));
                return;
            }

            selectedProducto.setIdEmpresa(login.getLogin().getIdEmpresa());

            result = service.saveProducto(selectedProducto);
            if (result > 0) {
                FacesContext.getCurrentInstance().addMessage(null, new FacesMessage("PRODUCTO AGREGADO CORRECTAMENTE"));
                productosList = catProService.findAllProductosByEmpresa(login.getLogin().getIdEmpresa());
            } else {
                FacesContext.getCurrentInstance().addMessage(null, new FacesMessage("FALLÓ REGISTRO DE PRODUCTO"));
            }
        } else {
            result = service.saveProducto(selectedProducto);
            if (result > 0) {
                FacesContext.getCurrentInstance().addMessage(null, new FacesMessage("PRODUCTO ACTUALIZADO CORRECTAMENTE"));
            } else {
                FacesContext.getCurrentInstance().addMessage(null, new FacesMessage("FALLÓ ACTUALIZACIÓN DE PRODUCTO"));
            }
        }
        PrimeFaces.current().executeScript("PF('manageProductoDialog').hide()");
        PrimeFaces.current().ajax().update("frmProductos:messages", "frmProductos:tblProductos");
    }

    public void openNewProducto() {
        this.selectedProducto = new CatalogoProductos();
    }

    public void deleteSelectedProductos() {

    }

    public void exentoEventListener(AjaxBehaviorEvent event) {
        UIComponent component = event.getComponent();
        if (component instanceof UIInput) {
            UIInput inputComponent = (UIInput) component;
            Boolean value = (Boolean) inputComponent.getValue();
            String exento = value ? "S" : "N";
            selectedProducto.setCpExento(exento);
        }
    }

    public void activoEventListener(AjaxBehaviorEvent event) {
        UIComponent component = event.getComponent();
        if (component instanceof UIInput) {
            UIInput input = (UIInput) component;
            Boolean value = (Boolean) input.getValue();
            String activo = value ? "S" : "N";
            selectedProducto.setCpActivo(activo);
        }
    }
}
