package sv.com.jsoft.stdte.dto;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.math.BigDecimal;

@Data @NoArgsConstructor @ToString
public class TotalesDTO {
    private String description;
    private BigDecimal value;
}
