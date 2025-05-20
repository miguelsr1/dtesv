package sv.com.jsoft.stdte.dto;

import lombok.Data;

import java.io.Serializable;

@Data
public class AttachmentMailDTO implements Serializable {
    private String name;
    private String type;
    private String content;
}
