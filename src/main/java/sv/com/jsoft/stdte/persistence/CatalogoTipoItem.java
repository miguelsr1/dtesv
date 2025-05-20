package sv.com.jsoft.stdte.persistence;

import java.io.Serializable;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.ToString;
import javax.persistence.*;

@Data
@Entity
@Table(name = "catalogo_tipo_item", schema = "fact")
@EqualsAndHashCode
@NoArgsConstructor
@ToString
public class CatalogoTipoItem implements Serializable {

    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "cit_id")
    private int citId;
    @Basic
    @Column(name = "valor")
    private String valor;
}
