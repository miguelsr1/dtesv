package sv.com.jsoft.stdte.persistence;

import java.io.Serializable;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.ToString;

import javax.persistence.*;

@Entity
@Data
@ToString
@EqualsAndHashCode
@NoArgsConstructor
@Table(name = "catalogo_regimen", schema = "fact")
public class CatalogoRegimen implements Serializable {

    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "crg_id")
    private int crgId;
    @Basic
    @Column(name = "crg_codigo")
    private String crgCodigo;
    @Basic
    @Column(name = "crg_valor")
    private String crgValor;

}
