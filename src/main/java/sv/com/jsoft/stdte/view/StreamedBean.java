package sv.com.jsoft.stdte.view;

import org.primefaces.model.DefaultStreamedContent;
import javax.inject.Named;
import java.io.Serializable;
import javax.enterprise.context.SessionScoped;

@SessionScoped
@Named("streamedCtrl")
public class StreamedBean implements Serializable {
    private DefaultStreamedContent exportFile;

    public DefaultStreamedContent getExportFile(){
        return exportFile;
    }

    public void setExportFile(DefaultStreamedContent exportFile){
        this.exportFile = exportFile;
    }

}
