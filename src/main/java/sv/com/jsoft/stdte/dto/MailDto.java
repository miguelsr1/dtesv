package sv.com.jsoft.stdte.dto;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import lombok.Data;

/**
 *
 * @author msanchez
 */
@Data
public class MailDto implements Serializable {

    private String mfa;
    private String to;
    private String subject;
    private String body;
    private List<MailAttachment> files;

    public MailDto() {
        files = new ArrayList<>();
    }
}
