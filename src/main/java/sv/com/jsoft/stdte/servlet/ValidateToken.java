package sv.com.jsoft.stdte.servlet;

import lombok.Getter;
import lombok.Setter;
import org.apache.log4j.Logger;
import sv.com.jsoft.stdte.persistence.Usuarios;
import sv.com.jsoft.stdte.repository.LoginService;
import sv.com.jsoft.stdte.utils.EncryptUtil;

import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.Date;

@WebServlet("/validateToken/")
public class ValidateToken extends HttpServlet {

    private static final Logger logger = Logger.getLogger(ValidateToken.class);

    private String loginUrl;

    @EJB
    LoginService service;

    @Getter
    @Setter
    Usuarios usuario;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ValidateToken</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ValidateToken at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }

    }

    //modificado por aarias_id el 18/12/2024
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response){
        String token = request.getParameter("token");
        String token2 = request.getParameter("token2");
        logger.info("token: " + token);
        logger.info("token2: " + token2);
        try{
            if (token != null && !token.isEmpty()) {
                usuario = service.findUserByEmail(EncryptUtil.decrypt(token));
                logger.info("datadto : " + usuario);
                if (usuario.getUsCorreo() != null || !usuario.getUsCorreo().isEmpty()) {
                    usuario.setUsIsTokenVerified(1);
                    usuario.setUsIsVerified(1);
                    usuario.setUsDateTokenVerified(new Timestamp(new Date().getTime()));
                    service.updateUserCredentials(usuario);
                    loginUrl = request.getContextPath() + "/login.xhtml";
                    response.sendRedirect(loginUrl);
                } else {
                    usuario = new Usuarios();
                }
            }
            //cambie el metodo findUserByEmail por el findUserByCod, ya que ahora puede repetirse el mismo correo en otros usuarios
            //ahora busca por usuario y no por el email
            if(token2 != null && !token2.isEmpty()){
                String[] correo = EncryptUtil.decrypt(token2).split(":", 2);
                usuario = service.findUserByCod(correo[0]);
                if(usuario.getUsCorreo() != null || usuario.getUsCorreo().isBlank()){
                    usuario.setUsMustChangePassword(0);
                    service.updateUserCredentials(usuario);
                    loginUrl = request.getContextPath() + "/updatePassword.xhtml";
                    response.sendRedirect(loginUrl);
                } else {
                    usuario = new Usuarios();
                }
            }
        }catch (Exception e){
            logger.error("Error Exception WebServlet ValidateToken: " + e.getMessage());
        }
    }

}
