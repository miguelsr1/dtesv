package sv.com.jsoft.stdte.servlet;

import org.apache.log4j.Logger;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "JasperReportServlet", urlPatterns = {"/viewReport/*"})
public class JasperReportServlet extends HttpServlet {

    protected final static Logger logger = Logger.getLogger(JasperReportServlet.class);

    protected void processRequest(HttpServletRequest request, HttpServletResponse response){
//        String filename = request.getParameter("filename");
        try{
            byte[] reportBytes = (byte[]) request.getSession().getAttribute("REPORT");
            if(reportBytes != null){
                request.getSession().removeAttribute("REPORT");
                response.setContentType("application/pdf");
//                if(!filename.isEmpty()) {
//                    response.setHeader("Content-Disposition", "attachment; filename=" + filename);
//                }
                response.setContentLength(reportBytes.length);
                response.getOutputStream().write(reportBytes);

            }
        }catch (Exception e){
            logger.info("error en JasperReportServlet: " + e.getMessage());
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
