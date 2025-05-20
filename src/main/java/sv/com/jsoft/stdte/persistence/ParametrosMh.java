package sv.com.jsoft.stdte.persistence;

import java.io.Serializable;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import javax.persistence.*;
import java.util.Objects;

@Entity
@Data
@NoArgsConstructor
@ToString
@Table(name = "parametros_mh", schema = "fact")
public class ParametrosMh implements Serializable {

    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "pm_id")
    private int pmId;
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

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }
        ParametrosMh that = (ParametrosMh) o;
        return pmId == that.pmId && Objects.equals(pmJsonFirmadorNit, that.pmJsonFirmadorNit) && Objects.equals(pmJsonFirmadorPass, that.pmJsonFirmadorPass) && Objects.equals(pmJsonFirmadorUrl, that.pmJsonFirmadorUrl) && Objects.equals(pmJsonAuthUser, that.pmJsonAuthUser) && Objects.equals(pmJsonAuthPass, that.pmJsonAuthPass) && Objects.equals(pmJsonAuthUrl, that.pmJsonAuthUrl) && Objects.equals(pmJsonFesvMhVersion, that.pmJsonFesvMhVersion) && Objects.equals(pmJsonFesvMhAmbiente, that.pmJsonFesvMhAmbiente) && Objects.equals(pmJsonFesvMhIdenvio, that.pmJsonFesvMhIdenvio) && Objects.equals(pmJsonFesvMhUrl, that.pmJsonFesvMhUrl) && Objects.equals(pmQrLink, that.pmQrLink) && Objects.equals(pmAnulaciondteUrl, that.pmAnulaciondteUrl);
    }

    @Override
    public int hashCode() {
        return Objects.hash(pmId, pmJsonFirmadorNit, pmJsonFirmadorPass, pmJsonFirmadorUrl, pmJsonAuthUser, pmJsonAuthPass, pmJsonAuthUrl, pmJsonFesvMhVersion, pmJsonFesvMhAmbiente, pmJsonFesvMhIdenvio, pmJsonFesvMhUrl, pmQrLink, pmAnulaciondteUrl);
    }
}
