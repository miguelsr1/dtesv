package sv.com.jsoft.stdte.repository;

import java.text.ParseException;
import sv.com.jsoft.stdte.persistence.BitacoraDeclaracionHacienda;
import sv.com.jsoft.stdte.utils.ViewUtils;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.persistence.TypedQuery;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import lombok.extern.slf4j.Slf4j;

@Stateless
@Slf4j
public class BitacoraService {

    @PersistenceContext
    private EntityManager entityManager;

    public List<BitacoraDeclaracionHacienda> findLikeByCodGeneracion(String codGeneracion, String user) {
        List<BitacoraDeclaracionHacienda> result = new ArrayList<>();
        try {
            StringBuilder jpqlBuilder = new StringBuilder();
            jpqlBuilder.append("SELECT b, f.facNumeroDeControl FROM BitacoraDeclaracionHacienda b JOIN Factura f ON b.idFac = f.facId WHERE b.codigoGeneracion like :codGen");

            TypedQuery<Object[]> query = entityManager.createQuery(jpqlBuilder.toString(), Object[].class);
            query.setParameter("codGen", "%" + codGeneracion.toUpperCase() + "%");

            List<Object[]> results = query.getResultList();

            for (Object[] obj : results) {
                BitacoraDeclaracionHacienda bitacora = (BitacoraDeclaracionHacienda) obj[0];
                String nroControl = (String) obj[1];
                bitacora.setNroControlDte(nroControl);
                result.add(bitacora);
            }
            result.forEach(item -> {
                String input = item.getNroControlDte();
                int lasIndex = input.lastIndexOf("-");
                String res = input.substring(lasIndex + 1);
                item.setNroControlDte(extractNumbers(res));
            });
        } catch (Exception e) {
            log.error("USER: " + user);
            log.error("ERROR EN findLikeByCodGeneracion", e);
        }

        return result;
    }
    
    public List<BitacoraDeclaracionHacienda> findAllDocEmitidos(Integer idEmpresa, String startDate, String endDate, String tipoDocumento, String nroDte, String receptor, String estado, String user) {
        List<BitacoraDeclaracionHacienda> result = new ArrayList<>();
        try {
            StringBuilder jpqlBuilder = new StringBuilder();
            jpqlBuilder.append("SELECT b, f.facNumeroDeControl FROM Contribuyentes c JOIN Empresa e ON c.idEmpresa = e.idEmpresa JOIN Factura f ON f.facNitEmisor = e.nit JOIN BitacoraDeclaracionHacienda b ON b.idFac = f.facId WHERE b.estado in ('PROCESADO','OBSERVADO') and ");

            if (startDate != null && endDate != null) {
                jpqlBuilder.append(" b.fechaIngreso >= :startDate AND b.fechaIngreso <= :endDate");
            }
            if (tipoDocumento != null && tipoDocumento.length() > 0) {
                jpqlBuilder.append(" AND f.facTipoComprobante = :tipoDoc");
            }
            if (nroDte != null && nroDte.length() > 0) {
                jpqlBuilder.append(" AND f.facNumeroDeControl = :dte");
            }
            if (receptor != null && receptor.length() > 0) {
                jpqlBuilder.append(" AND f.facNitReceptor = :nitReceptor");
            }
            if (estado != null && estado.length() > 0) {
                jpqlBuilder.append(" AND b.estado = :estado");
            }

            TypedQuery<Object[]> query = entityManager.createQuery(jpqlBuilder.toString(), Object[].class);

            if (startDate != null && endDate != null) {
                query.setParameter("startDate", ViewUtils.formatStringToDate(startDate));
                LocalDateTime endDateTime = LocalDateTime.ofInstant(
                        ViewUtils.formatStringToDate(endDate).toInstant(), ZoneId.systemDefault())
                        .plusDays(1);
                query.setParameter("endDate", Date.from(endDateTime.atZone(ZoneId.systemDefault()).toInstant()));
            }
            if (tipoDocumento != null && tipoDocumento.length() > 0) {
                query.setParameter("tipoDoc", tipoDocumento);
            }
            if (nroDte != null && nroDte.length() > 0) {
                query.setParameter("dte", nroDte);
            }
            if (receptor != null && receptor.length() > 0) {
                query.setParameter("nitReceptor", receptor);
            }
            if (estado != null && estado.length() > 0) {
                query.setParameter("estado", estado);
            }
            List<Object[]> results = query.getResultList();

            for (Object[] obj : results) {
                BitacoraDeclaracionHacienda bitacora = (BitacoraDeclaracionHacienda) obj[0];
                String nroControl = (String) obj[1];
                bitacora.setNroControlDte(nroControl);
                result.add(bitacora);
            }
            result.forEach(item -> {
                String input = item.getNroControlDte();
                int lasIndex = input.lastIndexOf("-");
                String res = input.substring(lasIndex + 1);
                item.setNroControlDte(extractNumbers(res));
            });
        } catch (ParseException e) {
            log.error("USER: " + user);
            log.error("ERROR EN findAllDocEmitidos", e);
        }

        return result;
    }

    public List<BitacoraDeclaracionHacienda> findAllDocEmitidos(String startDate, String endDate, String tipoDocumento, String nroDte, String receptor, String estado, String user) {
        List<BitacoraDeclaracionHacienda> result = new ArrayList<>();
        try {
            StringBuilder jpqlBuilder = new StringBuilder();
            jpqlBuilder.append("SELECT b, f.facNumeroDeControl FROM BitacoraDeclaracionHacienda b JOIN Factura f ON b.idFac = f.facId WHERE b.estado in ('PROCESADO','OBSERVADO') and ");

            if (startDate != null && endDate != null) {
                jpqlBuilder.append(" b.fechaIngreso >= :startDate AND b.fechaIngreso <= :endDate");
            }
            if (tipoDocumento != null && tipoDocumento.length() > 0) {
                jpqlBuilder.append(" AND f.facTipoComprobante = :tipoDoc");
            }
            if (nroDte != null && nroDte.length() > 0) {
                jpqlBuilder.append(" AND f.facNumeroDeControl = :dte");
            }
            if (receptor != null && receptor.length() > 0) {
                jpqlBuilder.append(" AND f.facNitReceptor = :nitReceptor");
            }
            if (estado != null && estado.length() > 0) {
                jpqlBuilder.append(" AND b.estado = :estado");
            }

            TypedQuery<Object[]> query = entityManager.createQuery(jpqlBuilder.toString(), Object[].class);

            if (startDate != null && endDate != null) {
                query.setParameter("startDate", ViewUtils.formatStringToDate(startDate));
                LocalDateTime endDateTime = LocalDateTime.ofInstant(
                        ViewUtils.formatStringToDate(endDate).toInstant(), ZoneId.systemDefault())
                        .plusDays(1);
                query.setParameter("endDate", Date.from(endDateTime.atZone(ZoneId.systemDefault()).toInstant()));
            }
            if (tipoDocumento != null && tipoDocumento.length() > 0) {
                query.setParameter("tipoDoc", tipoDocumento);
            }
            if (nroDte != null && nroDte.length() > 0) {
                query.setParameter("dte", nroDte);
            }
            if (receptor != null && receptor.length() > 0) {
                query.setParameter("nitReceptor", receptor);
            }
            if (estado != null && estado.length() > 0) {
                query.setParameter("estado", estado);
            }
            List<Object[]> results = query.getResultList();

            for (Object[] obj : results) {
                BitacoraDeclaracionHacienda bitacora = (BitacoraDeclaracionHacienda) obj[0];
                String nroControl = (String) obj[1];
                bitacora.setNroControlDte(nroControl);
                result.add(bitacora);
            }
            result.forEach(item -> {
                String input = item.getNroControlDte();
                int lasIndex = input.lastIndexOf("-");
                String res = input.substring(lasIndex + 1);
                item.setNroControlDte(extractNumbers(res));
            });
        } catch (ParseException e) {
            log.error("USER: " + user);
            log.error("ERROR EN findAllDocEmitidos", e);
        }

        return result;
    }

    public static String extractNumbers(String input) {
        StringBuilder result = new StringBuilder();
        boolean leadingZeros = true;

        for (int i = 0; i < input.length(); i++) {
            char c = input.charAt(i);
            if (Character.isDigit(c)) {
                if (leadingZeros && c != '0') {
                    leadingZeros = false;
                }
                if (!leadingZeros) {
                    result.append(c);
                }
            }
        }
        if (result.length() == 0) {
            result.append('0');
        }
        return result.toString();
    }

    public int findIdFacturaByCodGeneracion(String codigoGeneracion, String user) {
        int idFactura = 0;
        try {
            Query query = entityManager.createQuery("from BitacoraDeclaracionHacienda b "
                    + "where b.codigoGeneracion = :codGen")
                    .setParameter("codGen", codigoGeneracion);
            BitacoraDeclaracionHacienda bitac = (BitacoraDeclaracionHacienda) query.getSingleResult();
            idFactura = bitac.getIdFac();
        } catch (Exception e) {
            log.error("USER: " + user);
            log.error("ERROR EN findIdFacturaByCodGeneracion", e);
        }
        return idFactura;
    }
}
