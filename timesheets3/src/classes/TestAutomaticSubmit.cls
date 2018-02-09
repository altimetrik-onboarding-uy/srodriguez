@isTest
public class TestAutomaticSubmit {

    @isTest static void submitTimesheetsAutomatically(){
        
        TestFactoryTimesheet.createTimesheetsForAutomaticSubmit(6,2,'NOT SUBMITTED',99);
        
        Test.startTest();
		automaticSubmit sh1 = new automaticSubmit();
		String sch = '0 0 12 * * ?';
		String jobId = system.schedule('Submit Check', sch, sh1);
		Test.stopTest();
        
        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE id = :jobId];
        System.assertEquals(sch, ct.CronExpression);
        System.assertEquals(0, ct.TimesTriggered);
        
    }
}