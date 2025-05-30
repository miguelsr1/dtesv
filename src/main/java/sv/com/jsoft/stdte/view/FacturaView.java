package sv.com.jsoft.stdte.view;

import lombok.Getter;
import lombok.Setter;
import org.primefaces.PrimeFaces;
import org.primefaces.component.tabview.TabView;
import org.primefaces.event.TabChangeEvent;
import sv.com.jsoft.stdte.dto.DetalleFacturaDTO;
import sv.com.jsoft.stdte.dto.GenericResponse;
import sv.com.jsoft.stdte.dto.TotalesDTO;
import sv.com.jsoft.stdte.persistence.*;
import sv.com.jsoft.stdte.repository.AppService;
import sv.com.jsoft.stdte.repository.CatalogosService;
import sv.com.jsoft.stdte.repository.FacturaService;
import sv.com.jsoft.stdte.utils.ViewUtils;
import javax.annotation.PostConstruct;
import javax.faces.view.ViewScoped;
import javax.inject.Inject;
import javax.inject.Named;
import java.io.Serializable;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;
import javax.faces.application.FacesMessage;
import lombok.extern.slf4j.Slf4j;
import org.primefaces.event.SelectEvent;
import sv.com.jsoft.stdte.repository.EmisorService;
import sv.com.jsoft.stdte.repository.ReceptorService;
import sv.com.jsoft.stdte.utils.MessageUtil;

@Named("procFact")
@ViewScoped
@Slf4j
public class FacturaView implements Serializable {

    @Inject
    CatalogosService catalogoService;
    @Inject
    LoginBean login;
    @Inject
    AppService service;
    @Inject
    FacturaService facturaService;
    @Inject
    EmisorService emisorService;
    @Inject
    ReceptorService receptorService;

    private Empresa emisor;
    @Getter
    @Setter
    private Boolean sinDatos;

    @Getter
    @Setter
    private boolean skip, continuar = Boolean.FALSE, exento = Boolean.FALSE,
            docRelacionados = Boolean.FALSE, reenviar = Boolean.FALSE, aplicarRetIva = Boolean.FALSE, aplicarImpRen = Boolean.FALSE;

    @Getter
    @Setter
    private String receptorStr;

    @Getter
    @Setter
    private String idFactura, token, tipoDoc, codProducto, plazo, medioPago, nroDocumento, mensaje, obsDetalle,
            receptorDeptoDesc, receptorMuniDesc, motivoDescuento, referencia, moneda = "USD", observaciones, fesvMhVersion = "", observaciones07;

    @Getter
    @Setter
    private Buzoncsv factura;

    @Getter
    @Setter
    private Contribuyentes receptor;

    @Getter
    @Setter
    private CatalogoProductos producto;

    @Getter
    @Setter
    private CatalogoProductos tributo;

    @Getter
    @Setter
    private TiposComprobantes selectedTipoComprobante;

    @Getter
    @Setter
    private List<Buzoncsv> facturaList;

    @Getter
    @Setter
    private List<TiposComprobantes> tiposComprobantesLs, tipoCompRel;

    @Getter
    @Setter
    private List<CatalogoProductos> productosList;

    @Getter
    @Setter
    private List<CatalogoProductos> productosAgregados;

    @Getter
    @Setter
    private Date fechaInicio, fechaFin;

    @Getter
    @Setter
    private Integer cantidad = 0, condicionOp, tipoCambio = 1, periodo, unidadMedida, selectedTab = 0, tipoProducto = 0;

    @Getter
    @Setter
    private BigDecimal total, descuento, otrosCargos, totalDetalle, maxValueDesc, retencionIva;

    @Getter
    @Setter
    private List<CatalogoTributos> tributosList;

    @Getter
    @Setter
    private List<DetalleFacturaDTO> detalleList;

    @Getter
    @Setter
    private List<Contribuyentes> receptores;

    @Getter
    @Setter
    private List<CatalogoCondicionOperacion> condicionOperacionList;

    @Getter
    @Setter
    private List<CatalogoPlazos> plazosList;

    @Getter
    @Setter
    private List<CatalogoFormaPago> formaPagoList;

    @Getter
    @Setter
    private List<UnidadesMedida> unidadesMedidaList;

    @Getter
    @Setter
    private List<TotalesDTO> totalesDTOList;

    @Getter
    @Setter
    private List<CatalogoTipoItem> tipoItemsList;

    @Getter
    @Setter
    private List<CatalogoRecintoFiscal> recintoFiscals;

    @Getter
    @Setter
    private List<CatalogoRegimen> regimenList;

    @Getter
    @Setter
    private List<CatalogoTipoGeneracionDocumento> tipoGenDocls;

    @Getter
    @Setter
    private List<CatalogoRetencionIvaMh> catRetencionIvaMhList;

    @Getter
    @Setter
    private ParametrosMh pmh;

    @Getter
    @Setter
    private String nitEmisor, nitReceptor;

    @Getter
    @Setter
    private BigDecimal precioUnitario;

    @Getter
    @Setter
    private TabView tabView = null;

    @PostConstruct
    public void init() {
        factura = new Buzoncsv();

        receptor = new Contribuyentes();
        producto = new CatalogoProductos();

        facturaList = new ArrayList<>();
        productosAgregados = new ArrayList<>();
        tributosList = new ArrayList<>();
        detalleList = new ArrayList<>();

        tiposComprobantesLs = service.findAllTiposComprobantes();
        productosList = service.findCatalogoProductosByIdEmp(login.getLogin().getIdEmpresa());
        productosList = productosList
                .stream()
                .filter(p -> p.getCpActivo().matches("S"))
                .collect(Collectors.toList());
        receptores = service.findAllReceptoresByIdEmp(login.getLogin().getIdEmpresa(), false);
        condicionOperacionList = service.findAllCondicionesOp();
        plazosList = service.findAllCatalogoPlazos();
        formaPagoList = service.findAllCatalogoFormaPago();
        unidadesMedidaList = service.findAllUnidadesMedida();
        tipoItemsList = catalogoService.getCatalogoTipoItem();
        recintoFiscals = catalogoService.getCatalogoRecintoFiscal();
        regimenList = catalogoService.getCatalogoRegimen();
        tipoGenDocls = catalogoService.getCatalogoTipoGenDoc();
        catRetencionIvaMhList = catalogoService.getCatalogoRetIvaMh();
        precioUnitario = BigDecimal.valueOf(0.00);

        initTipoDocFe();
    }

    private void initTipoDocFe() {
        //por defecto se agrega el tipo de DTE Factura Electronica
        factura.setTipodoc("01");
        tipoDocListener();

        fechaInicio = new Date();
        fechaFin = new Date();
        emisor = emisorService.findByPk(login.getLogin().getIdEmpresa());

        sinDatos = true;
    }

    public void tipoDocListener() {
        log.info("Usuario ingreso: " + login.getLogin().getUsuario());
        detalleList = new ArrayList<>();
        totalesDTOList = new ArrayList<>();
        log.info("TIPO DOCUMENTO SELECCIONADO: " + factura.getTipodoc());
        selectedTipoComprobante = tiposComprobantesLs
                .stream()
                .filter(tc -> tc.getTcpIdtipcom().matches(factura.getTipodoc()))
                .findAny()
                .orElse(null);
        if (selectedTipoComprobante != null) {
            log.info("VERSION: " + selectedTipoComprobante.getTcpVersion());
        }

        if (factura.getTipodoc().equals("01")) {
            sinDatos = true;
            receptor = facturaService.findReceptoNull();
            receptores = service.findAllReceptoresByIdEmp(login.getLogin().getIdEmpresa(), false);
        } else {
            receptor = new Contribuyentes();
            receptores = service.findAllReceptoresByIdEmp(login.getLogin().getIdEmpresa(), true);
            
            if (factura.getTipodoc().matches("05|06")) {
                tipoCompRel = tiposComprobantesLs.stream().filter(tc -> tc.getTcpIdtipcom().matches("03|07"))
                        .collect(Collectors.toList());
            } else if (factura.getTipodoc().matches("07")) {
                tipoCompRel = tiposComprobantesLs.stream()
                        .filter(tc -> tc.getTcpIdtipcom().matches("01|03|14"))
                        .collect(Collectors.toList());
                factura.setMonto_sujeto_gravado(new BigDecimal("0.00"));
            }
        }
    }

    public void onClickButton() {
        continuar = Boolean.FALSE;
        fechaFin = fechaInicio;
        if (fechaInicio != null && fechaFin != null) {
            if (fechaFin.after(fechaInicio) || fechaInicio.equals(fechaFin)) {
                GenericResponse response;

                if (factura.getTipodoc().matches("05|06")) {
                    //Validar si existe documento relacionado para tipo nota de crédito o débito
                    response = service.callProValidaDocRelacionado(factura);
                    if (response.getVal() == 0) {
                        continuar = Boolean.TRUE;
                        tabView.setActiveIndex(1);
                        PrimeFaces.current().ajax().update("mainFrm");
                    } else {
                        ViewUtils.showMessageError("NO EXISTE NÚMERO DE DOCUMENTO RELACIONADO, VERIFIQUE E INTENTE NUEVAMENTE");
                    }
                } else {
                    continuar = Boolean.TRUE;
                    tabView.setActiveIndex(1);

                    //codEmisorListener();
                    PrimeFaces.current().ajax().update("mainFrm");
                }
            } else {
                ViewUtils.showMessageError("FECHA DE INICIO NO PUEDE SER MAYOR A FECHA FIN");
            }
        } else {
            ViewUtils.showMessageInfo("DEBE SELECCIONAR FECHA DE INICIO Y FIN PARA CONTINUAR");
        }
    }

    public void agregarDocRetencion() {
        Buzoncsv docRet = new Buzoncsv();
        docRet.setDocRelacionado(factura.getDocRelacionado());
        docRet.setTipoGeneracionDocRel(factura.getTipoGeneracionDocRel());
        docRet.setTipoDocRelacionado(factura.getTipoDocRelacionado());
        docRet.setFechaDocRelacionado(factura.getFechaDocRelacionado());
        docRet.setDescripcion_doc_relacionado(factura.getDescripcion_doc_relacionado());
        docRet.setMonto_sujeto_gravado(factura.getMonto_sujeto_gravado());
        docRet.setCodigo_retencion(factura.getCodigo_retencion());
        docRet.setMonto_retencion_iva(factura.getMonto_retencion_iva());

        docRet.setMonto(String.valueOf(factura.getMonto_sujeto_gravado()));
        docRet.setDescripcionRetencion(factura.getDescripcion_doc_relacionado());
        docRet.setIdRetencion(String.valueOf(factura.getCodigo_retencion()));

        facturaList.add(docRet);

        factura.setDocRelacionado(null);
        factura.setTipoGeneracionDocRel(null);
        factura.setTipoDocRelacionado(null);
        factura.setFechaDocRelacionado(null);
        factura.setDescripcion_doc_relacionado(null);
        factura.setMonto_sujeto_gravado(null);
        factura.setCodigo_retencion(null);
        factura.setMonto_retencion_iva(null);
    }

    public void removeDocRetencion(Buzoncsv item) {
        if (facturaList.size() > 1) {
            facturaList.remove(item);
        } else {
            facturaList = new ArrayList<>();
        }
    }

    public void emitirDocRetencion() {

    }

    public void onTabChange(TabChangeEvent event) {
        if (event.getTab().getId().matches("conditions")) {
            calcularTotales();
        }
    }

    /*public synchronized void codEmisorListener() {
        observaciones = "Fecha del periodo del " + ViewUtils.formatoFecha(fechaInicio) + " al " + ViewUtils.formatoFecha(fechaFin);
        log.info("Periodo del " + ViewUtils.formatoFecha(fechaInicio) + " al " + ViewUtils.formatoFecha(fechaFin));
        if (nitEmisor != null && !nitEmisor.isEmpty()) {
            emisor = emisores.stream()
                    .filter(c -> c.getRucNitContribuyente().matches(nitEmisor))
                    .findAny().orElse(null);
            if (emisor != null) {
                if (emisor.getRucCodigoDepartamento() != null) {
                    emisorDeptoDesc = service.findDepartamentoDescByCod(emisor.getRucCodigoDepartamento());
                }
                if (emisor.getRucCodigoDepartamento() != null && emisor.getRucCodigoMunicipio() != null) {
                    emisorMuniDesc = service.findMunicipioDescByCod(emisor.getRucCodigoDepartamento(), emisor.getRucCodigoMunicipio());
                }
            } else {
                ViewUtils.showMessageWarning("NO SE ENCONTRO EMISOR  " + nitEmisor
                        + ", VERIFIQUE E INTENTE NUEVAMENTE");
            }
        } else {
            ViewUtils.addError("DEBE INGRESAR NIT EMISOR PARA CONTINUAR", null);
        }
    }*/
    public void codReceptorListener() {
        if (nitReceptor != null && !nitReceptor.isEmpty()) {
            receptor = receptores.stream()
                    .filter(r -> r.getRucNitContribuyente().matches(nitReceptor))
                    .findAny().orElse(null);
            if (receptor != null) {
                if (receptor.getRucCodigoDepartamento() != null) {
                    receptorDeptoDesc = service.findDepartamentoDescByCod(receptor.getRucCodigoDepartamento());
                }
                if (receptor.getRucCodigoDepartamento() != null && receptor.getRucCodigoMunicipio() != null) {
                    receptorMuniDesc = service.findMunicipioDescByCod(receptor.getRucCodigoDepartamento(), receptor.getRucCodigoMunicipio());
                }
            } else {
                ViewUtils.showMessageWarning("NO SE ENCOTRO RECEPTOR CON NIT " + nitReceptor + ", VERIFIQUE E INTENTE NUEVAMENTE");
            }
        } else {
            ViewUtils.addError("DEBE INGRESAR NIT RECEPTOR PARA CONTINUAR", null);
        }
    }

    public void selProductoListener() {
        producto = service.findProductoById(codProducto);
        producto.setExento(producto.getCpExento().matches("S"));
        precioUnitario = producto.getValorUnitario();
        if (!producto.getExento()) {
            tributosList = service.findTributosByCod("20");
        }
        if (producto.getUnidadMedida() != null) {
            unidadMedida = producto.getUnidadMedida().getUmCodigo();
        }
        if (producto.getCpCitId() != null) {
            tipoProducto = producto.getCpCitId();
        }
    }

    public void cantidadListener() {
        if (cantidad > 0) {
            try {
                if (factura.getTipodoc().matches("03")
                        || factura.getTipodoc().matches("05")
                        || factura.getTipodoc().matches("06")) {
                    total = producto.getValorUnitario().multiply(BigDecimal.valueOf(cantidad));
                    tributosList.forEach(c -> c.setMontoImpuesto(
                            producto.getValorUnitario().multiply(BigDecimal.valueOf(cantidad)).multiply(BigDecimal.valueOf(0.13))));
                }
                if (factura.getTipodoc().matches("01") || factura.getTipodoc().matches("11")) {
                    total = producto.getValorUnitario().multiply(BigDecimal.valueOf(cantidad));
                    tributosList.forEach(c -> c.setMontoImpuesto(
                            ((producto.getValorUnitario().multiply(BigDecimal.valueOf(cantidad)))
                                    .divide(BigDecimal.valueOf(1.13), 5, RoundingMode.HALF_UP))
                                    .multiply(BigDecimal.valueOf(0.13))
                    ));
                }
                maxValueDesc = producto.getValorUnitario();
            } catch (ArithmeticException e) {
                log.error("Error en cantidadListener: ", e);
                ViewUtils.showMessageError("OCURRIO UN ERROR CALCULANDO IMPUESTO: " + e.getCause());
            } finally {
                log.info("tipoDocRelacionado: " + producto.getCpCitId());
            }
        }
    }

    public void addDetail() {
        if (cantidad > 0) {
            DetalleFacturaDTO detail = new DetalleFacturaDTO();
            detail.setCodigoProd(codProducto);
            detail.setDescripcion(producto.getDescripcion());
            detail.setCantidad(cantidad);
            detail.setPrecio(precioUnitario);
            detail.setObsDetalle(obsDetalle);
            detail.setDescuentos(BigDecimal.valueOf(0.00));

            //RETENCION IVA 13% FSEE
            if (factura.getTipodoc().matches("14")) {
                if (aplicarRetIva) {
                    BigDecimal totalOperacion = BigDecimal.valueOf(cantidad).multiply(detail.getPrecio());
                    detail.setRetencionIva(totalOperacion.multiply(BigDecimal.valueOf(0.13)));
                } else {
                    detail.setRetencionIva(BigDecimal.valueOf(0.00));
                }
            }
            //DESCUENTO POR IMPUESTO SOBRE LA RENTA 10% FSEE
            if (factura.getTipodoc().matches("14")) {
                if (aplicarImpRen) {
                    detail.setRetRenta(BigDecimal.valueOf(cantidad).multiply(detail.getPrecio()).multiply(BigDecimal.valueOf(0.10)));
                } else {
                    detail.setRetRenta(BigDecimal.valueOf(0.00));
                }
            } else {
                detail.setDescuentos(descuento != null ? descuento.multiply(BigDecimal.valueOf(cantidad))
                        : BigDecimal.valueOf(0.00));
            }

            if (!factura.getTipodoc().matches("14") && !exento) {
                BigDecimal totalImpuestos = tributosList.stream()
                        .filter(Objects::nonNull)
                        .map(CatalogoTributos::getMontoImpuesto)
                        .filter(Objects::nonNull)
                        .reduce(BigDecimal::add)
                        .orElse(BigDecimal.ZERO);

                detail.setImpuestos(totalImpuestos);

            } else {
                detail.setImpuestos(BigDecimal.valueOf(0.00));
            }

            detail.setIvaPercibido(BigDecimal.valueOf(0.00));
            detail.setIvaRetenido(detail.getRetencionIva() != null ? detail.getRetencionIva() : BigDecimal.valueOf(0.00));
            detail.setOtrosCargos(otrosCargos != null ? otrosCargos
                    : BigDecimal.valueOf(0.00));
            detail.setTotal(!factura.getTipodoc().matches("01")
                    ? BigDecimal.valueOf(detail.getCantidad()).multiply(detail.getPrecio())
                            .add(detail.getImpuestos())
                            .add(detail.getRetencionIva() != null ? detail.getRetencionIva() : BigDecimal.ZERO)
                            .subtract(detail.getDescuentos() != null ? detail.getDescuentos() : BigDecimal.ZERO)
                            .subtract(detail.getRetRenta() != null ? detail.getRetRenta() : BigDecimal.ZERO)
                            .subtract(detail.getRetencionIva() != null ? detail.getRetencionIva() : BigDecimal.ZERO)
                    : BigDecimal.valueOf(detail.getCantidad()).multiply(detail.getPrecio()).subtract(detail.getDescuentos()));
            detail.setReferencia(referencia);
            detail.setUnidadMedida(unidadMedida != null ? unidadMedida : producto.getUnidadMedida().getUmCodigo());
            detail.setTipoProducto(producto.getCpCitId() != null ? producto.getCpCitId() : tipoProducto);
            detail.setExento(exento ? "Si" : "No");
            detalleList.add(detail);
            totalDetalle = detalleList
                    .stream()
                    .map(DetalleFacturaDTO::getTotal)
                    .reduce(BigDecimal::add)
                    .get();
            calcularTotales();
            limpiarDlgItem();
            PrimeFaces.current().executeScript("PF('dlgDetalleItem').hide()");
        } else {
            ViewUtils.showMessageError("NO HA INGRESADO UNA CANTIDAD AL DETALLE");
        }
    }

    public void limpiarDlgItem() {
        //REINICIAR VALORES PARA INGRESAR OTRO DETALLE
        log.info("LIMPIANDO DETALLE ITEM");
        codProducto = null;
        producto = new CatalogoProductos();
        cantidad = 0;
        exento = Boolean.FALSE;
        descuento = BigDecimal.valueOf(0.00);
        motivoDescuento = null;
        otrosCargos = BigDecimal.valueOf(0.00);
        referencia = null;
        retencionIva = BigDecimal.valueOf(0.00);
        aplicarRetIva = Boolean.FALSE;
        aplicarImpRen = Boolean.FALSE;
        obsDetalle = null;
        precioUnitario = BigDecimal.valueOf(0.00);
        tributosList.forEach(c -> c.setMontoImpuesto(BigDecimal.valueOf(0.00)));
        PrimeFaces.current().ajax().update("mainFrm:tabview:grdDetail");
    }

    public void deleteDetail(DetalleFacturaDTO item) {
        if (!detalleList.isEmpty()) {
            detalleList.remove(item);
            totalDetalle = detalleList.isEmpty() ? BigDecimal.valueOf(0.00)
                    : detalleList
                            .stream()
                            .map(DetalleFacturaDTO::getTotal)
                            .reduce(BigDecimal::add)
                            .get();
            calcularTotales();
        }
    }

    private void calcularTotales() {
        if (!detalleList.isEmpty()) {
            totalesDTOList = new ArrayList<>();
            TotalesDTO totalesDto = new TotalesDTO();
            if (factura.getTipodoc().matches("14")) {
                totalesDto.setDescription("TOTAL COMPRA $US");
                totalesDto = getTotalesDTO(totalesDto);
                totalesDto.setDescription("IMPUESTO SOBRE LA RENTA $US");
                totalesDto.setValue(detalleList
                        .stream()
                        .filter(Objects::nonNull)
                        .map((DetalleFacturaDTO::getRetRenta))
                        .reduce(BigDecimal.ZERO, BigDecimal::add));
                totalesDTOList.add(totalesDto);
                totalesDto = new TotalesDTO();
                totalesDto.setDescription("TOTAL IMPUESTO SOBRE LA RENTA $US");
                totalesDto.setValue(detalleList
                        .stream()
                        .filter(Objects::nonNull)
                        .map((DetalleFacturaDTO::getRetRenta))
                        .reduce(BigDecimal.ZERO, BigDecimal::add));
                totalesDTOList.add(totalesDto);
                totalesDto = new TotalesDTO();
                totalesDto.setDescription("TOTAL RETENCIÓN IVA 13%");
                totalesDto.setValue(detalleList.stream()
                        .filter(Objects::nonNull)
                        .map(DetalleFacturaDTO::getRetencionIva)
                        .filter(Objects::nonNull)
                        .reduce(BigDecimal.ZERO, BigDecimal::add));
                totalesDTOList.add(totalesDto);
                totalesDto = new TotalesDTO();
                totalesDto.setDescription("TOTAL $US");
                totalesDto.setValue(calcularTotal());
                totalesDTOList.add(totalesDto);
            } else {
                totalesDto.setDescription("TOTAL NO SUJETO $US");
                totalesDto.setValue(BigDecimal.valueOf(0.00));
                totalesDTOList.add(totalesDto);
                totalesDto = new TotalesDTO();
                totalesDto.setDescription("TOTAL EXENTO $US");
                totalesDto.setValue(BigDecimal.valueOf(0.00));
                totalesDTOList.add(totalesDto);
                totalesDto = new TotalesDTO();
                totalesDto.setDescription("TOTAL GRAVADO $US");
                totalesDto = getTotalesDTO(totalesDto);
                totalesDto.setDescription("TOTAL DESCUENTOS NO SUJETOS $US");
                totalesDto.setValue(BigDecimal.valueOf(0.00));
                totalesDTOList.add(totalesDto);
                totalesDto = new TotalesDTO();
                totalesDto.setDescription("TOTAL DESCUENTOS EXENTOS $US");
                totalesDto.setValue(BigDecimal.valueOf(0.00));
                totalesDTOList.add(totalesDto);
                totalesDto = new TotalesDTO();
                totalesDto.setDescription("TOTAL DESCUENTOS GRAVADOS $US");
                totalesDto.setValue(BigDecimal.valueOf(0.00));
                totalesDTOList.add(totalesDto);
                totalesDto = new TotalesDTO();
                totalesDto.setDescription("TOTAL DESCUENTOS $US");
                totalesDto.setValue(detalleList
                        .stream()
                        .map((DetalleFacturaDTO::getDescuentos))
                        .reduce(BigDecimal.ZERO, BigDecimal::add));
                totalesDTOList.add(totalesDto);
                totalesDto = new TotalesDTO();
                totalesDto.setDescription("TOTAL IMPUESTOS $US");
                totalesDto.setValue(calcResumenImpuestos());
                totalesDTOList.add(totalesDto);
                totalesDto = new TotalesDTO();
                totalesDto.setDescription("TOTAL IMPUESTOS PERCIBIDOS 1% $US");
                totalesDto.setValue(BigDecimal.valueOf(0.00));
                totalesDTOList.add(totalesDto);
                totalesDto = new TotalesDTO();
                totalesDto.setDescription("TOTAL IMPUESTOS RETENIDOS 1% $US");
                totalesDto.setValue(BigDecimal.valueOf(0.00));
                totalesDTOList.add(totalesDto);
                totalesDto = new TotalesDTO();
                totalesDto.setDescription("TOTAL $US");
                if (!factura.getTipodoc().matches("01")) {
                    totalesDto.setValue(calcularTotal());
                } else {
                    totalesDto.setValue(detalleList
                            .stream()
                            .filter(Objects::nonNull)
                            .map(det -> BigDecimal.valueOf(det.getCantidad()).multiply(det.getPrecio())
                            .subtract(det.getDescuentos()))
                            .reduce(new BigDecimal("0.00"), BigDecimal::add));
                }
                totalesDTOList.add(totalesDto);
            }
        } else {
            totalesDTOList = new ArrayList<>();
        }
    }

    private BigDecimal calcularTotal() {
        BigDecimal tot = detalleList
                .stream()
                .filter(Objects::nonNull)
                .map(det -> {
                    BigDecimal cant = det.getCantidad() != null ? BigDecimal.valueOf(det.getCantidad()) : BigDecimal.ZERO;
                    BigDecimal precio = det.getPrecio() != null ? det.getPrecio() : BigDecimal.ZERO;
                    BigDecimal descuentos = det.getDescuentos() != null ? det.getDescuentos() : BigDecimal.ZERO;
                    BigDecimal retenIva = det.getRetencionIva() != null ? det.getRetencionIva() : BigDecimal.ZERO;
                    BigDecimal retRenta = det.getRetRenta() != null ? det.getRetRenta() : BigDecimal.ZERO;
                    return cant.multiply(precio).subtract(descuentos).add(retenIva).subtract(retRenta).subtract(retenIva);
                })
                .reduce(BigDecimal.ZERO, BigDecimal::add)
                .add(calcResumenImpuestos());
        return tot;
    }

    private TotalesDTO getTotalesDTO(TotalesDTO totalesDto) {
        totalesDto.setValue(detalleList
                .stream()
                .map(det -> BigDecimal.valueOf(det.getCantidad()).multiply(det.getPrecio()))
                .reduce(new BigDecimal("0.00"), BigDecimal::add));
        totalesDTOList.add(totalesDto);
        totalesDto = new TotalesDTO();
        totalesDto.setDescription("SUBTOTAL $US");
        totalesDto.setValue(detalleList
                .stream()
                .map(det -> BigDecimal.valueOf(det.getCantidad()).multiply(det.getPrecio()))
                .reduce(new BigDecimal("0.00"), BigDecimal::add));
        totalesDTOList.add(totalesDto);
        totalesDto = new TotalesDTO();
        return totalesDto;
    }

    private BigDecimal calcResumenImpuestos() {
        if (factura.getTipodoc().matches("03")
                || //CCFE
                factura.getTipodoc().matches("05")) {  //NCE
            return detalleList
                    .stream()
                    .map(det -> BigDecimal.valueOf(det.getCantidad())
                    .multiply(det.getPrecio())
                    .multiply(BigDecimal.valueOf(0.13)))
                    .reduce(new BigDecimal("0.00"), BigDecimal::add);
        }
        if (factura.getTipodoc().matches("01") //FE
                || factura.getTipodoc().matches("11")) { //FEX
            return detalleList
                    .stream()
                    .map(det -> (BigDecimal.valueOf(det.getCantidad())
                    .multiply(det.getPrecio())
                    .divide(BigDecimal.valueOf(1.13), 5, RoundingMode.HALF_UP))
                    .multiply(BigDecimal.valueOf(0.13)))
                    .reduce(new BigDecimal("0.00"), BigDecimal::add);

        }
        return new BigDecimal("0.00");
    }

    public void emitirDocumento() {
        List<Buzoncsv> buzoncsvList;
        if (factura.getTipodoc().matches("03")
                || factura.getTipodoc().matches("01")
                || factura.getTipodoc().matches("11")
                || factura.getTipodoc().matches("05")
                || factura.getTipodoc().matches("06")
                || factura.getTipodoc().matches("14")) {
            buzoncsvList = new ArrayList<>();
            detalleList.forEach(detail -> {
                Buzoncsv buzoncsv;
                buzoncsv = setBuzonValues();
                buzoncsv.setMoneda(moneda);
                buzoncsv.setTipocambio(tipoCambio != null ? tipoCambio : 1);
                buzoncsv.setCodigo(detail.getCodigoProd());
                buzoncsv.setDetalle(detail.getDescripcion());
                buzoncsv.setUnidadMedida(detail.getUnidadMedida());
                buzoncsv.setTipo(detail.getTipoProducto() != null ? detail.getTipoProducto() : tipoProducto);
                buzoncsv.setCantidad(BigDecimal.valueOf(detail.getCantidad()));
                buzoncsv.setPrecioUnitario(detail.getPrecio());
                buzoncsv.setExento(detail.getExento());
                buzoncsv.setCodigoImp(20);
                buzoncsv.setPorcentaje(13);
                buzoncsv.setValor(String.valueOf(detail.getTotal()));
                buzoncsv.setCondicionpago(condicionOp);
                buzoncsv.setMediopago(medioPago);
                buzoncsv.setMonto(String.valueOf(detail.getTotal()));
                buzoncsv.setReferencia(detail.getReferencia());
                buzoncsv.setPlazo(plazo);
                buzoncsv.setPeriodo(periodo != null ? String.valueOf(periodo) : String.valueOf(0));

                buzoncsv.setRetencionIva(detail.getRetencionIva() != null ? detail.getRetencionIva() : new BigDecimal("0.00"));
                buzoncsv.setRetencionIvaPorc(detail.getRetencionIva() != null ? new BigDecimal("13") : new BigDecimal("0.00"));

                buzoncsv.setImpuestoRetenRetenido(detail.getRetRenta() != null ? detail.getRetRenta() : new BigDecimal("0"));
                buzoncsv.setImpuestoRetenRetenidoPorc(detail.getRetRenta() != null ? new BigDecimal("10") : new BigDecimal("0"));

                buzoncsv.setObservacionesDetalles(detail.getObsDetalle());

                if (factura.getTipodoc().matches("11")) {
                    buzoncsv.setTipoItemExpor(factura.getTipoItemExpor());
                    buzoncsv.setRecintoFiscal(factura.getRecintoFiscal());
                    buzoncsv.setRegimen(factura.getRegimen());
                    buzoncsv.setCodigoImp(null);
                } else if (factura.getTipodoc().matches("05")
                        || factura.getTipodoc().matches("06")) {
                    buzoncsv.setDocRelacionado(factura.getDocRelacionado());
                    buzoncsv.setTipoDocRelacionado(factura.getTipoDocRelacionado());
                    buzoncsv.setFechaDocRelacionado(factura.getFechaDocRelacionado());
                    buzoncsv.setTipoGeneracionDocRel(factura.getTipoGeneracionDocRel());
                }
                buzoncsvList.add(buzoncsv);
            });
        } else if (factura.getTipodoc().matches("07")) {
            facturaList.forEach(docRet -> {
                Buzoncsv common = setBuzonValues();
                docRet.setCodEmisor(common.getCodEmisor());
                docRet.setTipodoc(common.getTipodoc());
                docRet.setTipodocrec(common.getTipodocrec());
                docRet.setNit(common.getNit());
                docRet.setNrc(common.getNrc());
                docRet.setNombrecliente(common.getNombrecliente());
                docRet.setCorreo(common.getCorreo());
                docRet.setTelefono(common.getTelefono());
                docRet.setDepart(common.getDepart());
                docRet.setMunicipio(common.getMunicipio());
                docRet.setComplemento(common.getComplemento());
                docRet.setCodactcom(common.getCodactcom());
                docRet.setCodFactura(common.getCodFactura());
            });
            buzoncsvList = facturaList;
        } else {
            buzoncsvList = new ArrayList<>();
        }

        String schemaName = null;

        switch (factura.getTipodoc()) {
            case "01":
                schemaName = "fe-schema.json";
                break;
            case "03":
                schemaName = "ccfe-schema.json";
                break;
            case "11":
                schemaName = "fex-schema.json";
                break;
            case "05":
                schemaName = "nce-schema.json";
                break;
            case "06":
                schemaName = "nd-schema.json";
                break;
            case "07":
                schemaName = "cr-schema.json";
                break;
            case "14":
                schemaName = "fse-schema.json";
                break;
        }

        log.info("parametros: " + buzoncsvList);

        GenericResponse respuesta = facturaService.procesoEmitirDocumento(buzoncsvList, "PROINGDATOS",
                login.getLogin(), fechaInicio, fechaFin, schemaName,
                selectedTipoComprobante.getTcpVersion(), factura.getTipodoc(),
                factura.getTipodoc().matches("07") ? observaciones07 : null);

        if (respuesta != null) {
            switch (respuesta.getVal()) {
                case 0:
                    mensaje = respuesta.getMensaje();
                    break;
                case 1:
                    mensaje = "OCURRIÓ UN ERROR: ".concat(respuesta.getMensaje());
                    log.error("PROCESO NO FINALIZÓ CORRECTAMENTE: " + respuesta.getMensaje());
                    break;
            }
            PrimeFaces.current().executeScript("PF('DialogConfirm').show();");
            PrimeFaces.current().ajax().update("frmConfirm");
        }
    }

    private Buzoncsv setBuzonValues() {
        Buzoncsv docRet = new Buzoncsv();
        docRet.setCodEmisor(emisor.getNit());
        docRet.setTipodoc(factura.getTipodoc());
        docRet.setTipodocrec(service.findTipoDocById(receptor.getRucTipoDocId()));
        docRet.setNit(receptor.getRucNitContribuyente());
        if (receptor.getRucNrc() != null && receptor.getRucNrc().length() > 0) {
            docRet.setNrc(Integer.valueOf(receptor.getRucNrc()));
        } else {
            docRet.setNrc(null);
        }
        docRet.setNombrecliente(receptor.getRucNombreRazonsocial());
        docRet.setCorreo(receptor.getRucEmailContribuyente());
        docRet.setTelefono(receptor.getRucTelefonoTrabajo());
        docRet.setDepart(receptor.getRucCodigoDepartamento());
        docRet.setMunicipio(Integer.valueOf(receptor.getRucCodigoMunicipio()));
        docRet.setComplemento(receptor.getRucDomicilio());
        docRet.setCodactcom(receptor.getRucCodactividad());
        docRet.setCodFactura(nroDocumento);
        docRet.setIdUsuarioIngreso(login.getLogin().getIdUsuario());
        return docRet;
    }

    public void clean() {
        fechaInicio = null;
        fechaFin = null;
        continuar = Boolean.FALSE;
        factura = new Buzoncsv();
        nroDocumento = null;
        receptor = new Contribuyentes();
        receptorDeptoDesc = null;
        receptorMuniDesc = null;
        codProducto = null;
        cantidad = 0;
        producto = new CatalogoProductos();
        exento = Boolean.FALSE;
        descuento = BigDecimal.valueOf(0.00);
        unidadMedida = null;
        otrosCargos = BigDecimal.valueOf(0.00);
        referencia = null;
        detalleList = new ArrayList<>();
        tributosList = new ArrayList<>();
        totalDetalle = BigDecimal.valueOf(0.00);
        condicionOp = null;
        moneda = "USD";
        tipoCambio = 1;
        periodo = 0;
        plazo = null;
        medioPago = null;
        totalesDTOList = new ArrayList<>();
        reenviar = Boolean.FALSE;
        facturaList = new ArrayList<>();
        PrimeFaces.current().executeScript("PF('DialogConfirm').hide();");
        tabView.setActiveIndex(0);
        PrimeFaces.current().ajax().update("mainFrm");
    }

    public void comprobanteRetListener() {
        if (factura.getCodigo_retencion() != null) {
            if (!Objects.equals(factura.getMonto_sujeto_gravado(), new BigDecimal("0.00"))) {
                switch (factura.getCodigo_retencion()) {
                    case 1:
                        factura.setMonto_retencion_iva(factura.getMonto_sujeto_gravado().multiply(new BigDecimal("0.01")));
                        break;
                    case 2:
                        factura.setMonto_retencion_iva(factura.getMonto_sujeto_gravado().multiply(new BigDecimal("0.13")));
                        break;
                    case 3:

                        break;
                }
            }
        }
    }

    public void calculoRetIVA13() {
        if (cantidad > 0) {

        } else {
            ViewUtils.showMessageError("DEBE INGRESAR UNA CANTIDAD PARA REALIZAR EL CÁLCULO");
        }
    }

    public void changeValorUnitario() {
        log.info("se cambió el precio unitario a: " + precioUnitario + ", precio catalogo producto : " + producto.getValorUnitario());
    }

    public void completeReceptor() {
        receptor = receptorService.findReceptoresByNit(receptorStr.replace("-", ""), login.getLogin().getIdEmpresa());

        if (receptor.getRucId() == null) {
            MessageUtil.builder()
                    .severity(FacesMessage.SEVERITY_WARN)
                    .message("NO SE ENCONTRO EL CLIENTE")
                    .title("ALERTA")
                    .build();
        }
    }

    public void limpiarReceptorFe() {
        if (sinDatos) {
            nitReceptor = "";
            receptorDeptoDesc = "";
            receptorMuniDesc = "";
            receptor = facturaService.findReceptoNull();
        } else {
            receptor = new Contribuyentes();
        }
    }

    public void onItemSelect(SelectEvent<String> event) {
        receptorStr = event.getObject();

        receptor = receptorService.findReceptoresByNit(receptorStr, login.getLogin().getIdEmpresa());

        if (receptor.getRucId() == null) {
            MessageUtil.builder()
                    .severity(FacesMessage.SEVERITY_WARN)
                    .message("NO SE ENCONTRO EL CLIENTE")
                    .title("ALERTA")
                    .build();
        }
    }
}
