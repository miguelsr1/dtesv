package sv.com.jsoft.stdte.view;

import javax.enterprise.context.SessionScoped;
import javax.faces.application.FacesMessage;
import javax.inject.Named;
import lombok.Getter;
import lombok.Setter;
import org.primefaces.PrimeFaces;
import org.primefaces.event.MenuActionEvent;
import org.primefaces.model.menu.*;
import sv.com.jsoft.stdte.dto.LoginDto;
import sv.com.jsoft.stdte.persistence.Usuario;
import sv.com.jsoft.stdte.repository.LoginService;
import sv.com.jsoft.stdte.utils.EncryptUtil;
import sv.com.jsoft.stdte.utils.ViewUtils;

import javax.faces.context.ExternalContext;
import javax.faces.context.FacesContext;
import javax.faces.event.ActionEvent;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.Serializable;
import java.util.Date;
import java.util.StringTokenizer;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import javax.inject.Inject;
import lombok.extern.slf4j.Slf4j;

@Named(value = "login")
@SessionScoped
@Slf4j
public class LoginBean implements Serializable {

    private static final long serialVersionUID = 1L;

    @Getter
    @Setter
    private String opcionSeleccionada, usuario, clave, confirmClave, mensajeExpiracion = "", sessionUnica, expira = null, tipoSolicitud, email;
    @Getter
    @Setter
    private Date hoy = new Date();
    @Getter
    @Setter
    private transient boolean logueado = false;
    @Getter
    @Setter
    private LoginDto login;
    @Getter
    @Setter
    private MenuModel model;
    @Inject
    LoginService loginService;

    public LoginBean() {
        this.setOpcionSeleccionada("/welcome.xhtml");
        this.setLogueado(false);
        usuario = "";
        clave = "";
        confirmClave = "";
    }

    public boolean validarNavegador() {
        return ViewUtils.isMozillaBrowser() || ViewUtils.isChromeBrowser();
    }

    public synchronized void loadPage(ActionEvent event) throws IOException {
        try {
            MenuItem menuItem = ((MenuActionEvent) event).getMenuItem();
            String url = menuItem.getParams().get("menuList").get(0);
            StringTokenizer tokens = new StringTokenizer(url, ":");
            String link = tokens.nextToken();
            this.setOpcionSeleccionada(link);
            FacesContext.getCurrentInstance().getExternalContext().getSessionMap().put("reporte", null);
            ExternalContext ec = FacesContext.getCurrentInstance().getExternalContext();
            ec.redirect(((HttpServletRequest) ec.getRequest()).getRequestURI());
        } catch (IOException e) {
            log.error("SE PRESENTO EL SIGUIENTE ERROR loadPagina: ", e);
            this.setOpcionSeleccionada("/sinpermiso.xhtml");
        }
    }

    public synchronized String crearSesion() {
        HttpSession session = ViewUtils.getSession();
        try {
            if (validarNavegador()) {
                if (this.clave != null && this.usuario != null) {
                    if (validateUser()) {
                        Usuario user = loginService.findUserByCod(this.usuario);
                        if (user.getCambiarPassword()) {
                            showMessage("DEBE CAMBIAR SU CLAVE");
                            return "updatePassword?faces-redirect=true";
                        } else if (!user.getActivo()) {
                            ViewUtils.addError("SU USUARIO NO ESTA ACTIVO PARA INGRESAR AL SISTEMA", "");
                            PrimeFaces.current().executeScript("PF('DialogMensajes').show()");
                            return null;
                        } else {
                            Integer idEmp = loginService.findIdEmpresaByUser(usuario);
                            this.login = new LoginDto(usuario, clave);
                            this.setOpcionSeleccionada("/welcome.xhtml");
                            this.login.setIdEmpresa(idEmp);
                            this.login.setLogueado(true);
                            session.setAttribute("login", login);
                            this.sessionUnica = session.getId();
                            this.setLogueado(true);
                            loadMenu();
                            return "index";
                        }
                    } else {
                        ViewUtils.addError("USUARIO/CONTRASEÑA INCORRECTOS", "");
                        PrimeFaces.current().executeScript("PF('DialogMensajes').show()");
                        return "login";
                    }
                } else {
                    ViewUtils.addError("DEBE INGRESAR USUARIO Y/O CLAVE", "");
                    PrimeFaces.current().executeScript("PF('DialogMensajes').show()");
                    this.usuario = null;
                    this.clave = null;
                    return null;
                }
            }
        } catch (Exception e) {
            log.error("ERROR en crearSesion", e);
            return null;
        }
        return null;
    }

    private boolean validateUser() {
        Usuario user = loginService.findUserByCod(this.usuario);
        if (user != null) {
            //String passHash = EncryptUtil.encrypt(clave);
            return user.getPassword().matches(clave);
        } else {
            return false;
        }
    }

    public synchronized void loadMenu() {
        this.model = new DefaultMenuModel();
        DefaultSubMenu defaultSubMenu = DefaultSubMenu.builder()
                .label("PROCESOS")
                .expanded(true)
                .build();
        DefaultMenuItem item;
        int idMenu = 1;

        item = DefaultMenuItem.builder().value("INGRESAR DATOS").build();
        item.setParam("menuList", "/procesos/ingresoDatos.xhtml" + ":" + "PROINGDATOS");
        item.setCommand("#{login.loadPage}");
        item.setOnerror("PF('DialogInternet').show();");
        item.setId("MO" + idMenu);
        item.setTitle("Ingresar Datos");
        item.setIcon("pi pi-database");
        idMenu++;
        defaultSubMenu.getElements().add(item);

        item = DefaultMenuItem.builder().value("EMITIDOS").build();
        item.setParam("menuList", "/procesos/docEmitidos.xhtml" + ":" + "PRODOCEMI");
        item.setCommand("#{login.loadPage}");
        item.setOnerror("PF('DialogInternet').show()");
        item.setId("MO" + idMenu);
        item.setTitle("Facturas Emitidas");
        item.setIcon("pi pi-history");
        idMenu++;
        defaultSubMenu.getElements().add(item);

        DefaultSubMenu subMenuCorrecciones = DefaultSubMenu.builder().label("CORRECCIONES").build();
        item = DefaultMenuItem.builder().value("ANULACION").build();
        item.setParam("menuList", "/procesos/anulacion.xhtml" + ":" + "PROANUFACT");
        item.setCommand("#{login.loadPage}");
        item.setOnerror("PF('DialogInternet').show()");
        item.setId("MO" + idMenu);
        item.setTitle("Anular Factura");
        item.setIcon("pi pi-ban");
        subMenuCorrecciones.getElements().add(item);

        DefaultSubMenu subMenuAdm = DefaultSubMenu.builder().label("ADMINISTRACION").build();
        item = DefaultMenuItem.builder().value("MANTENIMIENTOS").build();
        item.setParam("menuList", "/mantenimientos/home.xhtml" + ":" + "HOMEMTTOS");
        item.setCommand("#{login.loadPage}");
        item.setOnerror("PF('DialogInternet').show();");
        item.setTitle("MANTENIMIENTOS");
        item.setIcon("pi pi-pencil");
        subMenuAdm.getElements().add(item);
        
        item = DefaultMenuItem.builder().value("MIS DATOS").build();
        item.setParam("menuList", "/mantenimientos/emisor.xhtml" + ":" + "HOMEMTTOS");
        item.setCommand("#{login.loadPage}");
        item.setOnerror("PF('DialogInternet').show();");
        item.setTitle("MANTENIMIENTOS");
        item.setIcon("pi pi-id-card");
        subMenuAdm.getElements().add(item);
        

        DefaultSubMenu subMenuMisc = DefaultSubMenu.builder().label("MISC").build();
        item = DefaultMenuItem.builder().value("CERRAR SESION").build();
        item.setCommand("#{login.cerrarSesion}");
        item.setTitle("CERRAR SESION");//
        item.setOnerror("PF('DialogInternet').show()");
        item.setIcon("pi pi-sign-out");
        subMenuMisc.getElements().add(item);

        DefaultSubMenu subMenuReportes = DefaultSubMenu.builder().label("UTILITARIOS").build();
        item = DefaultMenuItem.builder().value("REPORTE").build();
        item.setParam("menuList", "/reportes/reportxdiaxsucursal.xhtml" + ":" + "REPORT");
        item.setCommand("#{login.loadPage}");
        item.setOnerror("PF('DialogInternet').show();");
        item.setTitle("REPORTES");
        item.setIcon("pi pi-file-pdf");
        subMenuReportes.getElements().add(item);

        DefaultSubMenu subMenuCrons = DefaultSubMenu.builder().label("PROCESOS AUT.").build();
        item = DefaultMenuItem.builder().value("EJECUCION MANUAL").build();
        item.setParam("menuList", "/procesos/executeCrons.xhtml" + ":" + "CRONS");
        item.setCommand("#{login.loadPage}");
        item.setOnerror("PF('DialogInternet').show();");
        item.setTitle("PROCESOS AUT.");
        item.setIcon("pi pi-cog");
        subMenuCrons.getElements().add(item);

        this.model.getElements().add(defaultSubMenu);
        this.model.getElements().add(subMenuCorrecciones);
        this.model.getElements().add(subMenuAdm);
        this.model.getElements().add(subMenuReportes);
        this.model.getElements().add(subMenuMisc);
    }

    public String goAyudaManuales() {
        this.setOpcionSeleccionada("/help.xhtml");
        return "index?faces-redirect=true";
    }

    public synchronized String cerrarSesion() {
        HttpSession session = ViewUtils.getSession();
        log.info("USUARIO CIERRA SESION: " + this.login.getUsuario());
        try {
            PrimeFaces.current().executeScript("PrimeFaces.ajax.Queue.abortAll();");
        } catch (Exception ex) {
            log.error("error ", ex);
        }
        session.invalidate();
        this.model = null;
        this.usuario = null;
        this.clave = null;
        login.setLogueado(false);
        return "login?faces-redirect=true";
    }

    public String redirectTo(String url) {
        this.setOpcionSeleccionada(url);
        return "index?faces-redirect=true";
    }

    //modificado por aarias_id el 18/12/2024
    public void doRecuperaClave(ActionEvent event) {
        if (email != null && tipoSolicitud != null) {
            try {
                log.info("usuario: " + email);
                Usuario us = loginService.findUserByCod(email);
                if (us == null) {
                    if (emailValidate(email.toLowerCase())) {
                        //us = service.findUserByEmail(email.toLowerCase());
                    } else {
                        ViewUtils.addError("USUARIO/CORREO NO REGISTRADO O FORMATO DE CORREO NO VALIDO", null);
                        return;
                    }
                }
                if (us != null) {
                    //agregue parametro email quien es el usuario
                    Object[] params = {us.getCorreoElectronico(), this.tipoSolicitud, email};
                    String[] result = loginService.recuperarClave(params);
                    PrimeFaces.current().executeScript("PF('DialogClave').hide();");
                    if (result[0].equals("0")) {
                        ViewUtils.addMessage("SE HA ENVIADO UN ENLACE A SU CUENTA DE CORREO, VERIFIQUE... ", null);
                        this.usuario = null;
                        this.clave = null;
                        PrimeFaces.current().ajax().update("loginForm");
                    } else {
                        ViewUtils.addError("OCURRIÓ UN ERROR: " + result[1], null);
                    }
                    PrimeFaces.current().executeScript("PF('DialogMensajes').show();");
                    PrimeFaces.current().ajax().update("frminfo");
                } else {
                    ViewUtils.addError("USUARIO Ó CORREO NO REGISTRADO, VERIFIQUE E INTENTE NUEVAMENTE", null);
                }
            } catch (Exception e) {
                log.error("SE PRESENTO EL SIGUIENTE ERROR doRecuperaClave: ", e);
                PrimeFaces.current().executeScript("PF('DialogClave').hide();");
                ViewUtils.addError("SOLICITUD NO PROCESADA ",
                        "SE HA PRESENTADO UN INCONVENIENTE, VUELVA A INTENTARLO EN OTRO MOMENTO O CONTACTE A SU PROVEEDOR DE SISTEMA.");
            } finally {
                this.email = null;
                this.tipoSolicitud = null;
            }
        } else {
            ViewUtils.addError("DEBE INGRESAR USUARIO Y TIPO DE SOLICITUD", null);
        }
    }

    private Boolean emailValidate(String mail) {
        if (mail == null) {
            return false;
        }
        String regex = "^[a-zA-Z0-9_!#$%&’*+/=?`{|}~^.-]+@[a-zA-Z0-9.-]+$";
        Pattern pattern = Pattern.compile(regex);
        Matcher matcher = pattern.matcher(mail);
        return matcher.matches();
    }

    public String updateUserPassword() throws IOException {
        log.info("actualizar credenciales a usuario: " + usuario);
        if (clave.matches(confirmClave)) {
            Usuario usu = loginService.findUserByCod(this.usuario);
            if (usu != null) {
                usu.setPassword(EncryptUtil.encrypt(clave));
                loginService.updateUserCredentials(usu);
                FacesContext.getCurrentInstance().getExternalContext().redirect("login.xhtml");
            } else {
                showMessage("USUARIO INGRESADO NO SE ENCUENTRA REGISTRADO, VERIFIQUE...");
            }
        } else {
            showMessage("CONTRASEÑAS NO COINCIDEN VERIFIQUE...");
        }
        return null;
    }

    public void showMessage(String msg) {
        FacesMessage message = new FacesMessage(FacesMessage.SEVERITY_INFO, "Aviso", msg);
        PrimeFaces.current().dialog().showMessageDynamic(message);
    }
}
