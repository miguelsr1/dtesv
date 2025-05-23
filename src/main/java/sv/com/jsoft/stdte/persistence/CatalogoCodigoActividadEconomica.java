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
@NoArgsConstructor
@EqualsAndHashCode
@Table(name = "catalogo_codigo_actividad_economica", schema = "fact")
public class CatalogoCodigoActividadEconomica implements Serializable {

    @Id
    @Column(name = "ccae_codigo")
    private String ccaeCodigo;
    @Basic
    @Column(name = "ccae_valor")
    private String ccaeValor;

}
