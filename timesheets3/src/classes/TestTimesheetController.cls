@isTest
public class TestTimesheetController {

    @isTest static void InvalidAccess(){
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
        User u1 = new User(Alias = 'standt1',Country='United Kingdom',Email='demo1@randomdemodomain.com',EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',LocaleSidKey='en_US',ProfileId = p.Id,TimeZoneSidKey='America/Los_Angeles', UserName='dprobertdemo1@camfed.org');
        insert u1;

       System.runAs(u1){
			List<Timesheet__c> t = timesheetsController.getTimesheets('true');
        	System.assertEquals(null, t);
        }  
    }
    
    @isTest static void getAllTimesheetsWithoutOrder(){
        TestFactoryTimesheet.createTimesheetsForTable(6, 2, Date.newInstance(2017, 01, 01));
        
        List<Timesheet__c> t = timesheetsController.getTimesheets('true');
        
        System.debug('Estoy con parametro en true y  la lista es de: ' + t.size());
        System.assertEquals([SELECT Id, Name,Employee__r.Name,Employee__r.Birthdate, Start_Date__c, End_Date__c, 
            	Total_Hours__c, Gross_Pay__c,Taxes__c,Type__c,Submmited__c
                FROM Timesheet__c], t);
    }
    
    @isTest static void getAllTimesheetsOrderByStartDate(){
        TestFactoryTimesheet.createTimesheetsForTable(6, 2, Date.newInstance(2017, 01, 01));
        
        List<Timesheet__c> t = timesheetsController.getTimesheets('sadasdhjs');
        
        Map<String,String> namesMap = new Map<String,String>();
        Boolean status= true;
        
        System.debug('Estoy con parametro para el else y el tamaño lista es: ' + t.size());
        
        for(Timesheet__c tim: t){
            if(!namesMap.containsKey(String.valueOf(tim.get('Employee__c')))){
                        namesMap.put(String.valueOf(tim.get('Employee__c')),String.valueOf(tim.get('Employee__c')));
                System.debug('Entre al FOR e itere sobre el registro: ' + tim);
                    }
            else{
                status=false;
            }
        }
        
        System.assertEquals(true, status);
    }
}