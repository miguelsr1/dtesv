package sv.com.jsoft.stdte.db;

import javax.annotation.Resource;
import javax.enterprise.context.ApplicationScoped;
import javax.sql.DataSource;

@ApplicationScoped
public class DataSourceApp {

    @Resource(lookup = "java:/FactDS")
    private DataSource facDs;

    public DataSource getFacDs(){
        return facDs;
    }

}
