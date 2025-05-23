package sv.com.jsoft.stdte.repository;

import javax.ejb.Stateless;
import javax.ejb.TransactionManagement;
import javax.ejb.TransactionManagementType;
import sv.com.jsoft.stdte.persistence.Establecimiento;

/**
 *
 * @author msanchez
 */
@Stateless
@TransactionManagement(TransactionManagementType.CONTAINER)
public class EstablecimientoService extends AbstractRepository<Establecimiento, Integer>{

    public EstablecimientoService(){
        super(Establecimiento.class);
    }
    
}
