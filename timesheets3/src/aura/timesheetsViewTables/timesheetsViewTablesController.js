({
    init: function (cmp, event, helper) {
       
        helper.doCallback(cmp,event,function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                cmp.set("v.timesheets", response.getReturnValue());
                console.log(cmp.get("v.timesheets"));
            }
            else {
                console.log("Failed with state: " + state);
            }
        });
    },
    
    changeView: function(component, event, helper) {
        console.log(event.getSource("selectedItem"));
        component.set("v.view",event.getSource("selectedItem").get("v.value"));
        helper.reload(component, event, helper);
    },
    
    edit: function(component, event, helper) {
    var editRecordEvent = $A.get("e.force:editRecord");
    editRecordEvent.setParams({
         "recordId": event.target.id
   });
    editRecordEvent.fire();
},
    
    viewRefreshed: function(component, event, helper) {
        console.log('estoy llamando al helper');
    	helper.reload(component, event, helper);
	},
    
    addOrRemove: function(component, event, helper) {
   
        var timeS = event.getSource("checkSubm").get("v.value");
        
        if(event.getSource("checkSubm").get("v.checked") == true)
            helper.addTimesheet(component,event,timeS);
        else
            helper.removeTimesheet(component,event,timeS);
        
	},
    
    setAsSubmitted: function (component, event, helper) {
        helper.updateTimesheets(component, event);
	},
    
})