@ isTest public class TestFactoryTimesheet {

    public static void createTimesheetsForTable(Integer howManyContacts,Integer howManyTimesheetXContact, Date firstDate,
                                               Boolean submitted) {
        //this method increments automatically firsDate param by 2 for each timesheet by contact
        
        
        List<Contact> cnt = new List<Contact>();
        
        for(Integer i=0;i<howManyContacts;i++) {
            Contact c = new Contact(FirstName='TestContactName'+ i, LastName='TestContactLastName' + i);
            cnt.add(c);
        }
        insert cnt;
        
        List<Timesheet__c> times = new List<Timesheet__c>();
        
        for (Integer j=0;j<howManyContacts;j++) {
            Contact cn = cnt[j];
            Integer days = 0;
            for (Integer k=0;k<howManyTimesheetXContact;k++) {
                times.add(new Timesheet__c(Employee__c=cn.Id,
                                           Start_Date__c=firstDate.addDays(days),
                                           Submmited__c = submitted));
                days=days+2;
            }
        }
   
        insert times;
        
    }
    
    public static List<Timesheet__c> insertTimesheetsForTrigger(Integer howManyTimesheet, Boolean submit) {
           
                
        Contact c = new Contact(FirstName='TestContactName', LastName='TestContactLastName');
		insert c;
        
        List<Timesheet__c> times = new List<Timesheet__c>();
        
        
        for (Integer i=0;i<howManyTimesheet;i++) {
            times.add(new Timesheet__c(Employee__c=c.Id,
                                       Submmited__c=submit));
        }
        
        //insert times;
        return times;
        
    }
    
    public static void createTimesheetsForAutomaticSubmit(Integer howManyContacts,Integer howManyTimesheetXContact,
                                                          String status, Integer rate){
                                                    
        List<Contact> cnt = new List<Contact>();
        
        for(Integer i=0;i<howManyContacts;i++) {
            Contact c = new Contact(FirstName='TestContactName'+ i, LastName='TestContactLastName' + i);
            cnt.add(c);
        }
        insert cnt;
        
        List<Timesheet__c> times = new List<Timesheet__c>();
        
        for (Integer j=0;j<howManyContacts;j++) {
            Contact cn = cnt[j];
            for (Integer k=0;k<howManyTimesheetXContact;k++) {
                times.add(new Timesheet__c(Employee__c=cn.Id,
                                           Timesheet_Status__c = status,
                                           Monday__c = 12,
                                           Tuesday__c = 12,
                                           Wednesday__c = 12,
                                           Thuesday__c = 12,
                                           Friday__c = 12,
                                           Hour_rate__c = rate));
            }
        }

        insert times;
    }
    
}