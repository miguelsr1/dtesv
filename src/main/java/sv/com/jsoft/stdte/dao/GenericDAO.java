package sv.com.jsoft.stdte.dao;

import java.util.Optional;

public interface GenericDAO <T, K>{


    Optional<T> findById(K id);

    void create(T entity);

    T save(T entity);

    void deleteById(Long id);

    void delete(T entity);
}
