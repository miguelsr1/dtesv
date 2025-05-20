package sv.com.jsoft.stdte.dao;

import org.modelmapper.ModelMapper;
import sv.com.jsoft.stdte.dto.CatCodActEconomicaDTO;
import sv.com.jsoft.stdte.persistence.CatalogoCodigoActividadEconomica;

import javax.enterprise.context.ApplicationScoped;
import java.util.List;
import java.util.stream.Collectors;

@ApplicationScoped
public class CatCodActEconomicaDAOImpl extends GenericDAOImpl<CatalogoCodigoActividadEconomica, Long> implements CatCodActEconomicaDAO {

    ModelMapper modelMapper = new ModelMapper();
    public CatCodActEconomicaDAOImpl(){
        super(CatalogoCodigoActividadEconomica.class);
    }

    @Override
    public List<CatCodActEconomicaDTO> findAll(){
        List<CatalogoCodigoActividadEconomica> resultList = em.createQuery("SELECT cae FROM CatalogoCodigoActividadEconomica cae", CatalogoCodigoActividadEconomica.class)
                .getResultList();
        if(resultList.size() > 0){
            return resultList.stream()
                    .map(entity -> modelMapper.map(entity, CatCodActEconomicaDTO.class))
                    .collect(Collectors.toList());
        }else{
            return null;
        }
    }
}
