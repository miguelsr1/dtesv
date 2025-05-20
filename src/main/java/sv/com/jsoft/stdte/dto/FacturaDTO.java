package sv.com.jsoft.stdte.dto;

import com.opencsv.bean.CsvBindByPosition;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class FacturaDTO {

    @CsvBindByPosition(position = 0)
    private String tipoFactura;
    @CsvBindByPosition(position = 1)
    private String nroDeFactura;
    @CsvBindByPosition(position = 2)
    private String formularioUnico;
    @CsvBindByPosition(position = 3)
    private String fecha;
    @CsvBindByPosition(position = 4)
    private String codClienteFacturadoA;
    @CsvBindByPosition(position = 5)
    private String nombreCliente;
    @CsvBindByPosition(position = 6)
    private String apellidoCliente;
    @CsvBindByPosition(position = 7)
    private String nitCliente;
    @CsvBindByPosition(position = 8)
    private String codSucursalDelCliente;
    @CsvBindByPosition(position = 9)
    private String codClienteCxca;
    @CsvBindByPosition(position = 10)
    private String codClienteEnviadoA;
    @CsvBindByPosition(position = 11)
    private String plazoDeCredito;
    @CsvBindByPosition(position = 12)
    private String codigoVendedor;
    @CsvBindByPosition(position = 13)
    private String codigoSucursal;
    @CsvBindByPosition(position = 14)
    private String codigoCajaRegistradora;
    @CsvBindByPosition(position = 15)
    private String codigoTipoDeVenta;
    @CsvBindByPosition(position = 16)
    private String perIva;
    @CsvBindByPosition(position = 17)
    private String perDePercepcion;
    @CsvBindByPosition(position = 18)
    private String perDeRetencion;
    @CsvBindByPosition(position = 19)
    private String concepto;
    @CsvBindByPosition(position = 20)
    private String codigoEmpResponsable;
    @CsvBindByPosition(position = 21)
    private String dejarMovInvPendiente;
    @CsvBindByPosition(position = 22)
    private String codigoCentroDeCosto;
    @CsvBindByPosition(position = 23)
    private String codigoSubCentroDeCosto;
    @CsvBindByPosition(position = 24)
    private String codigoDeProducto;
    @CsvBindByPosition(position = 25)
    private String descripcion;
    @CsvBindByPosition(position = 26)
    private String cantidad;
    @CsvBindByPosition(position = 27)
    private String precioUnitario;
    @CsvBindByPosition(position = 28)
    private String perDeDescuento;
    @CsvBindByPosition(position = 29)
    private String esExento;
    @CsvBindByPosition(position = 30)
    private String esNoSujeto;
    @CsvBindByPosition(position = 31)
    private String codigoCentroDeCostoItem;
    @CsvBindByPosition(position = 32)
    private String codigoSubCentroDeCostoItem;
    @CsvBindByPosition(position = 33)
    private String codigoDeUbicacion;
    @CsvBindByPosition(position = 34)
    private String numeroLote;
    @CsvBindByPosition(position = 35)
    private String codAlfaNum01;
    @CsvBindByPosition(position = 36)
    private String codAlfaNum02;
    @CsvBindByPosition(position = 37)
    private String codAlfaNum03;
    @CsvBindByPosition(position = 38)
    private String codAlfaNum04;
    @CsvBindByPosition(position = 39)
    private String referencia;

}
