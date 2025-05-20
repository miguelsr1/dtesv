package sv.com.jsoft.stdte.model.json;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.io.Serializable;

@Data @AllArgsConstructor @NoArgsConstructor @ToString
public class JsonRequestSignedDoc implements Serializable {

    private int version;
    private String ambiente;
    private int idEnvio;
    private String tipoDte;
    private String codigoGeneracion;
    private String dteFirmado;
    private String documento;

}
