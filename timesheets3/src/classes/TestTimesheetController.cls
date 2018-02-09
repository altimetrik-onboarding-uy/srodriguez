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
        TestFactoryTimesheet.createTimesheetsForTable(6, 2, Date.newInstance(2017, 01, 01),false);
        
        List<Timesheet__c> t = timesheetsController.getTimesheets('1');
        
        System.debug('Estoy con parametro en 1 y  la lista es de: ' + t.size());
        System.assertEquals([SELECT Id, Name,Employee__r.Name,Employee__r.Birthdate, Start_Date__c, End_Date__c, 
            	Total_Hours__c, Gross_Pay__c,Taxes__c,Type__c,Submmited__c
                FROM Timesheet__c], t);
    }
    
    @isTest static void getAllTimesheetsOrderByStartDate(){
        TestFactoryTimesheet.createTimesheetsForTable(6, 2, Date.newInstance(2017, 01, 01),false);
        
        List<Timesheet__c> t = timesheetsController.getTimesheets('2');
        
        Map<String,String> namesMap = new Map<String,String>();
        Boolean status= true;
        
        System.debug('Estoy con parametro en 2 y el tamaño lista es: ' + t.size());
        
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
    
    @isTest static void getAllTimesheetsSubmited(){
        TestFactoryTimesheet.createTimesheetsForTable(6, 1, Date.newInstance(2017, 01, 01),true);
        
        List<Timesheet__c> t = timesheetsController.getTimesheets('3');
        
        System.debug('Estoy con parametro en 3 y  la lista es de: ' + t.size());
        System.assertEquals([SELECT Id, Name,Employee__r.Name,Employee__r.Birthdate, Start_Date__c, End_Date__c, 
            	Total_Hours__c, Gross_Pay__c,Taxes__c,Type__c,Submmited__c
                FROM Timesheet__c WHERE Submmited__c = true], t);
    }
    
    @isTest static void getAllTimesheetsNoSubmitted(){
        TestFactoryTimesheet.createTimesheetsForTable(6, 1, Date.newInstance(2017, 01, 01),false);
        
        List<Timesheet__c> t = timesheetsController.getTimesheets('4');
        
        System.debug('Estoy con parametro en 4 y  la lista es de: ' + t.size());
        System.assertEquals([SELECT Id, Name,Employee__r.Name,Employee__r.Birthdate, Start_Date__c, End_Date__c, 
            	Total_Hours__c, Gross_Pay__c,Taxes__c,Type__c,Submmited__c
                FROM Timesheet__c WHERE Submmited__c = false], t);
    }
    
    @isTest static void getAllTimesheetsForOtherParameter(){
        TestFactoryTimesheet.createTimesheetsForTable(6, 1, Date.newInstance(2017, 01, 01),false);
        
        List<Timesheet__c> t = timesheetsController.getTimesheets('dsajdas');
        
        System.debug('Estoy con otro parametro no esperado por el sistema');
        System.assertEquals(null, t);
    }
    
    @isTest static void updateTimesheets(){
        TestFactoryTimesheet.createTimesheetsForTable(6, 3, Date.newInstance(2017, 01, 01),false);
        
        List<Timesheet__c> t = timesheetsController.getTimesheets('1');
        
        timesheetsController.saveUpdates(t);
        
        //System.debug('Estoy con otro parametro no esperado por el sistema');
        System.assertEquals([SELECT Id, Name,Employee__r.Name,Employee__r.Birthdate, Start_Date__c, End_Date__c, 
            	Total_Hours__c, Gross_Pay__c,Taxes__c,Type__c,Submmited__c
                FROM Timesheet__c WHERE Submmited__c = true], 
                            [SELECT Id, Name,Employee__r.Name,Employee__r.Birthdate, Start_Date__c, End_Date__c, 
            	Total_Hours__c, Gross_Pay__c,Taxes__c,Type__c,Submmited__c
                                                               FROM Timesheet__c]);
    }
}