package sv.com.jsoft.stdte.dto;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.io.Serializable;

@Data @NoArgsConstructor @ToString
public class GenericResponse implements Serializable {

    private int val;
    private String mensaje;
    private int idFactura;

}
