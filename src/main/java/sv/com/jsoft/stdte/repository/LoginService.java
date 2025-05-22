package sv.com.jsoft.stdte.repository;

import com.google.gson.FieldNamingPolicy;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import org.apache.log4j.Logger;
import sv.com.jsoft.stdte.dto.RequestMailDTO;
import sv.com.jsoft.stdte.persistence.Usuario;
import sv.com.jsoft.stdte.utils.EncryptUtil;
import javax.annotation.PostConstruct;
import javax.ejb.Stateless;
import javax.ejb.TransactionManagement;
import javax.ejb.TransactionManagementType;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.io.IOException;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.ResourceBundle;
import java.util.logging.Level;

@Stateless
@TransactionManagement(TransactionManagementType.CONTAINER)
public class LoginService {

    protected final static Logger logger = Logger.getLogger(LoginService.class);
    private static final ResourceBundle RESOURCE_BUNDLE = ResourceBundle.getBundle("bundle");


    @PersistenceContext
    private EntityManager entityManager;

    @PostConstruct
    public void init() {
        java.util.logging.Logger.getLogger("org.hibernate").setLevel(Level.WARNING);
    }

    public Usuario findUserByCod(String usrCodigo) {
        try {
            Usuario usuario = null;

            usuario = (Usuario) entityManager.createQuery("select u from Usuario u where u.correoElectronico = :codUsuario")
                    .setParameter("codUsuario", usrCodigo).getSingleResult();

            return usuario;
        } catch (Exception e) {
            logger.info("error findUserByCod " + e.getMessage());
            return null;
        }
    }

    /*public Usuario findUserByEmail(String email) {
        try {
            Usuario usuario = null;
            usuario = (Usuario) entityManager
                    .createQuery("from Usuarios u where u.usCorreo = :email")
                    .setParameter("email", email).getSingleResult();
            logger.info("usuario encontrado por correo ");
            return usuario;
        } catch (Exception e) {
            logger.info("error findUserByEmail" + e.getMessage());
            return null;
        }
    }*/

    //modificado por aarias_id el 18/12/2024
    public String[] recuperarClave(Object[] params) {
        String[] msgRes = new String[2];
        try {
            logger.info("recuperaClave params: " + Arrays.toString(params));
            //agregue el params[2].toString()
            sendToken(params[0].toString(), params[1].toString(), params[2].toString());
            msgRes[0] = "0";
            msgRes[1] = "OK";
        } catch (Exception e) {
            logger.error("erron en recuperaClave", e);
            msgRes[0] = "1";
            msgRes[1] = "SOLICITUD NO PROCESADA CONTACTE AL ADMINISTRADOR";
        }
        return msgRes;
    }

    //modificado por aarias_id el 18/12/2024
    //reemplacé el mail por el user
    private void sendToken(String mail, String tipoSol, String user) {
        SimpleDateFormat sdf = new SimpleDateFormat("MMM/dd/yyyy");
        String tk;
        String url;
        String msg = "";

        tk = EncryptUtil.encrypt(user + ":" + sdf.format(new Date()));
        url = RESOURCE_BUNDLE.getString("URL") + "/dtesv/validateToken?token2=" + tk;
        if (tk != null) {
            logger.info("token: " + tk);
            if (msg.isBlank()) {
                msg = "<b>Estimado Usuario: "
                        + "<b><p> Ha solicitado cambiar su clave, para cambiarla haga clic en el siguiente enlace "
                        + "<a href='" + url + "'>CAMBIAR CLAVE</a>"
                        + "<p><b><br/>";
            }
            String body = "<html><body>"
                    + "<br/>" + msg + ""
                    + "</body></html>";
            sendEmail(mail, "Sistema de Transmision DTE - CAMBIO CLAVE ", body);
        }
    }

    public void sendEmail(String to, String subject, String body) {
        try {
            RequestMailDTO requestMail = new RequestMailDTO();
            requestMail.setFrom("noreply@em.com.sv");
            requestMail.setTo(to);
            requestMail.setSubject(subject);
            requestMail.setContent("html content");
            requestMail.setHtmlContent(body);

            Gson gson = new GsonBuilder().setFieldNamingPolicy(FieldNamingPolicy.LOWER_CASE_WITH_UNDERSCORES).create();
            logger.info("gson " + gson.toJson(requestMail));
            HttpClient httpClient = HttpClient.newHttpClient();
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(new URI("https://api.turbo-smtp.com/api/v2/mail/send"))
                    .headers("Content-Type", "application/json;charset=UTF-8")
                    .headers("authuser", RESOURCE_BUNDLE.getString("authuser"))
                    .headers("authpass", RESOURCE_BUNDLE.getString("authpass"))
                    .POST(HttpRequest.BodyPublishers.ofString(gson.toJson(requestMail)))
                    .build();

            HttpResponse response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());

        } catch (URISyntaxException | IOException | InterruptedException ex) {
            logger.error("error sendEmail " + ex.getMessage());
        }
    }

    public void updateUserCredentials(Usuario user) {
        /*try {
            logger.info("actualizando credenciales de usuario: " + user.getUsUsuario());
            Usuario u = entityManager.find(Usuario.class, user.getUsId());
            u.setUsIsTokenVerified(user.getUsIsTokenVerified());
            u.setUsIsVerified(user.getUsIsVerified());
            u.setUsDateTokenVerified(user.getUsDateTokenVerified());
            u.setUsMustChangePassword(user.getUsMustChangePassword());
            u.setUsClave(user.getUsClave());
            entityManager.merge(u);
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("error en userVerified " + e.getMessage());
        }*/
    }
}
