package sv.com.jsoft.stdte.persistence;

import java.io.Serializable;
import lombok.Data;
import lombok.NoArgsConstructor;
import javax.persistence.*;

@Entity
@NoArgsConstructor
@Data
@Table(name = "departamentos", schema = "fact")
public class Departamentos implements Serializable {

    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "iddepto")
    private int iddepto;
    @Basic
    @Column(name = "valor")
    private String valor;
    @Basic
    @Column(name = "cod_mh")
    private String codMh;

}
