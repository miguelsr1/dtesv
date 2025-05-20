package sv.com.jsoft.stdte.ejb;

import javax.enterprise.context.ApplicationScoped;
import javax.enterprise.inject.Produces;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

@ApplicationScoped
public class EntityManagerProducer {

    @PersistenceContext(name ="BuzonCsvPersistenceUnit")
    private EntityManager entityManager;

    @Produces
    public EntityManager produceEntityManager(){
        return entityManager;
    }
}
