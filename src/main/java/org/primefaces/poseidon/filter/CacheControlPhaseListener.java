package org.primefaces.poseidon.filter;

import javax.faces.context.FacesContext;
import javax.faces.event.PhaseEvent;
import javax.faces.event.PhaseId;
import javax.faces.event.PhaseListener;
import javax.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
public class CacheControlPhaseListener implements PhaseListener {

    public PhaseId getPhaseId()
    {
        return PhaseId.RESTORE_VIEW;
    }

    public void afterPhase(PhaseEvent event){
    }

    public void beforePhase(PhaseEvent event)
    {
        FacesContext facesContext = event.getFacesContext();
        HttpServletResponse response = (HttpServletResponse) facesContext
                .getExternalContext().getResponse();
        response.addHeader("Pragma", "no-cache");
        response.addHeader("Cache-Control", "no-cache");
        // Stronger according to blog comment below that references HTTP spec
        response.addHeader("Cache-Control", "no-store");
        response.addHeader("Cache-Control", "must-revalidate");
        // some date in the past
        response.addHeader("Expires", "Mon, 26 Jun 2023 10:00:00 GMT");
    }


}
