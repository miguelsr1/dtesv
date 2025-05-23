package sv.com.jsoft.stdte.view;

import org.apache.log4j.Logger;
import sv.com.jsoft.stdte.ejb.CronFinMes;
import sv.com.jsoft.stdte.ejb.CronsEjb;
import sv.com.jsoft.stdte.utils.ViewUtils;

import javax.inject.Inject;
import javax.inject.Named;
import java.io.Serializable;

@Named("cronBean")
public class ExecuteTaskManually implements Serializable {

    protected final static Logger logger = Logger.getLogger(ExecuteTaskManually.class);

    @Inject
    CronsEjb cronsEjb;


    CronFinMes cronFinMes;

    public void triggerScheduleTask(String option){
        logger.info("Ejecución manual de proceso "
                + (option.matches("D") ? "facturación diaria":"facturación mensual"));
        switch (option){
             case "D":
                 try {
                     cronsEjb.triggerScheduleTask();
                     ViewUtils.addMessage(null, "Proceso finalizado correctamente");
                     logger.info("proceso finalizó correctamente");
                 }catch (Exception e){
                     ViewUtils.addError(null, "Ocurrió un error: " + e.getCause());
                     logger.error("ocurrió un error: " + e.getMessage());
                 }
                break;
            case "M":
                try {
                    cronFinMes.triggerScheduleTask();
                    ViewUtils.addMessage(null, "Proceso finalizado correctamente");
                    logger.info("proceso finalizó correctamente");
                }catch (Exception e){
                    ViewUtils.addError(null, "Ocurrió un error: " + e.getCause());
                    logger.error("ocurrió un error: " + e.getMessage());
                }
                break;

        }
    }
}
