package sv.com.jsoft.stdte.utils;

import net.sf.jasperreports.engine.*;

import org.apache.log4j.Logger;

import javax.ejb.Stateless;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Map;


@Stateless
public class JasperReportUtil {

    static final Logger logger = Logger.getLogger(JasperReportUtil.class.getName());
    public JasperReportUtil() {

    }

    public byte[] getReportToPdf(String path, Map map, String reportName) throws NamingException, SQLException {
        byte[] pdf = new byte[0];
        Context ctx = new InitialContext();
        DataSource ds = (DataSource) ctx.lookup(ModelUtils.getResource("DataSource"));
        Connection conexion = null;
        conexion = ds.getConnection(ModelUtils.getResource("username"), ModelUtils.getResource("password"));
        try {
            File reportFile = compile(reportName, path);
            pdf = JasperRunManager.runReportToPdf(reportFile.getPath(), map, conexion);
        } catch (JRException|IOException e) {
            logger.info("se presento un error en getReportToPdf: " + e.getMessage());
            e.printStackTrace();
        }finally {
            conexion.close();
        }
        return pdf;
    }

    private File compile(String reportName, String path)
            throws JRException, IOException {
        File reportFile = new File(path + File.separator + reportName + ".jasper");
        if (!reportFile.exists()) {
            String strReportSourceFile = path + File.separator +reportName + ".jrxml";
            File fileReport = new File(strReportSourceFile);
            if (!fileReport.exists()) {
                strReportSourceFile = path + File.separator +reportName + ".jrxml";
            }
            JasperCompileManager.compileReportToFile(strReportSourceFile, reportFile.toString());
        }
        return reportFile;
    }


    public JasperPrint getJasperPrintReport(Map map, String reportName, String path) {
        JasperPrint jasperPrint = null;
        Connection conexion = null;
        try {
            Context ctx = new InitialContext();
            DataSource ds = (DataSource) ctx.lookup(ModelUtils.getResource("DataSource"));
            conexion = ds.getConnection(ModelUtils.getResource("username"), ModelUtils.getResource("password"));
            File reportFile = compile(reportName, path);
            jasperPrint = JasperFillManager.fillReport(reportFile.getAbsolutePath(), map, conexion);
        } catch (NamingException | JRException | IOException | SQLException e) {
            logger.error("SE PRESENTO EL SIGUIENTE ERROR getJasperPrintReport: ", e);
        } finally {
            try {
                if (conexion != null) {
                    conexion.close();
                }
            } catch (Exception e) {
            }
        }
        return jasperPrint;
    }

}
