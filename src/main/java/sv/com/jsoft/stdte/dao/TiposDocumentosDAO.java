package sv.com.jsoft.stdte.dao;

import sv.com.jsoft.stdte.dto.TiposDocumentosDTO;
import sv.com.jsoft.stdte.persistence.TiposDocumentos;

import java.util.List;

public interface TiposDocumentosDAO extends GenericDAO<TiposDocumentos, Long>{

    List<TiposDocumentosDTO> findAll();
}
