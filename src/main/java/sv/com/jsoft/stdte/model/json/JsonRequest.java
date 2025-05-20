package sv.com.jsoft.stdte.model.json;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.io.Serializable;

@Data @AllArgsConstructor @NoArgsConstructor @ToString
public class JsonRequest implements Serializable {

    private String nit;
    private boolean activo;
    private String passwordPri;
    private String dteJson;
//    private DteJson dteJson;
}
