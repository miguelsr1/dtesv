package sv.com.jsoft.stdte.persistence;

import java.io.Serializable;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.ToString;
import javax.persistence.*;

@Entity
@Data
@EqualsAndHashCode
@NoArgsConstructor
@ToString
@Table(name = "catalogo_recinto_fiscal", schema = "fact")
public class CatalogoRecintoFiscal implements Serializable {

    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "crf_id")
    private int crfId;
    @Basic
    @Column(name = "crf_codigo")
    private String crfCodigo;
    @Basic
    @Column(name = "crf_valor")
    private String crfValor;

}
