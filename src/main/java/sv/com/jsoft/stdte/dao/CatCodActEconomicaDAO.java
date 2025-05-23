package sv.com.jsoft.stdte.dao;

import sv.com.jsoft.stdte.dto.CatCodActEconomicaDTO;
import sv.com.jsoft.stdte.persistence.CatalogoCodigoActividadEconomica;
import java.util.List;

public interface CatCodActEconomicaDAO extends GenericDAO<CatalogoCodigoActividadEconomica, Long> {

    List<CatCodActEconomicaDTO> findAll();
}
