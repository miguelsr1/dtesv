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
@Table(name = "catalogo_condicion_operacion", schema = "fact")
public class CatalogoCondicionOperacion implements Serializable {

    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "idcondicion_operacion")
    private int idcondicionOperacion;
    @Basic
    @Column(name = "Valor")
    private String valor;

}
