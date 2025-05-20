package sv.com.jsoft.stdte.persistence;

import java.io.Serializable;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import javax.persistence.*;

@Entity @Data @NoArgsConstructor @ToString
@Table(name = "catalogo_plazos", schema = "fact")
public class CatalogoPlazos implements Serializable{
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "cpl_id")
    private int cplId;
    @Basic
    @Column(name = "cpl_cod")
    private String cplCod;
    @Basic
    @Column(name = "cpl_valor")
    private String cplValor;

}
