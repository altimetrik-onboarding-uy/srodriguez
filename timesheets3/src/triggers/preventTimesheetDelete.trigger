trigger preventTimesheetDelete on Timesheet__c (before update,before delete,before insert) {
	
     
    if(Trigger.isDelete){
    for(Timesheet__c timesheet: Trigger.old){
        if(timesheet.Submmited__c == true){
            timesheet.addError('Timesheet Status is SUBMITTED, it can not be ' +
                       'deleted or edited');
        	}
    	}
    }else if(Trigger.IsInsert){
        for(Timesheet__c x: Trigger.New){
        if(x.Submmited__c == true)
            x.Timesheet_Status__c = 'SUBMITTED';
    	}
    }else if(Trigger.isUpdate){
        for(Timesheet__c x: Trigger.New){
        if(Trigger.oldMap.get(x.Id).Submmited__c == true)
            x.addError('Timesheet Status is SUBMITTED, it can not be ' +
                       'deleted or edited');
        else if(x.Submmited__c == true)
           	x.Timesheet_Status__c = 'SUBMITTED';
            
    	}
    }
}