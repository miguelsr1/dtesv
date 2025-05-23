package sv.com.jsoft.stdte.persistence;

import java.io.Serializable;
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
 * @author msanchez
 */
@Entity
@Data
@NoArgsConstructor
@ToString
@EqualsAndHashCode
@Table(name = "punto_venta", schema = "fact")
public class PuntoVenta implements Serializable{

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_punto_venta", nullable = false)
    private Integer idPuntoVenta;

    @Column(name = "id_establecimiento")
    private Integer idEstablecimiento;

    @Column(name = "nombre_punto_venta", nullable = false, length = 150)
    private String nombrePuntoVenta;

    @Column(name = "codigo_punto_venta", nullable = true, length = 4)
    private String codigoPuntoVenta;

    @Column(name = "codigo_punto_venta_mh", nullable = true, length = 4)
    private String codigoPuntoVentaMh;

    @Column(name = "activo", nullable = false)
    private Boolean activo;

}
