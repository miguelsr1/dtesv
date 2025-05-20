package sv.com.jsoft.stdte.model.json;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Direccion {

    private String departamento;
    private String municipio;
    private String complemento;
}
