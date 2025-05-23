package sv.com.jsoft.stdte.repository;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

/**
 *
 * @author msanchez
 * @param <Entity>
 * @param <Primary>
 */
public class AbstractRepository<Entity, Primary> {

    @PersistenceContext
    public EntityManager em;

    private final Class<Entity> entityClass;

    public AbstractRepository(Class<Entity> entityClass) {
        this.entityClass = entityClass;
    }

    public Entity save(Entity entity) {
        try {
            em.persist(entity);
            em.flush();
            return entity;
        } catch (Exception e) {
            return null;
        }
    }

    public void update(Entity entity) {
        em.merge(entity);
    }

    public void delete(Entity entity) {
        em.remove(em.contains(entity) ? entity : em.merge(entity));
    }

    public Entity findByPk(Primary pk) {
        return em.find(entityClass, pk);
    }
}
