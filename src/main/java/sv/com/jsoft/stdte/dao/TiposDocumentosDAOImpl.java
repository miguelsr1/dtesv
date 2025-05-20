package sv.com.jsoft.stdte.dao;

import org.modelmapper.ModelMapper;
import sv.com.jsoft.stdte.dto.TiposDocumentosDTO;
import sv.com.jsoft.stdte.persistence.TiposDocumentos;

import javax.enterprise.context.ApplicationScoped;
import java.util.List;
import java.util.stream.Collectors;

@ApplicationScoped
public class TiposDocumentosDAOImpl extends GenericDAOImpl<TiposDocumentos, Long> implements TiposDocumentosDAO{

    ModelMapper modelMapper = new ModelMapper();

    public TiposDocumentosDAOImpl(){
        super(TiposDocumentos.class);
    }

    @Override
    public List<TiposDocumentosDTO> findAll(){
        List<TiposDocumentos> resultList = em.createQuery("SELECT td FROM TiposDocumentos td", TiposDocumentos.class)
                .getResultList();
        if(resultList.size() > 0){
            return resultList.stream()
                    .map(entity -> modelMapper.map(entity, TiposDocumentosDTO.class))
                    .collect(Collectors.toList());
        }else{
            return null;
        }
    }
}
