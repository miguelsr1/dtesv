package sv.com.jsoft.stdte.repository;

import java.util.List;
import javax.ejb.Stateless;
import javax.inject.Inject;
import javax.persistence.EntityManager;
import javax.persistence.Query;
import lombok.extern.slf4j.Slf4j;
import sv.com.jsoft.stdte.persistence.ParametrosMh;

/**
 *
 * @author msanchez
 */
@Stateless
@Slf4j
public class ParametrosService {

    @Inject
    EntityManager em;

    public List<ParametrosMh> findAllParametros(Integer idEmpresa) {
        Query q = em.createQuery("SELECT p FROM ParametrosMh p WHERE p.idEmpresa = :idEmp", ParametrosMh.class);
        q.setParameter("idEmp", idEmpresa);
        return q.getResultList();
    }
}
