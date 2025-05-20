package sv.com.jsoft.stdte.converter;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import javax.persistence.AttributeConverter;
import java.io.IOException;

//@Converter(autoApply = true)
public class JpaConverterJson implements AttributeConverter<Object, String> {

    private final static ObjectMapper objectMapper = new ObjectMapper();
    @Override
    public String convertToDatabaseColumn(Object attribute) {
        try{
            return objectMapper.writeValueAsString(attribute);
        }catch (JsonProcessingException exception){
            return null;
        }
    }

    @Override
    public Object convertToEntityAttribute(String dbData) {
        try{
            return objectMapper.readValue(dbData, Object.class);
        }catch (IOException exception){
            return null;
        }
    }
}
