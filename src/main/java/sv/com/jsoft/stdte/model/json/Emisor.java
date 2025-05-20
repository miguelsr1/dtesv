package sv.com.jsoft.stdte.model.json;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Emisor {

    private String nit;
    private String nrc;
    private String correo;
    private String nombre;
    private String telefono;
    private Direccion direccion;
    private String codEstable;
    private String codActividad;
    private String codEstableMH;
    private String codPuntoVenta;
    private String descActividad;
    private String codPuntoVentaMH;
    private String nombreComercial;
    private String tipoEstablecimiento;
}
