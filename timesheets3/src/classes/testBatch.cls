@isTest
public class testBatch {

    @isTest static void testingBach(){
        Test.startTest();
        batchUpdateTimesheets bt = new batchUpdateTimesheets();
        database.executebatch(bt);
        Test.stopTest();
    }
}