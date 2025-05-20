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
 * @author aarias_id
 */
@Entity
@Data
@NoArgsConstructor
@ToString
@EqualsAndHashCode
@Table(name = "catalogo_puestos_usuarios", schema = "fact")
public class CatalogoPuestosUsuarios implements Serializable {

    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "cpu_id")
    private Integer cpuId;
    @Basic
    @Column(name = "cpu_descripcion")
    private String cpuDescripcion;
    @Basic
    @Column(name = "cpu_puesto")
    private String cpuPuesto;
}
