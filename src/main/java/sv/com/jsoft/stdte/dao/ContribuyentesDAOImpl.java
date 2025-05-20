package sv.com.jsoft.stdte.dao;

import sv.com.jsoft.stdte.persistence.Contribuyentes;

import javax.enterprise.context.ApplicationScoped;

@ApplicationScoped
public class ContribuyentesDAOImpl extends GenericDAOImpl<Contribuyentes, Long> implements ContribuyentesDAO{

    public ContribuyentesDAOImpl(){
        super(Contribuyentes.class);
    }

}
