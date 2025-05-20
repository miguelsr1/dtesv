package sv.com.jsoft.stdte.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class EmailDTO {

    private String to;
    private String bcc;
    private String cc;
    private String subject;
    private String body;
    private byte[] attachmentPDF;
    private byte[] attachmentJson;
    private String attachNamePDF;
    private String attachNameJson;
    private String usuario;
}
