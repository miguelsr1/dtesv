package sv.com.jsoft.stdte.model.json;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data @AllArgsConstructor @NoArgsConstructor
@ToString
public class JsonResponse {
    private String status;
    private String body;

}
