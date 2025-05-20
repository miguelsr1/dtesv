package sv.com.jsoft.stdte.utils;

import java.beans.BeanInfo;
import java.beans.IntrospectionException;
import java.beans.Introspector;
import java.beans.PropertyDescriptor;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;

public class ModelUtils {

    public static final String RESOURCE = "ModelResources";
    private static ResourceBundle resources;
    public ModelUtils() {
    }

    public static void log(Throwable x) {
        Logger.getAnonymousLogger().log(Level.SEVERE, x.getMessage(), x);
    }

    public static synchronized ResourceBundle getResources() {
        if (resources == null) {
            try {
                resources = ResourceBundle.getBundle(RESOURCE);
            } catch (Exception ex) {
                log(ex);
                throw new InternalError(ex.getMessage());
            }
        }
        return resources;
    }

    public static String getResource(String key) {
        return getResources().getString(key);
    }

    public static void copy(Object source, Object dest) {
        try {
            Class sourceClass = source.getClass();
            Class destClass = dest.getClass();
            BeanInfo info = Introspector.getBeanInfo(sourceClass);
            PropertyDescriptor props[] = info.getPropertyDescriptors();
            Object noParams[] = new Object[0]; //getters?
            Object oneParam[] = new Object[1]; //setters?
            for (int i = 0; i < props.length; i++) {
                /*iterando sobre las propiedades*/
                Method getter = props[i].getReadMethod();
                if (getter == null) {
                    continue;
                }
                Object value = getter.invoke(source, noParams);
                Method setter = props[i].getWriteMethod();
                if (setter != null && sourceClass != destClass) {
                    try {
                        setter
                                = destClass.getMethod(setter.getName(), setter.getParameterTypes());
                    } catch (NoSuchMethodException x) {
                        setter = null;
                    }
                }
                if (setter != null) {
                    oneParam[0] = value;
                    setter.invoke(dest, oneParam);
                }
            }
        } catch (IntrospectionException x) {
            log(x);
            throw new InternalError(x.getMessage());
        } catch (IllegalAccessException x) {
            log(x);
            throw new InternalError(x.getMessage());
        } catch (IllegalArgumentException x) {
            log(x);
            throw new InternalError(x.getMessage());
        } catch (SecurityException x) {
            log(x);
            throw new InternalError(x.getMessage());
        } catch (InvocationTargetException x) {
            log(x.getTargetException());
            throw new InternalError(x.getTargetException().getMessage());
        }
    }

}
