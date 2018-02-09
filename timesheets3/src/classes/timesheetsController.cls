public with sharing class timesheetsController {

            @AuraEnabled
    public static List<Timesheet__c> getTimesheets(String view) {
        
        String[] fieldsToCheck = new String[] {
            'Id','Name', 'Employee__c', 'Start_Date__c', 'End_Date__c', 
            'Total_Hours__c', 'Gross_Pay__c','Taxes__c','Type__c','Submmited__c'
        };
        
        Map<String,Schema.SObjectField> fieldDescribeTokens = 
            Schema.SObjectType.Timesheet__c.fields.getMap();
        
        for(String field : fieldsToCheck) {
            if( ! fieldDescribeTokens.get(field).getDescribe().isAccessible()) {
                //throw new System.NoAccessException();
                return null;
            }
        }
        
        System.debug('Estoy en el controlador');
        
        List<Timesheet__c> timesheets = new List<Timesheet__c>();
        String toQuery = 'SELECT Id, Name,Employee__r.Name,Employee__r.Birthdate, Start_Date__c, End_Date__c,'+ 
            	'Total_Hours__c, Gross_Pay__c,Taxes__c,Type__c,Submmited__c'+
                ' FROM Timesheet__c';
    
        if(view == '1'){
            return timesheets = (List<Timesheet__c>)Database.query(toQuery);
        }else if(view == '2'){
           
            Map<String,String> namesMap = new Map<String,String>();
    
            for(Timesheet__c ar: (List<Timesheet__c>)Database.query(toQuery + ' ORDER BY Start_Date__c desc')) {
                	
                    System.debug(ar.get('Employee__c'));
                    if(!namesMap.containsKey(String.valueOf(ar.get('Employee__c')))){
                        timesheets.add(ar);
                        namesMap.put(String.valueOf(ar.get('Employee__c')),String.valueOf(ar.get('Employee__c')));
                        System.debug('Agregue: ' + ar.get('Employee__c'));
                    }        
			}
            
            return timesheets;
        }else if(view == '3'){
            return timesheets = Database.query(toQuery + ' WHERE Submmited__c = true');
        }else if(view == '4'){
            return timesheets = Database.query(toQuery + ' WHERE Submmited__c = false');
        }else{
            return null;
        }
        
    }
   
    @AuraEnabled
    public static void saveUpdates(List<Timesheet__c> timesheets){
        for(Timesheet__c t:timesheets){
            t.Submmited__c = true;
        }
        update timesheets;
    }
}