package sv.com.jsoft.stdte.dto;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.math.BigDecimal;

@Data @NoArgsConstructor @ToString
public class DetalleFacturaDTO {

    private String codigoProd;
    private String descripcion;
    private Integer cantidad;
    private BigDecimal precio;
    private BigDecimal descuentos;
    private BigDecimal impuestos;
    private BigDecimal ivaPercibido;
    private BigDecimal ivaRetenido;
    private BigDecimal otrosCargos;
    private BigDecimal total;
    private String referencia;
    private Integer unidadMedida;
    private Integer tipoProducto;
    private String exento;
    //Hace referencia al impuesto retenido del 13% para FSE
    private BigDecimal retencionIva;
    private String obsDetalle;
    //Hace referencia al impuesto retenido de la renta del 10%
    private BigDecimal retRenta;

}
