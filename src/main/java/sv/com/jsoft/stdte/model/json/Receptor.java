package sv.com.jsoft.stdte.model.json;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Receptor {

    private String nrc;
    private String nombre;
    private String codActividad;
    private String descActividad;
    private Direccion direccion;
    private String telefono;
    private String correo;
    private String nombreComercial;
    private String nit;
}
