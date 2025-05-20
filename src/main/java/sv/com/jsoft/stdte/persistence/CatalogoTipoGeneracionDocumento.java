package sv.com.jsoft.stdte.persistence;

import java.io.Serializable;
import lombok.Data;
import lombok.EqualsAndHashCode;
import javax.persistence.*;

@Entity
@Data
@EqualsAndHashCode
@Table(name = "catalogo_tipo_generacion_documento", schema = "fact")
public class CatalogoTipoGeneracionDocumento implements Serializable {

    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "ctgd_id")
    private int ctgdId;
    @Basic
    @Column(name = "ctgd_valor")
    private String ctgdValor;
}
