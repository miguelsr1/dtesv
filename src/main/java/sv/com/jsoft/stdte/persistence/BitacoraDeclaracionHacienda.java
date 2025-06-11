package sv.com.jsoft.stdte.persistence;

import java.io.Serializable;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import javax.persistence.*;
import java.sql.Timestamp;

@Entity
@Data
@NoArgsConstructor
@ToString
@Table(name = "bitacora_declaracion_hacienda", schema = "fact")
public class BitacoraDeclaracionHacienda implements Serializable {

    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "idbitacora")
    private int idbitacora;
    @Basic
    @Column(name = "nro_control")
    private Integer nroControl;
    @Basic
    @Column(name = "estado")
    private String estado;
    @Basic
    @Column(name = "codigo_generacion")
    private String codigoGeneracion;
    @Basic
    @Column(name = "observaciones")
    private String observaciones;
    @Column(name = "json_doc", columnDefinition = "json")
    private String jsonDoc;
    @Basic
    @Column(name = "fecha_ingreso")
    private Timestamp fechaIngreso;
    @Basic
    @Column(name = "usuario_ingreso")
    private String usuarioIngreso;
    @Basic
    @Column(name = "fecha_respuesta")
    private Timestamp fechaRespuesta;
    @Basic
    @Column(name = "selloRecibido")
    private String selloRecibido;
    @Basic
    @Column(name = "link")
    private String link;
    @Basic
    @Column(name = "id_fac")
    private Integer idFac;
    @Transient
    private String nroControlDte;
    @Transient
    private String facTipoComprobante;

}
