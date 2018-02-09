global class batchUpdateTimesheets implements Database.Batchable<sObject>{

    global Database.QueryLocator start(Database.BatchableContext BC){
		TestFactoryTimesheet.createTimesheetsForAutomaticSubmit(6,2,'NOT SUBMITTED',99);
        String query = 'SELECT Id FROM Timesheet__c WHERE Timesheet_Status__c = \'NOT SUBMITTED\' AND Gross_Pay__c > 5000';
        return Database.getQueryLocator(query);  
    }    
    global void execute(Database.BatchableContext BC, List<Timesheet__c> scope){        
        for(Timesheet__c t: scope){
            t.Submmited__c = true;
        }     
        System.debug(scope);
        update scope;       
    }    
    global void finish(Database.BatchableContext BC) {    }
}