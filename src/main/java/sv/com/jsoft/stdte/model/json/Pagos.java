package sv.com.jsoft.stdte.model.json;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.math.BigDecimal;

@Data @NoArgsConstructor @ToString
public class Pagos {
    private String plazo;
    private String codigo;
    private int periodo;
    private BigDecimal montoPago;
    private String referencia;
}
