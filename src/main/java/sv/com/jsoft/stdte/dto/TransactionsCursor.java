package sv.com.jsoft.stdte.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import net.sf.resultsetmapper.MapToData;

import java.io.Serializable;
import java.util.Date;

@Data @AllArgsConstructor @ToString @NoArgsConstructor @JsonInclude(JsonInclude.Include.NON_NULL)
public class TransactionsCursor implements Serializable {

    @MapToData
    private Date fecha;
    @MapToData
    private Integer cantidad;
    @MapToData
    private String producto;
    @MapToData
    private String sucursal;
    @MapToData
    private String cdc_id;
    @MapToData
    private String nombre;
    @MapToData
    private Date fecha_cobro;

}
