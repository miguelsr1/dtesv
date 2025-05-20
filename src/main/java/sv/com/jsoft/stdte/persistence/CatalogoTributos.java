package sv.com.jsoft.stdte.persistence;

import java.io.Serializable;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import javax.persistence.*;
import java.math.BigDecimal;

@Entity
@Data
@NoArgsConstructor
@ToString
@Table(name = "catalogo_tributos", schema = "fact")
public class CatalogoTributos implements Serializable {

    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "idcatalogo_tributos")
    private int idcatalogoTributos;
    @Basic
    @Column(name = "codigo")
    private String codigo;
    @Basic
    @Column(name = "descripcion")
    private String descripcion;

    @Transient
    private BigDecimal montoImpuesto;

}
