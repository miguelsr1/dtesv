package sv.com.jsoft.stdte.persistence;

import lombok.*;

import javax.persistence.*;
import java.io.Serializable;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Date;

@Entity
@NoArgsConstructor
@Data
@ToString
@EqualsAndHashCode
@Table(name = "buzoncsv", schema = "fact")
public class Buzoncsv implements Serializable {

    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "id_buzon")
    private int idBuzon;
    @Basic
    @Column(name = "cod_factura")
    private String codFactura;
    @Basic
    @Column(name = "cod_emisor")
    private String codEmisor;
    @Basic
    @Column(name = "tipodoc")
    private String tipodoc;
    @Basic
    @Column(name = "tipodocrec")
    private Integer tipodocrec;
    @Basic
    @Column(name = "nit")
    private String nit;
    @Basic
    @Column(name = "nrc")
    private Integer nrc;
    @Basic
    @Column(name = "nombrecliente")
    private String nombrecliente;
    @Basic
    @Column(name = "correo")
    private String correo;
    @Basic
    @Column(name = "telefono")
    private String telefono;
    @Basic
    @Column(name = "moneda")
    private String moneda;
    @Basic
    @Column(name = "tipocambio")
    private Integer tipocambio;
    @Basic
    @Column(name = "depart")
    private String depart;
    @Basic
    @Column(name = "municipio")
    private Integer municipio;
    @Basic
    @Column(name = "complemento")
    private String complemento;
    @Basic
    @Column(name = "codactcom")
    private String codactcom;
    @Basic
    @Column(name = "codigo")
    private String codigo;
    @Basic
    @Column(name = "detalle")
    private String detalle;
    @Basic
    @Column(name = "unidad_medida")
    private Integer unidadMedida;
    @Basic
    @Column(name = "tipo")
    private Integer tipo;
    @Basic
    @Column(name = "cantidad")
    private BigDecimal cantidad;
    @Basic
    @Column(name = "precio_unitario")
    private BigDecimal precioUnitario;
    @Basic
    @Column(name = "descuento")
    private BigDecimal descuento;
    @Basic
    @Column(name = "exento")
    private String exento;
    @Basic
    @Column(name = "codigo_")
    private Integer codigoImp;
    @Basic
    @Column(name = "porcentaje")
    private Integer porcentaje;
    @Basic
    @Column(name = "valor")
    private String valor;
    @Basic
    @Column(name = "condicionpago")
    private Integer condicionpago;
    @Basic
    @Column(name = "mediopago")
    private String mediopago;
    @Basic
    @Column(name = "monto")
    private String monto;
    @Basic
    @Column(name = "referencia")
    private String referencia;
    @Basic
    @Column(name = "plazo")
    private String plazo;
    @Basic
    @Column(name = "periodo")
    private String periodo;
    @Basic
    @Column(name = "tipogeneracion")
    private String tipogeneracion;
    @Basic
    @Column(name = "tipodte")
    private String tipodte;
    @Basic
    @Column(name = "numeroautorizacion")
    private String numeroautorizacion;
    @Basic
    @Column(name = "fechahoraemision")
    private String fechahoraemision;
    @Basic
    @Column(name = "tipodocidreceptor")
    private String tipodocidreceptor;
    @Basic
    @Column(name = "bientitulo")
    private String bientitulo;
    @Basic
    @Column(name = "fecha_migrado")
    private Timestamp fechaMigrado;
    @Basic
    @Column(name = "factura_migrada")
    private String facturaMigrada;
    @Basic
    @Column(name = "buzoncsvcol")
    private String buzoncsvcol;
    @Basic
    @Column(name = "tipo_item_expor")
    private Integer tipoItemExpor;
    @Basic
    @Column(name = "recinto_fiscal")
    private String recintoFiscal;
    @Basic
    @Column(name = "regimen")
    private String regimen;
    @Basic
    @Column(name = "doc_relacionado")
    private String docRelacionado;
    @Basic
    @Column(name = "tipo_doc_relacionado")
    private String tipoDocRelacionado;
    @Basic
    @Column(name = "fecha_doc_relacionado")
    private Date fechaDocRelacionado;
    @Basic
    @Column(name = "tipo_generacion_doc_rel")
    private Integer tipoGeneracionDocRel;
    @Transient
    private String descripcion_doc_relacionado;
    @Transient
    private BigDecimal monto_retencion_iva;
    @Transient
    private Integer codigo_retencion;
    @Transient
    private BigDecimal monto_sujeto_gravado;
    @Basic
    @Column(name = "descripcion_retencion")
    private String descripcionRetencion;
    @Basic
    @Column(name = "id_retencion")
    private String idRetencion;
    @Basic
    @Column(name = "nombre_receptor")
    private String nombreReceptor;
    @Basic
    @Column(name = "cdc_id")
    private Integer cdcId;
    @Basic
    @Column(name = "id_factura")
    private Integer idFactura;
    @Basic
    @Column(name = "anulacion")
    private String anulacion;
    @Basic
    @Column(name = "retencion_iva")
    private BigDecimal retencionIva;
    @Basic
    @Column(name = "retencion_iva_porc")
    private BigDecimal retencionIvaPorc;
    @Basic
    @Column(name = "observaciones_detalles")
    private String observacionesDetalles;
    @Basic
    @Column(name = "impuesto_reten_retenido")
    private BigDecimal impuestoRetenRetenido;
    @Basic
    @Column(name = "impuesto_reten_retenido_porc")
    private BigDecimal impuestoRetenRetenidoPorc;
    @Basic
    @Column(name = "id_usuario_ingreso")
    private String idUsuarioIngreso;
}
