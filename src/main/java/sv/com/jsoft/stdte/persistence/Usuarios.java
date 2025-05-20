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
@Table(name = "usuarios", schema = "fact")
public class Usuarios implements Serializable {

    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "us_id")
    private Integer usId;
    @Basic
    @Column(name = "us_usuario")
    private String usUsuario;
    @Basic
    @Column(name = "us_clave")
    private String usClave;
    @Basic
    @Column(name = "usu_estado")
    private String usuEstado;
    @Basic
    @Column(name = "us_ruc_id")
    private int usRucId;
    @Basic
    @Column(name = "us_correo")
    private String usCorreo;
    @Basic
    @Column(name = "us_created_at")
    private Timestamp usCreatedAt;
    @Basic
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
    }
}
