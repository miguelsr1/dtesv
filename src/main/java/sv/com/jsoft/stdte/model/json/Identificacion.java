package sv.com.jsoft.stdte.model.json;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import org.jfree.data.time.Hour;

import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Identificacion {

    private int version;
    private String ambiente;
    private String tipoDte;
    private String numeroControl;
    private String codigoGeneracion;
    private int tipoModelo;
    private int tipoOperacion;
    private Integer tipoContingencia;
    private String motivoContin;
    private String fechaEmi;
    private String horEmi;
    private String tipoMoneda;

}
