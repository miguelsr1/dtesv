package sv.com.jsoft.stdte.persistence;

import java.io.Serializable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.ToString;
import org.jdbi.v3.sqlobject.transaction.Transaction;

/**
 *
 * @author msanchez
 */
@Entity
@Data
@NoArgsConstructor
@ToString
@EqualsAndHashCode
@Table(name = "establecimiento", schema = "fact")
public class Establecimiento implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_establecimiento", nullable = false)
    private Integer idEstablecimiento;

    @Column(name = "id_contribuyente", nullable = false)
    private Integer idContribuyente;

    @Column(name = "nombre_sucursal", nullable = false, length = 150)
    private String nombreSucursal;

    @Column(name = "codigo_estable", nullable = false, length = 4)
    private String codigoEstable;

    @Column(name = "codigo_estable_mh", nullable = false, length = 4)
    private String codigoEstableMh;

    @Column(name = "activo", nullable = false)
    private Boolean activo;

    @Column(name = "tipo_establecimiento", nullable = false, length = 2)
    private String tipoEstablecimiento;

    @Transient
    private String strTipoEstable;
    
    public String getStrTipoEstable() {
        switch (tipoEstablecimiento) {
            case "01":
                return "SUCURSAL";
            case "02":
                return "CASA MATRIZ";
            case "04":
                return "BODEGA";
            case "07":
                return "PATIO";
            default:
                return "N/A";
        }
    }
}
