@isTest public class TestTimesheetTrigger {

    @isTest static void TestInsertTimesheetWithSubmitTrue() {
       
        Timesheet__c[] times = TestFactoryTimesheet.insertTimesheetsForTrigger(1,true);
       
        Test.startTest();
        Database.SaveResult result = Database.insert(times[0]);
        Test.stopTest();

        
        System.assert(result.isSuccess());
    }
    
    @isTest static void TestInsertTimesheetWithSubmitFalse() {
       
        Timesheet__c[] times = TestFactoryTimesheet.insertTimesheetsForTrigger(1,false);
       
        Test.startTest();
        Database.SaveResult result = Database.insert(times[0]);
        Test.stopTest();

        
        System.assert(result.isSuccess());
    } 
    
    @isTest static void TestInsertTimesheetWithSubmitTrueBulk() {
       
        Timesheet__c[] times = TestFactoryTimesheet.insertTimesheetsForTrigger(200,true);
       
        Test.startTest();
        Database.SaveResult[] result = Database.insert(times);
        Test.stopTest();

        for(Database.SaveResult ds:result){
            System.assert(ds.isSuccess());
        }
        
    }
    
    @isTest static void TestDeleteTimesheetWithSubmitTrue() {
       
        Timesheet__c[] times = TestFactoryTimesheet.insertTimesheetsForTrigger(1,true);
        insert times;
        
        Test.startTest();
        Database.DeleteResult result = Database.delete(times[0],false);
        Test.stopTest();

        
        System.assert(!result.isSuccess());
        System.assert(result.getErrors().size() > 0);
        System.assertEquals('Timesheet Status is SUBMITTED, it can not be deleted or edited',
                                 result.getErrors()[0].getMessage());
    } 
    
    @isTest static void TestDeleteTimesheetWithSubmitFalse() {
       
        Timesheet__c[] times = TestFactoryTimesheet.insertTimesheetsForTrigger(1,false);
        insert times;
        
        Test.startTest();
        Database.DeleteResult result = Database.delete(times[0],false);
        Test.stopTest();

        System.assert(result.isSuccess());

    }  
    
    @isTest static void TestDeleteTimesheetWithSubmitTrueBulk() {
       
        Timesheet__c[] times = TestFactoryTimesheet.insertTimesheetsForTrigger(200,true);
        insert times;
        
        Test.startTest();
        Database.DeleteResult[] result = Database.delete(times,false);
        Test.stopTest();

        for(Database.DeleteResult dr:result){
            System.assert(!dr.isSuccess());
        	System.assert(dr.getErrors().size() > 0);
        	System.assertEquals('Timesheet Status is SUBMITTED, it can not be deleted or edited',
                                 dr.getErrors()[0].getMessage());
        }
        
    } 
    @isTest static void TestUpdateTimesheetWithSubmitTrue() {
       
        Timesheet__c[] times = TestFactoryTimesheet.insertTimesheetsForTrigger(1,true);
        insert times;
        
        Test.startTest();
        for(Timesheet__c c:times){
            c.Monday__c = 23;
        }
        Database.SaveResult result = Database.update(times[0],false);
        Test.stopTest();

        
        System.assert(!result.isSuccess());
        System.assert(result.getErrors().size() > 0);
        System.assertEquals('Timesheet Status is SUBMITTED, it can not be deleted or edited',
                                 result.getErrors()[0].getMessage());
    }   
    
     @isTest static void TestUpdateTimesheetWithSubmitFalse() {
       
        Timesheet__c[] times = TestFactoryTimesheet.insertTimesheetsForTrigger(1,false);
        insert times;
        
        Test.startTest();
        for(Timesheet__c c:times){
            c.Submmited__c = true;
        }
        Database.SaveResult result = Database.update(times[0],false);
        Test.stopTest();

        
        System.assert(result.isSuccess());
    } 
    
    @isTest static void TestUpdateTimesheetWithSubmitTrueBulk() {
       
        Timesheet__c[] times = TestFactoryTimesheet.insertTimesheetsForTrigger(200,true);
        insert times;
        
        Test.startTest();
        for(Timesheet__c c:times){
            c.Monday__c = 23;
        }
        Database.SaveResult[] result = Database.update(times,false);
        Test.stopTest();

        for(Database.SaveResult sr: result){
            System.assert(!sr.isSuccess());
            System.assert(sr.getErrors().size() > 0);
            System.assertEquals('Timesheet Status is SUBMITTED, it can not be deleted or edited',
                                 sr.getErrors()[0].getMessage());
        }
        
    }   
}