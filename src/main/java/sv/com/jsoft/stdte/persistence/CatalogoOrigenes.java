package sv.com.jsoft.stdte.persistence;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.ToString;

/**
 *
 * @author tramite
 */
@Entity
@Data
@NoArgsConstructor
@ToString
@EqualsAndHashCode
@Table(name = "catalogo_origenes", schema = "fact")
public class CatalogoOrigenes implements Serializable {

    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "co_id")
    private Integer coId;
    @Basic
    @Column(name = "co_abreviatura")
    private String coAbreviatura;
    @Basic
    @Column(name = "co_descripcion")
    private String coDescripcion;
}
