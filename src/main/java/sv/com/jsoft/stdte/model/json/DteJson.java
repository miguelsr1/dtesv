package sv.com.jsoft.stdte.model.json;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.util.List;

@Data @NoArgsConstructor @AllArgsConstructor @ToString
public class DteJson {

    private Identificacion identificacion;
    private String documentoRelacionado;
    private Emisor emisor;
    private Receptor receptor;
    private String otrosDocumentos;
    private String ventaTercero;
    private List<CuerpoDocumento> cuerpoDocumento;
    private Resumen resumen;
    private Extension extension;
    private String apendice;
}
