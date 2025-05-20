package sv.com.jsoft.stdte.dto;

import java.io.Serializable;
import lombok.Data;

/**
 *
 * @author msanchez
 */
@Data
public class MailAttachment implements Serializable {

    private String base64;
    private String fileName;
    private String mimeType;
}
