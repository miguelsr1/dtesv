package sv.com.jsoft.stdte.persistence;

import java.io.Serializable;
import lombok.Data;
import lombok.NoArgsConstructor;
import javax.persistence.*;

@Entity
@Data
@NoArgsConstructor
@Table(name = "ubicaciones_geograficas", schema = "fact")
public class UbicacionesGeograficas implements Serializable {

    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "ubg_id_geograficas")
    private int ubgIdGeograficas;
    @Basic
    @Column(name = "ubg_codigo")
    private String ubgCodigo;
    @Basic
    @Column(name = "ubg_descripcion")
    private String ubgDescripcion;
    @Basic
    @Column(name = "ugb_iddepto")
    private Integer ugbIddepto;

}
