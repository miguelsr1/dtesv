package sv.com.jsoft.stdte.persistence;

import java.io.Serializable;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import javax.persistence.*;

@Entity
@Table(name = "tipos_comprobantes", schema = "fact")
@Getter
@Setter
@ToString
@EqualsAndHashCode
public class TiposComprobantes implements Serializable {

    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "tcp_idtipo")
    private int tcpIdtipo;
    @Basic
    @Column(name = "tcp_comprobante")
    private String tcpComprobante;
    @Basic
    @Column(name = "tcp_descomprobante")
    private String tcpDescomprobante;
    @Basic
    @Column(name = "tcp_idtipcom")
    private String tcpIdtipcom;
    @Basic
    @Column(name = "tcp_version")
    private Integer tcpVersion;

}
