package sv.com.jsoft.stdte.persistence;

import java.io.Serializable;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.ToString;
import javax.persistence.*;
import java.sql.Timestamp;

@Entity
@Data
@NoArgsConstructor
@ToString
@EqualsAndHashCode
@Table(name = "usuario", schema = "fact")
public class Usuario implements Serializable {

    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "correo_electronico")
    private String correoElectronico;
    @Basic
    @Column(name = "nombres")
    private String nombres;
    @Basic
    @Column(name = "password")
    private String password;
    @Basic
    @Column(name = "apellidos")
    private String apellidos;
    @Basic
    @Column(name = "activo")
    private Boolean activo;
    @Basic
    @Column(name = "correo_verificado")
    private Boolean correoVerificado;
    @Basic
    @Column(name = "bloqueado")
    private Boolean bloqueado;
    @Basic
    @Column(name = "cambiar_password")
    private Boolean cambiarPassword;
    @Column(name = "fecha_creacion")
    private Timestamp fechaCreacion;
    @Column(name = "id_usuario")
    private Integer idUsuario;
    /*@Basic
    @Column(name = "us_updated_at")
    private Timestamp usUpdatedAt;
    @Basic
    @Column(name = "us_is_token_verified")
    private Integer usIsTokenVerified;
    @Basic
    @Column(name = "us_date_token_verified")
    private Timestamp usDateTokenVerified;
    @Basic
    @Column(name = "us_must_change_password")
    private Integer usMustChangePassword;
    @Basic
    @Column(name = "us_is_verified")
    private Integer usIsVerified;
    @Basic
    @Column(name = "us_date_verified")
    private Timestamp usDateVerified;
    @JoinColumn(name = "us_ubicacion", referencedColumnName = "co_id")
    @ManyToOne(fetch = FetchType.EAGER)
    private CatalogoOrigenes usUbicacion;
    @JoinColumn(name = "us_puesto", referencedColumnName = "cpu_id")
    @ManyToOne(fetch = FetchType.EAGER)
    private CatalogoPuestosUsuarios usPuesto;
    @Basic
    @Column(name = "us_cortesia")
    private String usCortesia;
    @JoinColumn(name = "us_ulb_id", referencedColumnName = "ulb_id")
    @ManyToOne(fetch = FetchType.EAGER)
    private UnidadesLaborales usUlbId;

    {
        usUlbId = new UnidadesLaborales();
        usPuesto = new CatalogoPuestosUsuarios();
        usUbicacion = new CatalogoOrigenes();
    }*/
}
