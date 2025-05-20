package sv.com.jsoft.stdte.persistence;

import java.io.Serializable;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import javax.persistence.*;

@Entity
@Data
@ToString
@NoArgsConstructor
@Table(name = "catalogo_forma_pago", schema = "fact")
public class CatalogoFormaPago implements Serializable {

    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "idforma_pago")
    private int idformaPago;
    @Basic
    @Column(name = "codigo_mh")
    private String codigoMh;
    @Basic
    @Column(name = "valor")
    private String valor;

}
