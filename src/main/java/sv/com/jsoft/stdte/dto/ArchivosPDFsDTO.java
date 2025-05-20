package sv.com.jsoft.stdte.dto;

import lombok.Data;
import net.sf.jasperreports.engine.JasperPrint;

@Data
public class ArchivosPDFsDTO {

    private JasperPrint jasperPrint;
    private String jsonDocument;
    private String fileName;
}
