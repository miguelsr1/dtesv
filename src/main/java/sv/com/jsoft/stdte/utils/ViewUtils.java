package sv.com.jsoft.stdte.utils;

import org.primefaces.PrimeFaces;
import javax.faces.application.FacesMessage;
import javax.faces.context.ExternalContext;
import javax.faces.context.FacesContext;
import javax.faces.model.SelectItem;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.sql.SQLException;
import java.text.MessageFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class ViewUtils {

    private static Properties errorCodes = null;
    private static final String[] HEADERS_TO_TRY = {
        "X-Forwarded-For",
        "Proxy-Client-IP",
        "WL-Proxy-Client-IP",
        "HTTP_X_FORWARDED_FOR",
        "HTTP_X_FORWARDED",
        "HTTP_X_CLUSTER_CLIENT_IP",
        "HTTP_CLIENT_IP",
        "HTTP_FORWARDED_FOR",
        "HTTP_FORWARDED",
        "HTTP_VIA",
        "REMOTE_ADDR"};

    /*public static Object eval(String expr) {
        FacesContext ctx = FacesContext.getCurrentInstance();
        ValueBinding binding = ctx.getApplication().createValueBinding(expr);
        return binding.getValue(ctx);
    }*/
    public static void addErrorMessage(FacesContext context, String compId,
            String messageId) {
        ResourceBundle bundle
                = ResourceBundle.getBundle(context.getApplication().getMessageBundle());
        FacesMessage msg = new FacesMessage(bundle.getString(messageId));
        msg.setSeverity(FacesMessage.SEVERITY_ERROR);
        context.addMessage(compId, msg);
    }

    public static void addErrorMessage(FacesContext context, String cadena) {
        FacesMessage msg = new FacesMessage(cadena);
        msg.setSeverity(FacesMessage.SEVERITY_ERROR);
        context.addMessage(null, msg);
    }

    public static void addErrorMessageFormat(FacesContext context, String compId, String messageId, Object[] params) {
        MessageFormat mf;
        ResourceBundle bundle
                = ResourceBundle.getBundle(context.getApplication().getMessageBundle());
        if (params != null) {
            mf = new MessageFormat(bundle.getString(messageId));
            messageId = mf.format(params, new StringBuffer(), null).toString();
        }
        FacesMessage msg = new FacesMessage(messageId);
        msg.setSeverity(FacesMessage.SEVERITY_ERROR);
        context.addMessage(compId, msg);
    }

    public static String getErrorMessageFormat(FacesContext context, String messageId, Object[] params) {
        MessageFormat mf;
        ResourceBundle bundle
                = ResourceBundle.getBundle(context.getApplication().getMessageBundle());
        if (params != null) {
            mf = new MessageFormat(bundle.getString(messageId));
            messageId = mf.format(params, new StringBuffer(), null).toString();
        }
        return messageId;
    }

    public static void addExceptionMessage(Exception x) {
        FacesContext ctx = FacesContext.getCurrentInstance();
        FacesMessage msg = new FacesMessage(x.getMessage());
        msg.setSeverity(FacesMessage.SEVERITY_FATAL);
        ctx.addMessage(null, msg);
        if (x instanceof SQLException) {
            int num = ((SQLException) x).getErrorCode();
            String codigo = Integer.toString(num);
            ctx.addMessage(null, new FacesMessage(getJdbDescription(codigo)));
        }
    }

    /*public static void addExceptionMessage(String mensaje, Exception x) {
        FacesContext ctx = FacesContext.getCurrentInstance();
        FacesMessage message = null;
        if (x instanceof NullPointerException) {
            message = new FacesMessage(mensaje);
        } else {
            message = new FacesMessage(x.getMessage());
        }
        message.setSeverity(FacesMessage.SEVERITY_FATAL);
        LoginBean login = (LoginBean) eval("#{login}");
        ctx.addMessage(null, message);
        if (login != null && login.getUsuario() == null
                && login.getClave() == null) {
            addErrorMessage(ctx, null,
                    "sertracen.com.sv.view.backing.SesionCaducada");
        } else {
            if (x instanceof SQLException) {
                int num = ((SQLException) x).getErrorCode();
                String codigo = Integer.toString(num);
                ctx.addMessage(null,
                        new FacesMessage(getJdbDescription(codigo)));
            }
            ctx.getExternalContext().log(mensaje, x);
        }
    }*/
    public static void addSessionAttribute(String id, Object obj) {
        FacesContext ctx = FacesContext.getCurrentInstance();
        HttpSession session
                = (HttpSession) ctx.getExternalContext().getSession(false);
        session.setAttribute(id, obj);
    }

    public static void removeSessionAttribute(String id) {
        FacesContext ctx = FacesContext.getCurrentInstance();
        HttpSession session
                = (HttpSession) ctx.getExternalContext().getSession(false);
        session.removeAttribute(id);
    }

    public static String getJdbDescription(String errCode) {
        if (errorCodes == null) {
            errorCodes = new Properties();
            FacesContext context = FacesContext.getCurrentInstance();
            HttpSession session
                    = (HttpSession) context.getExternalContext().getSession(false);
            String strPropPath
                    = session.getServletContext().getRealPath("/WEB-INF/errorCodes.properties");
            try {
                FileInputStream ins = new FileInputStream(strPropPath);
                errorCodes.load(ins);
            } catch (FileNotFoundException e) {
                addExceptionMessage(e);
            } catch (IOException e) {
                addExceptionMessage(e);
            }
        }
        return errorCodes.getProperty(errCode);
    }

    /*public static Map<Object, Object> createMap(List lista, String id,
            String valor) {
        Map<Object, Object> map = new LinkedHashMap<>();
        Object tmp1 = null;
        Object tmp2 = null;
        try {
            for (int i = 0; i < lista.size(); i++) {
                Class clase = lista.get(i).getClass();
                BeanInfo info = Introspector.getBeanInfo(clase);
                PropertyDescriptor props[] = info.getPropertyDescriptors();
                Object noParams[] = new Object[0];
                for (PropertyDescriptor prop : props) {
                    Method getter = prop.getReadMethod();
                    Object value = getter.invoke(lista.get(i), noParams);
                    if (getter.toString().toLowerCase().indexOf(id) > 0) {
                        tmp1 = value;
                    }
                    if (getter.toString().toLowerCase().indexOf(valor) > 0) {
                        tmp2 = value;
                    }
                }
                map.put(tmp2, tmp1);
            }
        } catch (IntrospectionException | IllegalAccessException | InvocationTargetException e) {
            log.error("Exception ", e);
        }
        return map;
    }

    public static Map<Object, Object> createMap(List lista) {
        Map<Object, Object> map = new LinkedHashMap<>();
        try {
            for (int i = 0; i < lista.size(); i++) {
                Class clase = lista.get(i).getClass();
                BeanInfo info = Introspector.getBeanInfo(clase);
                PropertyDescriptor props[] = info.getPropertyDescriptors();
                Object noParams[] = new Object[0];
                if (props != null && props.length > 0) {
                    Object value1
                            = props[1].getReadMethod().invoke(lista.get(i),
                                    noParams);
                    Object value2
                            = props[2].getReadMethod().invoke(lista.get(i),
                                    noParams);
                    map.put(value2, value1);
                }
            }
        } catch (IntrospectionException | IllegalAccessException | InvocationTargetException e) {
            System.out.println("Exception " + e);
        }
        return map;
    }*/
    public static FacesContext getFacesContext() {
        return FacesContext.getCurrentInstance();
    }

    public static HttpServletRequest getRequest() {
        FacesContext ctx = getFacesContext();
        HttpServletRequest request = (HttpServletRequest) ctx.getExternalContext().getRequest();
        return request;
    }

    public static String getClientIpAddress() {
        HttpServletRequest request = ViewUtils.getRequest();
        for (String header : HEADERS_TO_TRY) {
            String ip = request.getHeader(header);
            if (ip != null && ip.length() != 0 && !"unknown".equalsIgnoreCase(ip)) {
                return ip + ",";
            }
        }
        return request.getRemoteAddr();
    }

    public static HttpServletResponse getResponse() {
        FacesContext ctx = getFacesContext();
        HttpServletResponse response = (HttpServletResponse) ctx.getExternalContext().getResponse();
        return response;
    }

    public static HttpSession getSession() {
        FacesContext ctx = getFacesContext();
        HttpSession session = (HttpSession) ctx.getExternalContext().getSession(false);
        return session;
    }

    public static HttpSession getSession(boolean band) {
        FacesContext ctx = getFacesContext();
        HttpSession session = (HttpSession) ctx.getExternalContext().getSession(band);
        return session;
    }

    public static Object getAttributeCtx(String attr) {
        ExternalContext ex = FacesContext.getCurrentInstance().getExternalContext();
        ServletContext sc = (ServletContext) ex.getContext();
        return sc.getAttribute(attr);
    }

    public static Map getServletMap() {
        Map map = new HashMap();
        map.put("request", getRequest());
        map.put("response", getResponse());
        return map;
    }

    public static void doEjecutaReporte(String reporte,
            HashMap parametrosReporte,
            String formato) throws IOException {
        Map map = ViewUtils.getServletMap();
        HttpServletRequest request = (HttpServletRequest) map.get("request");
        HttpServletResponse response
                = (HttpServletResponse) map.get("response");
        try {
            Hashtable parametrosEjecucion = new Hashtable();
            parametrosEjecucion.put("reportOutType", formato);
            parametrosEjecucion.put("reportName", reporte);
            parametrosEjecucion.put("reportParams", parametrosReporte);
            request.getSession().setAttribute("reportparams",
                    parametrosEjecucion);
            response.sendRedirect(request.getContextPath() + "/JasperServlet");
        } catch (IOException ex) {
            ViewUtils.addExceptionMessage(ex);
            throw ex;
        }
    }

    public static void doEjecutaReporte(String reporte,
            HashMap parametrosReporte,
            ArrayList subReports,
            String formato) throws IOException {
        Map map = ViewUtils.getServletMap();
        HttpServletRequest request = (HttpServletRequest) map.get("request");
        HttpServletResponse response
                = (HttpServletResponse) map.get("response");
        HttpSession session = request.getSession();
        try {
            Hashtable parametrosEjecucion = new Hashtable();
            parametrosReporte.put("SUBREPORT_DIR",
                    session.getServletContext().getRealPath(session.getServletContext().getInitParameter("reportPath")
                            + "/"));
            parametrosEjecucion.put("subReports", subReports);
            parametrosEjecucion.put("reportOutType", formato);
            parametrosEjecucion.put("reportName", reporte);
            parametrosEjecucion.put("reportParams", parametrosReporte);
            request.getSession().setAttribute("reportparams", parametrosEjecucion);
            response.sendRedirect(request.getContextPath() + "/JasperServlet");
        } catch (IOException ex) {
            ViewUtils.addExceptionMessage(ex);
            throw ex;
        }
    }

    public static ArrayList<SelectItem> getListaDias() {
        ArrayList<SelectItem> selItemDias = new ArrayList<>();
        selItemDias.add(new SelectItem("--", "--"));
        for (int i = 1; i <= 31; i++) {
            if (i < 10) {
                selItemDias.add(new SelectItem("0" + i, "0" + i));
            } else {
                selItemDias.add(new SelectItem(String.valueOf(i),
                        String.valueOf(i)));
            }
        }
        return selItemDias;
    }

    public static ArrayList<SelectItem> getListaMeses() {
        ArrayList<SelectItem> selItemMeses = new ArrayList<>();
        String mes[]
                = new String[]{"Ene", "Feb", "Mar", "Abr", "May", "Jun", "Jul",
                    "Ago", "Sep", "Oct", "Nov", "Dic"};
        selItemMeses.add(new SelectItem("--", "--"));
        for (int i = 0; i < mes.length; i++) {
            if (i < 9) {
                selItemMeses.add(new SelectItem("0" + String.valueOf(i + 1),
                        mes[i]));
            } else {
                selItemMeses.add(new SelectItem(String.valueOf(i + 1),
                        mes[i]));
            }
        }
        return selItemMeses;
    }

    public static ArrayList<SelectItem> getListaAnos() {
        ArrayList<SelectItem> selItemAnos = new ArrayList<>();
        Calendar cal = Calendar.getInstance();
        selItemAnos.add(new SelectItem("--", "--"));
        for (int i = cal.get(Calendar.YEAR); i >= 1900; i--) {
            selItemAnos.add(new SelectItem(String.valueOf(i),
                    String.valueOf(i)));
        }
        return selItemAnos;
    }

    public static boolean find(String patron, String cadena) {
        Pattern pattern = Pattern.compile(patron);
        Matcher matcher = pattern.matcher(cadena);
        return matcher.find();
    }

    public static boolean isFechaFutura(Date fecha) {
        if (fecha != null) {
            Date hoy = new Date();
            if (fecha.after(hoy)) {
                return true;
            }
        }
        return false;
    }

    public static List<String> eliminaElementosRepetidos(List<String> mensajes) {
        Set set = new HashSet();
        for (String cad : mensajes) {
            if (!set.contains(cad)) {
                set.add(cad);
            }
        }
        return new ArrayList(set);
    }

    /*public static byte[] hexStringToByteArray(String s) {
        int len = s.length();
        byte[] data = new byte[len / 2];
        for (int i = 0; i < len; i += 2) {
            data[i / 2]
                    = (byte) ((Character.digit(s.charAt(i), 16) << 4) + Character.digit(s.charAt(i
                    + 1),
                    16));
        }
        return data;
    }

    public static String getHexString(byte[] b) {
        String result = "";
        for (int i = 0; i < b.length; i++) {
            result += Integer.toString((b[i] & 0xff) + 0x100, 16).substring(1);
        }
        return result;
    }*/
    public static boolean isMozillaBrowser() {
        boolean band = false;
        String userAgent = getRequest().getHeader("user-agent");
        if (userAgent != null && userAgent.contains("Mozilla/")
                && userAgent.contains("Firefox/")) {
            band = true;
        }
        return band;
    }

    public static boolean isChromeBrowser() {
        boolean band = false;
        String userAgent = getRequest().getHeader("user-agent");
        if (userAgent != null && userAgent.contains("Mozilla/")
                && userAgent.contains("Chrome/")) {
            band = true;
        }
        return band;
    }

    /*public static String getUserId() {
        HttpSession session = getSession();
        if (session != null) {
            return (String) session.getAttribute("login");
        } else {
            return null;
        }
    }

    public static Date formatDateString(String fecha) throws ParseException {
        SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
        return formatter.parse(fecha);
    }*/

    public static Date formatStringToDate(String fecha) throws ParseException {
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        return formatter.parse(fecha);
    }

    public static String formatoFecha(Date fecha) {
        String DATE_FORMAT = "dd/MM/yyyy";
        SimpleDateFormat sdf = new SimpleDateFormat(DATE_FORMAT);
        return sdf.format(fecha);
    }

    /*public static String formatFechaOracle(Date fecha) {
        String DATE_FORMAT = "yyyy-MM-dd";
        SimpleDateFormat sdf = new SimpleDateFormat(DATE_FORMAT);
        return sdf.format(fecha);
    }

    public static String formatoFecha2(Date fecha) {
        String DATE_FORMAT = "yyyyMMdd";
        SimpleDateFormat sdf = new SimpleDateFormat(DATE_FORMAT);
        return sdf.format(fecha);
    }*/

    public static String formatFechaOracleTime(Date fecha) {
        String DATE_FORMAT = "yyyy-MM-dd HH:mm:ss";
        SimpleDateFormat sdf = new SimpleDateFormat(DATE_FORMAT);
        return sdf.format(fecha);

    }

    public static void addError(String summary, String detail) {
        FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR,
                summary, detail));
    }

    public static void addMessage(String summary, String detail) {
        FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_INFO,
                summary, detail));
    }

    public static boolean nitValidator(String nit) {
        boolean valid;
        try {
            if (nit.substring(0, 1).equals("9")) {
                // addError("VERIFIQUE LA VIGENCIA DEL CARNET DE RESIDENTE, ESTA DEBE SER MAYOR A 3 MESES","");
                valid = true;
            } else valid = Integer.parseInt(nit.substring(0, 2)) <= 14 && Integer.parseInt(nit.substring(0, 2)) > 0;
        } catch (NumberFormatException e) {
            valid = false;
        }
        return valid;
    }

    public static int portServer() {
        HttpServletRequest request = ViewUtils.getRequest();
        return request.getServerPort();
    }

    public static ServletContext getServletContext() {
        ServletContext servletContext = (ServletContext) FacesContext.getCurrentInstance().getExternalContext().getContext();
        ServletContext sc = servletContext;
        return sc;
    }

    /*public static void doEjecutaReporte(String reporte, Map parametrosReporte, String formato) throws IOException {
        Map map = ViewUtils.getServletMap();
        HttpServletRequest request = (HttpServletRequest) map.get("request");

        try {
            Hashtable parametrosEjecucion = new Hashtable();
            parametrosEjecucion.put("reportOutType", formato);
            parametrosEjecucion.put("reportName", reporte);
            parametrosEjecucion.put("reportParams", parametrosReporte);
            request.getSession().setAttribute("reportparams", parametrosEjecucion);
            request.getSession().setAttribute("reportparams", parametrosEjecucion);
        } catch (Exception ex) {
            ex.printStackTrace();
            ViewUtils.addExceptionMessage(ex);
            throw ex;
        }
    }*/

    public static String getUrl() {
        String url;
        HttpServletRequest req = getRequest();
        if (req.getServerName().contains("sertracen.com.sv")) {
            url = "https://" + req.getServerName() + req.getContextPath();
        } else {
            url = req.getScheme() + "://" + req.getServerName() + ":" + req.getServerPort() + req.getContextPath();
        }
        return url;
    }

    public static void showMessageInfo(String s) {
        FacesMessage message = new FacesMessage(FacesMessage.SEVERITY_INFO, "Mensaje", s);
        PrimeFaces.current().dialog().showMessageDynamic(message);
    }

    public static void showMessageWarning(String s) {
        FacesMessage message = new FacesMessage(FacesMessage.SEVERITY_WARN, "Mensaje", s);
        PrimeFaces.current().dialog().showMessageDynamic(message);
    }

    public static void showMessageError(String s) {
        FacesMessage message = new FacesMessage(FacesMessage.SEVERITY_ERROR, "Mensaje", s);
        PrimeFaces.current().dialog().showMessageDynamic(message);
    }

    public static String formatoFechaTime(Date fecha) {
        String DATE_FORMAT = "dd/MM/yyyy HH:mm";
        SimpleDateFormat sdf = new SimpleDateFormat(DATE_FORMAT);
        return sdf.format(fecha);
    }

    public static List<SelectItem> listSelectItem(List<?> list, String labelField, String valueField,
            boolean selectOne) {
        List<SelectItem> lista = new ArrayList<>(0);
        if (selectOne) {
            SelectItem item = new SelectItem();
            item.setValue("");
            item.setLabel("[ SELECCIONAR ]");
            lista.add(item);
        }
        for (Object element : list) {
            SelectItem item = new SelectItem();
            Object label = getPropertyFromInstance(element, labelField);
            Object value = getPropertyFromInstance(element, valueField);
            if (label != null) {
                if (label instanceof String) {
                    item.setLabel((String) label);
                    item.setDescription((String) label);
                } else {
                    item.setLabel(String.valueOf(label));
                    item.setDescription(String.valueOf(label));
                }
            }
            if (value != null) {
                item.setValue(value);
            }
            lista.add(item);
        }
        return lista;
    }

    public static Object getPropertyFromInstance(Object instance, String name) {
        Object salida = null;
        try {
            Class[] classes = null;
            Method method = instance.getClass().getMethod(generateGetterName(name), classes);
            Object[] objects = null;
            salida = method.invoke(instance, objects);
        } catch (IllegalAccessException | IllegalArgumentException | NoSuchMethodException | SecurityException | InvocationTargetException ex) {
            ex.printStackTrace();
        }
        return salida;
    }

    public static String generateGetterName(String name) {
        String beanName = name;
        String correctedName = "get" + beanName.substring(0, 1).toUpperCase() + beanName.substring(1);
        return correctedName;
    }

    /*public static Timestamp stringToTimestampMySQL(String dateStr) {
        Timestamp timestamp = null;
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date parsedDate = sdf.parse(dateStr);
            timestamp = new java.sql.Timestamp(parsedDate.getTime());
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return timestamp;
    }*/

    public static String formatDateTimeToString(Date date) {
        SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");
        return sdf.format(date);
    }
}