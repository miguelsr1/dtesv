package sv.com.jsoft.stdte.persistence;

import java.io.Serializable;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import javax.persistence.*;
import java.sql.Timestamp;

@Entity
@Table(name = "contribuyentes", schema = "fact")
@Data
@NoArgsConstructor
@EqualsAndHashCode
public class Contribuyentes implements Serializable {

    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "ruc_id")
    private Integer rucId;
    @Basic
    @Column(name = "ruc_nit_contribuyente")
    private String rucNitContribuyente;
    @Basic
    @Column(name = "ruc_nombre_razonsocial")
    private String rucNombreRazonsocial;
    @Basic
    @Column(name = "ruc_apellidos_paterno")
    private String rucApellidosPaterno;
    @Basic
    @Column(name = "ruc_apellidos_materno")
    private String rucApellidosMaterno;
    @Basic
    @Column(name = "ruc_domicilio")
    private String rucDomicilio;
    @Basic
    @Column(name = "ruc_telefono_personal")
    private String rucTelefonoPersonal;
    @Basic
    @Column(name = "ruc_telefono_trabajo")
    private String rucTelefonoTrabajo;
    @Basic
    @Column(name = "ruc_email_contribuyente")
    private String rucEmailContribuyente;
    @Basic
    @Column(name = "ruc_dui_contribuyente")
    private String rucDuiContribuyente;
    @Basic
    @Column(name = "ruc_estado_contribuyente")
    private String rucEstadoContribuyente;
    @Basic
    @Column(name = "ruc_fecha_vencimientodui")
    private Timestamp rucFechaVencimientodui;
    @Basic
    @Column(name = "ruc_codigo_departamento")
    private String rucCodigoDepartamento;
    @Basic
    @Column(name = "ruc_codigo_municipio")
    private String rucCodigoMunicipio;
    @Basic
    @Column(name = "ruc_tipo_contribuyente")
    private String rucTipoContribuyente;
    @Basic
    @Column(name = "ruc_id_geografico")
    private Integer rucIdGeografico;
    @Basic
    @Column(name = "ruc_codigo_mh")
    private String rucCodigoMh;
    @Basic
    @Column(name = "ruc_nrc")
    private String rucNrc;
    @Basic
    @Column(name = "ruc_codactividad")
    private String rucCodactividad;
    @Basic
    @Column(name = "ruc_desactividad")
    private String rucDesactividad;
    @Basic
    @Column(name = "ruc_tipoestablecimiento")
    private String rucTipoestablecimiento;
    @Basic
    @Column(name = "ruc_cod_punto_venta_mh")
    private String rucCodPuntoVentaMh;
    @Basic
    @Column(name = "ruc_cod_punto_venta")
    private String rucCodPuntoVenta;
    @Basic
    @Column(name = "ruc_cod_establecimiento")
    private String rucCodEstablecimiento;
    @Basic
    @Column(name = "ruc_tipo_doc_id")
    private Integer rucTipoDocId;
    @Basic
    @Column(name = "ruc_nombre_comercial")
    private String rucNombreComercial;
    @Basic
    @Column(name = "ruc_tipo_item_expor")
    private Integer rucTipoItemExpor;
    @Basic
    @Column(name = "ruc_recinto_fiscal")
    private String rucRecintoFiscal;
    @Basic
    @Column(name = "ruc_regimen")
    private String rucRegimen;
    @Basic
    @Column(name = "ruc_cp_id_pais")
    private Integer rucCpIdPais;
    @Basic
    @Column(name = "ruc_ctper_id")
    private Integer rucCtperId;
    @Basic
    @Column(name = "id_empresa")
    private Integer idEmpresa;
    @Basic
    @Column(name = "inscrito_iva")
    private Boolean inscritoIva;

    @ManyToOne
    @JoinColumn(name = "ruc_tipo_doc_id", referencedColumnName = "doc_id", insertable = false, updatable = false)
    private TiposDocumentos tipoDocumento;
}
