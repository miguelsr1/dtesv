package sv.com.jsoft.stdte.model.csv;

import io.github.millij.poi.ss.model.annotations.Sheet;
import io.github.millij.poi.ss.model.annotations.SheetColumn;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import javax.persistence.*;
import java.math.BigDecimal;

@Sheet @Getter @Setter @ToString
public class PlantillaSV {

    @SheetColumn("Cod Emisor")
    private String codEmisor;
    @SheetColumn("TipoDoc")
    private String tipoDoc;
    @SheetColumn("TipoDocRec")
    private String tipoDocRec;
    @SheetColumn("NIT")
    private String nit;
    @SheetColumn("NRC")
    private String nrc;
    @SheetColumn("NombreCliente")
    private String nombreCliente;
    @SheetColumn("Correo")
    private String correo;
    @SheetColumn("Telefono")
    private String telefono;
    @SheetColumn("Moneda")
    private String moneda;
    @SheetColumn("TipoCambio")
    private String tipoCambio;
    @SheetColumn("Depart")
    private String depart;
    @SheetColumn("Municipio")
    private String municipio;
    @SheetColumn("Complemento")
    private String complemento;
    @SheetColumn("CodActCom")
    private String codActCom;
    @SheetColumn("Codigo")
    private String codigo;
    @SheetColumn("Detalle")
    private String detalle;
    @SheetColumn("Unidad Medida")
    private String unidadMedida;
    @SheetColumn("Tipo")
    private String tipo;
    @SheetColumn("Cantidad")
    private String cantidad;
    @SheetColumn("Precio_Unitario")
    private BigDecimal precioUnitario;
    @SheetColumn("Descuento")
    private String descuento;
    @SheetColumn("Exento")
    private String exento;
    @SheetColumn("Codigo_")
    private String codigoImp;
    @SheetColumn("Porcentaje")
    private String porcentaje;
    @SheetColumn("Valor")
    private String valor;
    @SheetColumn("CondicionPago")
    private String condicionPago;
    @SheetColumn("MedioPago")
    private String medioPago;
    @SheetColumn("Monto")
    private String monto;
    @SheetColumn("Referencia")
    private String referencia;
    @SheetColumn("Plazo")
    private String plazo;
    @SheetColumn("Periodo")
    private String periodo;
    @SheetColumn("TipoGeneracion")
    private String tipoGeneracion;
    @SheetColumn("TipoDte")
    private String tipoDte;
    @SheetColumn("NumeroAutorizacion")
    private String numeroAutorizacion;
    @SheetColumn("FechaHoraEmision")
    private String fechaHoraEmision;
    @SheetColumn("TipoDocIdReceptor")
    private String tipoDocIdReceptor;
    @SheetColumn("Documento")
    private String documento;

}
