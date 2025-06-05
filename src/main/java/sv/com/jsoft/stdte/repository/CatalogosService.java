package sv.com.jsoft.stdte.repository;

import org.apache.log4j.Logger;
import sv.com.jsoft.stdte.persistence.*;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;
import java.util.ArrayList;
import java.util.List;

@Stateless
public class CatalogosService {

    protected final static Logger logger = Logger.getLogger(CatalogosService.class);

    @PersistenceContext
    private EntityManager entityManager;

    public List<CatalogoTipoItem> getCatalogoTipoItem() {
        List response = new ArrayList<>();
        try {
            response = entityManager
                    .createQuery("from CatalogoTipoItem")
                    .getResultList();
        } catch (Exception e) {
            logger.error("error getCatalogoTipoItem " + e.getMessage());
        }
        return response;
    }

    public List<CatalogoRecintoFiscal> getCatalogoRecintoFiscal() {
        List response = new ArrayList<>();
        try {
            response = entityManager
                    .createQuery("from CatalogoRecintoFiscal ")
                    .getResultList();
        } catch (Exception e) {
            logger.error("error getCatalogoRecintoFiscal " + e.getMessage());
        }
        return response;
    }

    public List<CatalogoRegimen> getCatalogoRegimen() {
        List response = new ArrayList<>();
        try {
            response = entityManager
                    .createQuery("from CatalogoRegimen ")
                    .getResultList();
        } catch (Exception e) {
            logger.error("error getCatalogoRegimen " + e.getMessage());
        }
        return response;
    }

    public List<CatalogoTipoGeneracionDocumento> getCatalogoTipoGenDoc() {
        List response = new ArrayList<>();
        try {
            response = entityManager.createQuery("from CatalogoTipoGeneracionDocumento ")
                    .getResultList();
        } catch (Exception e) {
            logger.error("error en getCatalogoTipoGenDoc: " + e.getMessage());
        }
        return response;
    }

    public List<CatalogoRetencionIvaMh> getCatalogoRetIvaMh() {
        List response = new ArrayList<>();
        try {
            response = entityManager.createQuery("from CatalogoRetencionIvaMh ")
                    .getResultList();
        } catch (Exception e) {
            logger.error("error en getCatalogoRetIvaMh: " + e.getMessage());
        }
        return response;
    }

    public List<TiposDocumentos> getAllTiposDocumentos() {
        List response = new ArrayList<>();
        try {
            response = entityManager
                    .createQuery("from TiposDocumentos ")
                    .getResultList();
        } catch (Exception e) {
            logger.error("error getAllTiposDocumentos " + e.getMessage());
        }
        return response;
    }

    public List<CatalogoOrigenes> getAllCatalogoOrigenes() {
        List<CatalogoOrigenes> response = new ArrayList<>();
        try {
            TypedQuery<CatalogoOrigenes> query = entityManager.createQuery("SELECT o FROM CatalogoOrigenes o", CatalogoOrigenes.class);
            response = query.getResultList();
        }catch (Exception e) {
            logger.error("error getAllCatalogoOrigenes " + e.getMessage());
        }
        return response;
    }

    public UnidadesMedida getUnidadByCodigo(Integer unidadMedidad){
        return entityManager.find(UnidadesMedida.class, unidadMedidad);
    }
}
