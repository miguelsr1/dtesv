package sv.com.jsoft.stdte.repository;

import javax.ejb.Stateless;
import javax.ejb.TransactionManagement;
import javax.ejb.TransactionManagementType;
import javax.persistence.Query;
import lombok.extern.slf4j.Slf4j;
import sv.com.jsoft.stdte.persistence.Empresa;

/**
 *
 * @author msanchez
 */
@Stateless
@TransactionManagement(TransactionManagementType.CONTAINER)
@Slf4j
public class EmisorService extends AbstractRepository<Empresa, Long> {

    public EmisorService() {
        super(Empresa.class);
    }

    public Empresa getEmisorByUsuario(String usuario) {
        Query q = em.createQuery("SELECT e FROM Empresa e WHERE e.usuario = :usuario", Empresa.class);
        q.setParameter("usuario", usuario);
        return q.getResultList().isEmpty() ? new Empresa() : (Empresa) q.getSingleResult();
    }
}
