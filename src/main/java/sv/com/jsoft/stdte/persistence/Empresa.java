package sv.com.jsoft.stdte.persistence;

import java.io.Serializable;
import java.time.LocalDateTime;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.validation.constraints.Size;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

/**
 *
 * @author msanchez
 */
@Entity
@Table(name = "empresa", schema = "fact")
@Data
@NoArgsConstructor
@EqualsAndHashCode
public class Empresa implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_empresa")
    private Integer idEmpresa;

    @Column(name = "codigo_actividad")
    @Size(max = 6)
    private String codigoActividad;

    @Column(name = "nit")
    @Size(max = 17)
    private String nit;

    @Column(name = "nrc")
    @Size(max = 8)
    private String nrc;

    @Column(name = "nombre_comercial")
    @Size(max = 250)
    private String nombreComercial;

    @Column(name = "razon_social")
    @Size(max = 250)
    private String razonSocial;

    @Column(name = "telefono")
    private String telefono;

    @Column(name = "correo")
    @Size(max = 250)
    private String correo;

    @Column(name = "estado")
    private Boolean estado;

    @Column(name = "direccion")
    @Size(max = 500)
    private String direccion;

    @Column(name = "codigo_municipio")
    @Size(max = 2)
    private String codigoMunicipio;

    @Column(name = "codigo_departamento")
    @Size(max = 2)
    private String codigoDepartamento;

    @Column(name = "codigo_establecimiento")
    @Size(max = 45)
    private String codigoEstablecimiento;

    @Column(name = "activo")
    private Boolean activo;

    @Column(name = "usuario")
    @Size(max = 250)
    private String usuario;
    
    @Column(name = "fecha_creacion")
    private LocalDateTime fechaCreacion;

}
