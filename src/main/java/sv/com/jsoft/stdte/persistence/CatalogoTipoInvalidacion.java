package sv.com.jsoft.stdte.persistence;

import java.io.Serializable;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import javax.persistence.*;
import java.util.Objects;

@Entity
@Data
@ToString
@NoArgsConstructor
@Table(name = "catalogo_tipo_invalidacion", schema = "fact")
public class CatalogoTipoInvalidacion implements Serializable {

    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "cti_id")
    private int ctiId;
    @Basic
    @Column(name = "cti_valor")
    private String ctiValor;

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }
        CatalogoTipoInvalidacion that = (CatalogoTipoInvalidacion) o;
        return ctiId == that.ctiId && Objects.equals(ctiValor, that.ctiValor);
    }

    @Override
    public int hashCode() {
        return Objects.hash(ctiId, ctiValor);
    }
}
