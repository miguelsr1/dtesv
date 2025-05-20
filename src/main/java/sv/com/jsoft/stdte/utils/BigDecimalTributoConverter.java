package sv.com.jsoft.stdte.utils;

import javax.faces.component.UIComponent;
import javax.faces.context.FacesContext;
import javax.faces.convert.Converter;
import javax.faces.convert.FacesConverter;
import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;

@FacesConverter("biDecimalTributoConverter")
public class BigDecimalTributoConverter implements Converter {

    @Override
    public Object getAsObject(FacesContext context, UIComponent component, String value) {
        Object ob = null;

        return ob;
    }

    @Override
    public String getAsString(FacesContext context, UIComponent component, Object value) {
        double v = Double.parseDouble(value.toString());
        DecimalFormat df = (DecimalFormat) DecimalFormat.getCurrencyInstance();
        DecimalFormatSymbols dfs = new DecimalFormatSymbols();
        dfs.setCurrencySymbol("$ ");
        dfs.setMonetaryDecimalSeparator('.');
        dfs.setGroupingSeparator(',');
        df.setDecimalFormatSymbols(dfs);
        df.setMinimumFractionDigits(5);
        return df.format(v);
    }
}
