package sv.com.jsoft.stdte.view;

import java.io.Serializable;
import java.util.List;
import javax.annotation.PostConstruct;
import javax.faces.view.ViewScoped;
import javax.inject.Inject;
import javax.inject.Named;
import lombok.Getter;
import lombok.Setter;
import sv.com.jsoft.stdte.persistence.ParametrosMh;
import sv.com.jsoft.stdte.repository.ParametrosService;

/**
 *
 * @author migue
 */
@Named
@ViewScoped
public class ParametrosView implements Serializable {

    @Inject
    LoginBean loginBean;
    @Inject
    ParametrosService paramService;

    @Getter
    @Setter
    private List<ParametrosMh> lstParametros;

    private ParametrosMh parametroDto;

    @PostConstruct
    public void init() {
        parametroDto = new ParametrosMh();
        lstParametros = paramService.findAllParametros(loginBean.getLogin().getIdEmpresa());
    }

    public ParametrosMh getParametroDto() {
        return parametroDto;
    }

    public void setParametroDto(ParametrosMh parametroDto) {
        this.parametroDto = parametroDto;
    }

}
