package sv.com.jsoft.stdte.dto;

import lombok.Data;

import java.util.ArrayList;
import java.util.List;

@Data
public class RequestMailDTO {

    private String from;
    private String to;
    private String subject;
    private String content;
    private String htmlContent;
    private List<AttachmentMailDTO> attachments;
    private String bcc;

    public List<AttachmentMailDTO> getAttachments(){
        if(attachments == null)
            attachments = new ArrayList<>();
        return attachments;
    }
}
