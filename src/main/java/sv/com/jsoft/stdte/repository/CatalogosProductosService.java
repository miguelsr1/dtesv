package sv.com.jsoft.stdte.repository;

import java.util.List;
import javax.ejb.Stateless;
import javax.inject.Inject;
import javax.persistence.EntityManager;
import lombok.extern.slf4j.Slf4j;
import sv.com.jsoft.stdte.persistence.CatalogoProductos;

/**
 *
 * @author msanchez
 */
@Stateless
@Slf4j
public class CatalogosProductosService {
    
    @Inject
    EntityManager em;

    public List<CatalogoProductos> findAllProductosByEmpresa(Integer idEmpresa) {
        try {
            return em.createQuery("SELECT c FROM CatalogoProductos c WHERE c.idEmpresa = :idEmp", CatalogoProductos.class)
                    .setParameter("idEmp", idEmpresa)
                    .getResultList();
        } catch (Exception e) {
            log.error("ERROR EN findAllProductos", e);
            return null;
        }
    }
}
