public class automaticSubmit implements Schedulable{

    public void execute(SchedulableContext ctx){
  
        batchUpdateTimesheets bt = new batchUpdateTimesheets();
        database.executebatch(bt);
    
    }
}