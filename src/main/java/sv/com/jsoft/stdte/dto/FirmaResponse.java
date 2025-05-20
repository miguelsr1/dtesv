package sv.com.jsoft.stdte.dto;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.util.ArrayList;
@Data @NoArgsConstructor @ToString
public class FirmaResponse {

    public int version;
    public String ambiente;
    public int versionApp;
    public String estado;
    public String codigoGeneracion;
    public String selloRecibido;
    public String fhProcesamiento;
    public String clasificaMsg;
    public String codigoMsg;
    public String descripcionMsg;
    public ArrayList<Object> observaciones;
}
