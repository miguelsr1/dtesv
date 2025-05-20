package sv.com.jsoft.stdte.view;

import java.io.Serializable;
import javax.ejb.EJB;
import javax.faces.view.ViewScoped;
import javax.inject.Inject;
import javax.inject.Named;
import lombok.Getter;
import lombok.Setter;
import sv.com.jsoft.stdte.dto.GenericResponse;
import sv.com.jsoft.stdte.repository.AppService;
import sv.com.jsoft.stdte.utils.ViewUtils;

/**
 *
 * @author aarias_id
 */
@Named("ticketCort")
@ViewScoped
public class TicketCortesiaBean implements Serializable {
    
    @Getter
    @Setter
    private Integer correlativo;
    
    @EJB
    AppService service;
    
    @Inject
    LoginBean loginBean;
    
    public void onClickButton() {

        //Validar si existe documento relacionado para tipo nota de crédito o débito
        GenericResponse response = service.callProTicketCortesia(correlativo, loginBean.getLogin(), "TICKETCORTESIA");
        if (response.getVal() == 0) {
            ViewUtils.showMessageInfo(response.getMensaje()!= null? response.getMensaje().toUpperCase():"SE AGREGO EL INDICATIVO DE CORTESIA AL TICKET CORRECTAMENTE");
        } else {
            ViewUtils.showMessageError("NO EXISTE NÚMERO DE DOCUMENTO RELACIONADO, VERIFIQUE E INTENTE NUEVAMENTE");
        }

    }
    
}
