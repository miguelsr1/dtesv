package sv.com.jsoft.stdte.model.json;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Extension {

    private String nombEntrega;
    private String docuEntrega;
    private String nombRecibe;
    private String docuRecibe;
    private String placaVehiculo;
    private String observaciones;
}
