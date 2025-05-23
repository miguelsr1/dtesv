package sv.com.jsoft.stdte.view;

import java.io.Serializable;
import javax.annotation.PostConstruct;
import javax.enterprise.context.RequestScoped;
import javax.inject.Named;
import lombok.Getter;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import org.primefaces.PrimeFaces;
import sv.com.jsoft.stdte.persistence.Establecimiento;

/**
 *
 * @author msanchez
 */
@RequestScoped
@Named
@Slf4j
public class DlgEstablecimiento implements Serializable {

    @Getter
    @Setter
    private Establecimiento establecimientoDto;

    @PostConstruct
    public void init() {
        establecimientoDto = new Establecimiento();
        establecimientoDto.setActivo(Boolean.TRUE);
    }

    public void addEstable() {
        saveEstable();
        PrimeFaces.current().dialog().closeDynamic(establecimientoDto);
    }

    private void saveEstable() {
        
    }

    public void closeDgl() {
        PrimeFaces.current().dialog().closeDynamic(null);
    }
}
