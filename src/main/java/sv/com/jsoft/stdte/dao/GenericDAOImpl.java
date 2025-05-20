package sv.com.jsoft.stdte.dao;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.util.Optional;

public class GenericDAOImpl<T, k> implements GenericDAO<T, k>{

    @PersistenceContext
    protected EntityManager em;
    protected final Class<T> entityClass;

    public GenericDAOImpl(Class<T> entityClass){
        this.entityClass = entityClass;
    }

    @Override
    public Optional<T> findById(k id) {
        return Optional.empty();
    }

    @Override
    public void create(T entity) {
        em.persist(entity);
    }

    @Override
    public T save(T entity) {
        return em.merge(entity);
    }

    @Override
    public void deleteById(Long id) {

    }
    @Override
    public void delete(T entity) {

    }


}
