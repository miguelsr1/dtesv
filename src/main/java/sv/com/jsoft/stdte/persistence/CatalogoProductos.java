package sv.com.jsoft.stdte.persistence;

import java.io.Serializable;
import lombok.Data;
import lombok.ToString;
import javax.persistence.*;
import java.math.BigDecimal;

@Entity
@Data
@ToString
@Table(name = "catalogo_productos", schema = "fact")
public class CatalogoProductos implements Serializable {

    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "idcat_prod")
    private Integer idcatProd;
    @Basic
    @Column(name = "descripcion")
    private String descripcion;
    @Basic
    @Column(name = "valor_unitario", precision = 2, scale = 2)
    private BigDecimal valorUnitario;
    @Basic
    @Column(name = "codigo_prod")
    private String codigoProd;
    @ManyToOne(fetch = FetchType.EAGER, cascade = {CascadeType.PERSIST, CascadeType.MERGE, CascadeType.REFRESH})
    @JoinColumn(name = "um_codigo", referencedColumnName = "um_codigo", insertable = true, updatable = false)
    private UnidadesMedida unidadMedida;
    @Basic
    @Column(name = "cp_exento")
    private String cpExento;
    @Basic
    @Column(name = "cp_activo")
    private String cpActivo;
    @Basic
    @Column(name = "cp_cit_id")
    private Integer cpCitId;
    @Basic
    @Column(name = "cp_codigo_brilo")
    private String cpCodigoBrilo;
    @Transient
    private String undMedDesc;
    @Transient
    private Boolean exento;
    @Transient
    private Boolean activo;

    public CatalogoProductos() {
        unidadMedida = new UnidadesMedida();
    }

}
