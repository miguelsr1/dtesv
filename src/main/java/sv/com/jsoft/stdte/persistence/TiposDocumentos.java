package sv.com.jsoft.stdte.persistence;

import java.io.Serializable;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import javax.persistence.*;

@Entity
@Data
@NoArgsConstructor
@ToString
@Table(name = "tipos_documentos", schema = "fact")
public class TiposDocumentos implements Serializable {

    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "doc_id")
    private int docId;
    @Basic
    @Column(name = "doc_idtipo_documento")
    private Integer docIdtipoDocumento;
    @Basic
    @Column(name = "doc_nombre_documento")
    private String docNombreDocumento;

}
