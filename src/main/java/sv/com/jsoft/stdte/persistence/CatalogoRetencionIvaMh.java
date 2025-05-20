package sv.com.jsoft.stdte.persistence;

import java.io.Serializable;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;
import javax.persistence.*;

@Entity
@ToString
@Data
@EqualsAndHashCode
@Table(name = "catalogo_retencion_iva_mh", schema = "fact")
public class CatalogoRetencionIvaMh implements Serializable {

    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "cri_id")
    private int criId;
    @Basic
    @Column(name = "cri_codigo")
    private String criCodigo;
    @Basic
    @Column(name = "cri_valor")
    private String criValor;

}
