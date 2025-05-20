package sv.com.jsoft.stdte.persistence;

import java.io.Serializable;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import org.hibernate.annotations.DynamicUpdate;
import javax.persistence.*;
import java.math.BigDecimal;
import java.util.Arrays;
import java.util.Date;
import java.util.Objects;

@Entity
@Table(name = "factura", schema = "fact")
@Getter
@Setter
@ToString
@NoArgsConstructor
@DynamicUpdate
public class Factura implements Serializable{

    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "fac_id")
    private Integer facId;
    @Basic
    @Column(name = "fac_nro_factura")
    private String facNroFactura;
    @Basic
    @Column(name = "fac_fecha_emision")
    @Temporal(javax.persistence.TemporalType.DATE)
    private Date facFechaEmision;
    @Basic
    @Column(name = "fac_actividad_giro")
    private String facActividadGiro;
    @Basic
    @Column(name = "fac_nit_emisor")
    private String facNitEmisor;
    @Basic
    @Column(name = "fac_nit_receptor")
    private String facNitReceptor;
    @Basic
    @Column(name = "fac_telefono")
    private String facTelefono;
    @Basic
    @Column(name = "fac_razonsocial")
    private String facRazonsocial;
    @Basic
    @Column(name = "fac_retenido")
    private BigDecimal facRetenido;
    @Basic
    @Column(name = "fac_sumas_detalle")
    private BigDecimal facSumasDetalle;
    @Basic
    @Column(name = "fac_total_pagar")
    private BigDecimal facTotalPagar;
    @Basic
    @Column(name = "fac_firma")
    private byte[] facFirma;
    @Basic
    @Column(name = "fac_ncr")
    private String facNcr;
    @Basic
    @Column(name = "fac_estado_factura")
    private Integer facEstadoFactura;
    @Basic
    @Column(name = "fac_codigo_generacion")
    private String facCodigoGeneracion;
    @Basic
    @Column(name = "fac_numero_de_control")
    private String facNumeroDeControl;
    @Basic
    @Column(name = "fac_tipo_documento")
    private Integer facTipoDocumento;
    @Basic
    @Column(name = "fac_sello_de_recepcion")
    private byte[] facSelloDeRecepcion;
    @Basic
    @Column(name = "fac_total_iva")
    private BigDecimal facTotalIva;
    @Basic
    @Column(name = "fac_tipo_comprobante")
    private String facTipoComprobante;
    @Basic
    @Column(name = "fac_ventasnosujet_tot")
    private BigDecimal facVentasnosujetTot;
    @Basic
    @Column(name = "fac_ventasexentas_tot")
    private BigDecimal facVentasexentasTot;
    @Basic
    @Column(name = "fac_ventasgravadas_tot")
    private BigDecimal facVentasgravadasTot;
    @Basic
    @Column(name = "fac_iva_retenido")
    private BigDecimal facIvaRetenido;
    @Basic
    @Column(name = "fac_saldo_favor")
    private BigDecimal facSaldoFavor;
    @Basic
    @Column(name = "fac_total_nograbado")
    private BigDecimal facTotalNograbado;
    @Basic
    @Column(name = "fac_descuento_nosuje")
    private BigDecimal facDescuentoNosuje;
    @Basic
    @Column(name = "fac_descuento_exent")
    private BigDecimal facDescuentoExent;
    @Basic
    @Column(name = "fac_retencion_renta")
    private BigDecimal facRetencionRenta;
    @Basic
    @Column(name = "fac_tot_descuento")
    private BigDecimal facTotDescuento;
    @Basic
    @Column(name = "fac_total_letras")
    private String facTotalLetras;
    @Basic
    @Column(name = "fac_descuento_grab")
    private BigDecimal facDescuentoGrab;
    @Basic
    @Column(name = "fac_porcen_descuento")
    private BigDecimal facPorcenDescuento;
    @Basic
    @Column(name = "fac_tributos")
    private BigDecimal facTributos;
    @Basic
    @Column(name = "fac_subtotal")
    private BigDecimal facSubtotal;
    @Basic
    @Column(name = "fac_iva_porcent")
    private BigDecimal facIvaPorcent;
    @Basic
    @Column(name = "fac_subtotalventas")
    private BigDecimal facSubtotalventas;
    @Basic
    @Column(name = "fac_ivaperci1")
    private BigDecimal facIvaperci1;
    @Basic
    @Column(name = "fac_montototaloperacion")
    private String facMontototaloperacion;
    @Basic
    @Column(name = "fac_numpagoelectronico")
    private String facNumpagoelectronico;
    @Basic
    @Column(name = "fac_condicion_operacion")
    private Integer facCondicionOperacion;
    @Basic
    @Column(name = "fac_fecha_ini_periodo")
    private Date facFechaIniPeriodo;
    @Basic
    @Column(name = "fac_fecha_fin_periodo")
    private Date facFechaFinPeriodo;
    @Basic
    @Column(name = "fac_observaciones")
    private String facObservaciones;

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }
        Factura factura = (Factura) o;
        return facId == factura.facId && Objects.equals(facNroFactura, factura.facNroFactura) && Objects.equals(facFechaEmision, factura.facFechaEmision) && Objects.equals(facActividadGiro, factura.facActividadGiro) && Objects.equals(facNitEmisor, factura.facNitEmisor) && Objects.equals(facNitReceptor, factura.facNitReceptor) && Objects.equals(facTelefono, factura.facTelefono) && Objects.equals(facRazonsocial, factura.facRazonsocial) && Objects.equals(facRetenido, factura.facRetenido) && Objects.equals(facSumasDetalle, factura.facSumasDetalle) && Objects.equals(facTotalPagar, factura.facTotalPagar) && Arrays.equals(facFirma, factura.facFirma) && Objects.equals(facNcr, factura.facNcr) && Objects.equals(facEstadoFactura, factura.facEstadoFactura) && Objects.equals(facCodigoGeneracion, factura.facCodigoGeneracion) && Objects.equals(facNumeroDeControl, factura.facNumeroDeControl) && Objects.equals(facTipoDocumento, factura.facTipoDocumento) && Arrays.equals(facSelloDeRecepcion, factura.facSelloDeRecepcion) && Objects.equals(facTotalIva, factura.facTotalIva) && Objects.equals(facTipoComprobante, factura.facTipoComprobante) && Objects.equals(facVentasnosujetTot, factura.facVentasnosujetTot) && Objects.equals(facVentasexentasTot, factura.facVentasexentasTot) && Objects.equals(facVentasgravadasTot, factura.facVentasgravadasTot) && Objects.equals(facIvaRetenido, factura.facIvaRetenido) && Objects.equals(facSaldoFavor, factura.facSaldoFavor) && Objects.equals(facTotalNograbado, factura.facTotalNograbado) && Objects.equals(facDescuentoNosuje, factura.facDescuentoNosuje) && Objects.equals(facDescuentoExent, factura.facDescuentoExent) && Objects.equals(facRetencionRenta, factura.facRetencionRenta) && Objects.equals(facTotDescuento, factura.facTotDescuento) && Objects.equals(facTotalLetras, factura.facTotalLetras) && Objects.equals(facDescuentoGrab, factura.facDescuentoGrab) && Objects.equals(facPorcenDescuento, factura.facPorcenDescuento) && Objects.equals(facTributos, factura.facTributos) && Objects.equals(facSubtotal, factura.facSubtotal) && Objects.equals(facIvaPorcent, factura.facIvaPorcent) && Objects.equals(facSubtotalventas, factura.facSubtotalventas) && Objects.equals(facIvaperci1, factura.facIvaperci1) && Objects.equals(facMontototaloperacion, factura.facMontototaloperacion) && Objects.equals(facNumpagoelectronico, factura.facNumpagoelectronico) && Objects.equals(facCondicionOperacion, factura.facCondicionOperacion) && Objects.equals(facFechaIniPeriodo, factura.facFechaIniPeriodo) && Objects.equals(facFechaFinPeriodo, factura.facFechaFinPeriodo);
    }

    @Override
    public int hashCode() {
        int result = Objects.hash(facId, facNroFactura, facFechaEmision, facActividadGiro, facNitEmisor, facNitReceptor, facTelefono, facRazonsocial, facRetenido, facSumasDetalle, facTotalPagar, facNcr, facEstadoFactura, facCodigoGeneracion, facNumeroDeControl, facTipoDocumento, facTotalIva, facTipoComprobante, facVentasnosujetTot, facVentasexentasTot, facVentasgravadasTot, facIvaRetenido, facSaldoFavor, facTotalNograbado, facDescuentoNosuje, facDescuentoExent, facRetencionRenta, facTotDescuento, facTotalLetras, facDescuentoGrab, facPorcenDescuento, facTributos, facSubtotal, facIvaPorcent, facSubtotalventas, facIvaperci1, facMontototaloperacion, facNumpagoelectronico, facCondicionOperacion, facFechaIniPeriodo, facFechaFinPeriodo);
        result = 31 * result + Arrays.hashCode(facFirma);
        result = 31 * result + Arrays.hashCode(facSelloDeRecepcion);
        return result;
    }
}
