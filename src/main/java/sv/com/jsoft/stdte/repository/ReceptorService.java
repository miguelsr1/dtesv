package sv.com.jsoft.stdte.repository;

import java.util.List;
import javax.ejb.Stateless;
import javax.ejb.TransactionManagement;
import javax.ejb.TransactionManagementType;
import javax.persistence.Query;
import lombok.extern.slf4j.Slf4j;
import sv.com.jsoft.stdte.persistence.Contribuyentes;

/**
 *
 * @author msanchez
 */
@Stateless
@TransactionManagement(TransactionManagementType.CONTAINER)
@Slf4j
public class ReceptorService extends AbstractRepository<Contribuyentes, Integer> {

    public ReceptorService() {
        super(Contribuyentes.class);
    }

    public List<Contribuyentes> findReceptoresByQuery(String query, Integer idEmpresa) {
        Query q = em.createQuery("SELECT c FROM Contribuyentes c WHERE (c.rucNitContribuyente like :numDoc or c.rucDuiContribuyente like :numDoc ) and c.idEmpresa = :idEmp", Contribuyentes.class);
        q.setParameter("numDoc", "%" + query.replace("-", "") + "%");
        q.setParameter("idEmp", idEmpresa);
        return q.getResultList();
    }

    public Contribuyentes findReceptoresByNit(String idContribuyente, Integer idEmpresa) {
        Query q = em.createQuery("SELECT c FROM Contribuyentes c WHERE c.rucNitContribuyente = :idCon and c.idEmpresa = :idEmp", Contribuyentes.class);
        q.setParameter("idCon", idContribuyente);
        q.setParameter("idEmp", idEmpresa);
        return q.getResultList().isEmpty() ? new Contribuyentes() : (Contribuyentes) q.getResultList().get(0);
    }
}
