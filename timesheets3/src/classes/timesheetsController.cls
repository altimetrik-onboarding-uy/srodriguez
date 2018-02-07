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
        
        if(view == '1'){
            return [SELECT Id, Name,Employee__r.Name,Employee__r.Birthdate, Start_Date__c, End_Date__c, 
            	Total_Hours__c, Gross_Pay__c,Taxes__c,Type__c,Submmited__c
                FROM Timesheet__c];
        }else if(view == '2'){
            List<Timesheet__c> times = new List<Timesheet__c>();
           
            Map<String,String> namesMap = new Map<String,String>();
    
            for(Timesheet__c ar: [SELECT Id, Name, Employee__r.Name,Employee__r.Birthdate, Start_Date__c, End_Date__c, 
            	Total_Hours__c, Gross_Pay__c,Taxes__c,Type__c,Submmited__c
                FROM Timesheet__c ORDER BY Start_Date__c desc]) {
                	
                    System.debug(ar.get('Employee__c'));
                    if(!namesMap.containsKey(String.valueOf(ar.get('Employee__c')))){
                        System.debug('Agregue: ' + ar.get('Employee__c'));
                        times.add(ar);
                        namesMap.put(String.valueOf(ar.get('Employee__c')),String.valueOf(ar.get('Employee__c')));
                    }        
			}
            
            return times;
        }else if(view == '3'){
            return [SELECT Id, Name,Employee__r.Name,Employee__r.Birthdate, Start_Date__c, End_Date__c, 
            	Total_Hours__c, Gross_Pay__c,Taxes__c,Type__c,Submmited__c
                FROM Timesheet__c WHERE Submmited__c = true];
        }else{
            return [SELECT Id, Name,Employee__r.Name,Employee__r.Birthdate, Start_Date__c, End_Date__c, 
            	Total_Hours__c, Gross_Pay__c,Taxes__c,Type__c,Submmited__c
                FROM Timesheet__c WHERE Submmited__c = false];
        }
        
    }
}