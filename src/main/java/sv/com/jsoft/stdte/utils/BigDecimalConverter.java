package sv.com.jsoft.stdte.utils;

import javax.faces.component.UIComponent;
import javax.faces.context.FacesContext;
import javax.faces.convert.Converter;
import javax.faces.convert.FacesConverter;
import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.text.ParseException;

@FacesConverter("bigDecimalConverter")
public class BigDecimalConverter implements Converter {


    @Override
    public Object getAsObject(FacesContext context, UIComponent component, String value) {
        Object ob = null;

        try {
            DecimalFormat df = new DecimalFormat();
            DecimalFormatSymbols dfs = new DecimalFormatSymbols();
            dfs.setDecimalSeparator('.');
            dfs.setGroupingSeparator(',');
            df.setDecimalFormatSymbols(dfs);
            df.setParseBigDecimal(true);

            // Remove the currency symbol if present
            String cleanValue = value.replace("$", "").trim();
            return df.parse(cleanValue);
        } catch (ParseException e) {
            throw new IllegalArgumentException("Error converting [" + value + "] to a decimal value;", e);
        }
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
        df.setMinimumFractionDigits(2);
        df.setMaximumFractionDigits(2);
        df.setGroupingUsed(true);
        return df.format(v);
    }
}
