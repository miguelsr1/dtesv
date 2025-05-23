package sv.com.jsoft.stdte.lazy;

import org.primefaces.model.FilterMeta;
import org.primefaces.model.LazyDataModel;
import org.primefaces.model.SortMeta;
import org.primefaces.model.SortOrder;
import sv.com.jsoft.stdte.persistence.Contribuyentes;

import javax.persistence.EntityManager;
import javax.persistence.TypedQuery;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import javax.persistence.metamodel.Attribute;
import java.util.List;
import java.util.Map;

public class CustomLazyDataModel<T> extends LazyDataModel<T> {

    private final EntityManager entityManager;
    private Class<T> entityClass;
    private final String idField;
    private final Integer idEmpresa;

    public CustomLazyDataModel(EntityManager entityManager, Class<T> entityClass, String idField, Integer idEmpresa) {
        this.entityClass = entityClass;
        this.entityManager = entityManager;
        this.idField = idField;
        this.idEmpresa = idEmpresa;
    }

    @Override
    public T getRowData(String rowKey) {
        try {
            Integer id = Integer.valueOf(rowKey);
            return entityManager.find(entityClass, id);
        } catch (NumberFormatException e) {
            throw new UnsupportedOperationException("Could not convert rowKey to ID");
        }
    }

    @Override
    public String getRowKey(T object) {
        try {
            var field = entityClass.getDeclaredField(idField);
            field.setAccessible(true);
            return String.valueOf(field.get(object));
        } catch (NoSuchFieldException | IllegalAccessException e) {
            throw new UnsupportedOperationException("Could not extract row key", e);
        }
    }

    @Override
    public int count(Map<String, FilterMeta> filterBy) {
        CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
        CriteriaQuery<Long> criteriaQuery = criteriaBuilder.createQuery(Long.class);
        Root<T> root = criteriaQuery.from(entityClass);

        //Get additional conditions based on the entity
        Predicate additionalCondition = getAdditionalCondition(criteriaBuilder, root);

        criteriaQuery.select(criteriaBuilder.count(root));
        criteriaQuery.where(criteriaBuilder.and(additionalCondition, applyFilters(criteriaBuilder, root, filterBy)));

        return entityManager.createQuery(criteriaQuery).getSingleResult().intValue();
    }

    @Override
    public List<T> load(int first, int pageSize, Map<String, SortMeta> sortBy, Map<String, FilterMeta> filterBy) {
        CriteriaBuilder cb = entityManager.getCriteriaBuilder();
        CriteriaQuery<T> cq = cb.createQuery(entityClass);
        Root<T> root = cq.from(entityClass);

        //Get additional conditions based on the entity
        Predicate additionalCondition = getAdditionalCondition(cb, root);

        cq.where(cb.and(additionalCondition, applyFilters(cb, root, filterBy)));
        applySorting(cb, cq, root, sortBy);

        TypedQuery<T> query = entityManager.createQuery(cq);
        query.setFirstResult(first);
        query.setMaxResults(pageSize);

        return query.getResultList();
    }

    private Predicate applyFilters(CriteriaBuilder cb, Root<T> root, Map<String, FilterMeta> filterBy) {
        Predicate predicate = cb.conjunction();
        if (filterBy != null) {
            for (Map.Entry<String, FilterMeta> entry : filterBy.entrySet()) {
                String filterKey = entry.getKey();
                String filterValue = (String) entry.getValue().getFilterValue();

                if (filterValue != null && !filterValue.isEmpty()) {
                    if ("globalFilter".equals(filterKey)) {
                        Predicate globalPredicate = cb.disjunction();
                        // Dynamically apply global filter to all string fields
                        for (Attribute<? super T, ?> attribute : root.getModel().getAttributes()) {
                            if (attribute.getJavaType().equals(String.class)) {
                                globalPredicate = cb.or(globalPredicate, cb.like(cb.lower(root.get(attribute.getName())), "%" + filterValue.toLowerCase() + "%"));
                            }
                        }
                        predicate = cb.and(predicate, globalPredicate);
                    } else {
                        predicate = cb.and(predicate, cb.like(cb.lower(root.get(filterKey)), "%" + filterValue.toLowerCase() + "%"));
                    }
                }
            }
        }
        return predicate;
    }

    private void applySorting(CriteriaBuilder cb, CriteriaQuery<T> cq, Root<T> root, Map<String, SortMeta> sortBy) {
        if (sortBy != null && !sortBy.isEmpty()) {
            for (SortMeta meta : sortBy.values()) {
                if (meta.getOrder() == SortOrder.ASCENDING) {
                    cq.orderBy(cb.asc(root.get(meta.getField())));
                } else if (meta.getOrder() == SortOrder.DESCENDING) {
                    cq.orderBy(cb.desc(root.get(meta.getField())));
                }
            }
        }
    }

    private Predicate getAdditionalCondition(CriteriaBuilder cb, Root<T> root) {
        if (Contribuyentes.class.isAssignableFrom(entityClass)) {
            return cb.equal(root.get("idEmpresa"), idEmpresa);
        } else {
            return cb.conjunction(); //No additional condition
        }
    }
}
