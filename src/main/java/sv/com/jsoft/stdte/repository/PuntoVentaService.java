package sv.com.jsoft.stdte.repository;

import javax.ejb.Stateless;
import javax.ejb.TransactionManagement;
import javax.ejb.TransactionManagementType;
import sv.com.jsoft.stdte.persistence.PuntoVenta;

/**
 *
 * @author msanchez
 */
@Stateless
@TransactionManagement(TransactionManagementType.CONTAINER)
public class PuntoVentaService extends AbstractRepository<PuntoVenta, Integer> {

    public PuntoVentaService() {
        super(PuntoVenta.class);
    }

}
