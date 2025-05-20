package sv.com.jsoft.stdte.persistence;

import java.io.Serializable;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import javax.persistence.*;

@Entity
@Data
@NoArgsConstructor
@ToString
@Table(name = "unidades_medida", schema = "fact")
public class UnidadesMedida implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "um_codigo")
    private Integer umCodigo;
    @Basic
    @Column(name = "um_descripcion")
    private String umDescripcion;

}
