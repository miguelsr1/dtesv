package sv.com.jsoft.stdte.utils;

/**
 *
 * @author msanchez
 */
public class QueryUtils {

    public final static String INFO_DTE = "select \n"
            + "	tc.tcp_descomprobante,\n"
            + "    bdh.codigo_generacion,\n"
            + "    bdh.fecha_ingreso,\n"
            + "    bdh.selloRecibido\n"
            + "from buzoncsv b \n"
            + "	inner join tipos_comprobantes tc on b.tipodoc = tc.tcp_idtipcom\n"
            + "    inner join factura f on f.fac_nro_factura = b.cod_factura\n"
            + "    inner join bitacora_declaracion_hacienda bdh on f.fac_id = bdh.id_fac and bdh.estado in ('PROCESADO','OBSERVADO')\n"
            + "where f.fac_id = :idFac";

    public final static String ID_EMPRESA_BY_USUARIO = "SELECT e.id_empresa \n"
            + "FROM usuario u\n"
            + "	inner join empresa e on u.correo_electronico = e.usuario\n"
            + "where u.correo_electronico = :usuario";
}
