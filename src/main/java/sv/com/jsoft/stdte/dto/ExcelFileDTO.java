package sv.com.jsoft.stdte.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.math.BigDecimal;

@Data @AllArgsConstructor @NoArgsConstructor
public class ExcelFileDTO implements Serializable {

    private String estado;
    private String documento;
    private String fecha;
    private String hora;
    private String control;
    private String codigoGeneracion;
    private String selloRecepcion;
    private String identificacionReceptor;
    private String nombre;
    private String condicionVenta;
    private String tipoCambio;
    private String moneda;
    private BigDecimal montoImpuesto;
    private BigDecimal montoTotal;
    private String detFacCantidad;
    private BigDecimal detFacPreciounitario;
    private String detCodigo;
    private String facFechaEmision;
    private String detFacDescripcion;
    private String usuario;
}
