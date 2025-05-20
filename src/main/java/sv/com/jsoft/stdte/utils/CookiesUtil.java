package sv.com.jsoft.stdte.utils;

import javax.servlet.ServletContext;

public class CookiesUtil {

    public static void addSessionAttribute(String id,Object obj){
        ViewUtils.addSessionAttribute(id, obj);
    }

    public static ServletContext getServletContext() {
        return ViewUtils.getServletContext();
    }
            
}
