package sv.com.jsoft.stdte.model.json;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.beans.BeanInfo;
import java.math.BigDecimal;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Resumen {

    private BigDecimal totalNoSuj;
    private BigDecimal totalExenta;
    private BigDecimal totalGravada;
    private BigDecimal subTotalVentas;
    private BigDecimal descuNoSuj;
    private BigDecimal descuExenta;
    private BigDecimal descuGravada;
    private BigDecimal porcentajeDescuento;
    private BigDecimal totalDescu;
    private List<Tributos> tributos;
    private BigDecimal subTotal;
    private BigDecimal ivaPerci1;
    private BigDecimal ivaRete1;
    private BigDecimal reteRenta;
    private BigDecimal montoTotalOperacion;
    private BigDecimal totalNoGravado;
    private BigDecimal totalPagar;
    private String totalLetras;
    private BigDecimal saldoFavor;
    private int condicionOperacion;
    private List<Pagos> pagos;
    private String numPagoElectronico;

}
