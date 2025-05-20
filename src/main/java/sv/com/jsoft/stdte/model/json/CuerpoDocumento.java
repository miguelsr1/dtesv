package sv.com.jsoft.stdte.model.json;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.math.BigDecimal;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class CuerpoDocumento {

    private int numItem;
    private Integer numeroDocumento;
    private int tipoItem;
    private int cantidad;
    private Integer codigo;
    private int uniMedida;
    private String descripcion;
    private BigDecimal precioUni;
    private Integer codTributo;
    private BigDecimal ventaNoSuj;
    private BigDecimal ventaExenta;
    private BigDecimal ventaGravada;
    private Tributos tributos;
    private int psv;
    private BigDecimal noGravado;
    private BigDecimal montoDescu;

}
