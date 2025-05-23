package sv.com.jsoft.stdte.dto;

import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Data
@NoArgsConstructor
public class LoginDto implements Serializable {

    private static final long serialVersionUID = 1L;
    private String usuario;
    private String clave;
    private int msgExpiracion = 0;
    private boolean logueado;
    private String idSession;

    private String quizUser;
    private String quizPass;
    private String conexion;
    private Integer idEmpresa;

    public LoginDto(String usuario, String clave) {
        this.setUsuario(usuario);
        this.setClave(clave);
    }

    public LoginDto(String quizUser, String quizPass, String conexion) {
        this.setQuizUser(quizUser);
        this.setQuizPass(quizPass);
        this.setConexion(conexion);
    }
}
