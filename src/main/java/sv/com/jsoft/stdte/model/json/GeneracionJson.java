package sv.com.jsoft.stdte.model.json;

import com.google.gson.JsonObject;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.io.Serializable;

@Data @NoArgsConstructor @ToString
public class GeneracionJson implements Serializable {

    private JsonObject json;
    private String codigoGeneracion;
}
