package sv.com.jsoft.stdte.model.json;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.math.BigDecimal;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Tributos {

    private String codigo;
    private String descripcion;
    private BigDecimal valor;
}
