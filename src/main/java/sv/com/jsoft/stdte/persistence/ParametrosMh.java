package sv.com.jsoft.stdte.persistence;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.EqualsAndHashCode;

@Entity
@Table(name = "parametros_mh", schema = "fact")
@Data
@NoArgsConstructor
@EqualsAndHashCode
public class ParametrosMh implements Serializable {

    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "pm_id")
    private Integer pmId;
    @Basic
    @Column(name = "pm_json_firmador_nit")
    private String pmJsonFirmadorNit;
    @Basic
    @Column(name = "pm_json_firmador_pass")
    private String pmJsonFirmadorPass;
    @Basic
    @Column(name = "pm_json_firmador_url")
    private String pmJsonFirmadorUrl;
    @Basic
    @Column(name = "pm_json_auth_user")
    private String pmJsonAuthUser;
    @Basic
    @Column(name = "pm_json_auth_pass")
    private String pmJsonAuthPass;
    @Basic
    @Column(name = "pm_json_auth_url")
    private String pmJsonAuthUrl;
    @Basic
    @Column(name = "pm_json_fesv_mh_version")
    private Integer pmJsonFesvMhVersion;
    @Basic
    @Column(name = "pm_json_fesv_mh_ambiente")
    private String pmJsonFesvMhAmbiente;
    @Basic
    @Column(name = "pm_json_fesv_mh_idenvio")
    private Integer pmJsonFesvMhIdenvio;
    @Basic
    @Column(name = "pm_json_fesv_mh_url")
    private String pmJsonFesvMhUrl;
    @Basic
    @Column(name = "pm_qr_link")
    private String pmQrLink;
    @Basic
    @Column(name = "pm_anulaciondte_url")
    private String pmAnulaciondteUrl;
    @Basic
    @Column(name = "pm_anulaciondte_version")
    private Integer pmAnulaciondteVersion;
    @Basic
    @Column(name = "id_empresa")
    private Integer idEmpresa;
    @Basic
    @Column(name = "certificado")
    private String certificado;
    @Basic
    @Column(name = "activo")
    private Boolean activo;

    @Transient
    private Boolean test;

    
}
