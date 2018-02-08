({
    init: function (cmp, event, helper) {
       
        helper.doCallback(cmp,event,function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                cmp.set("v.timesheets", response.getReturnValue());
                console.log(response.getReturnValue());
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
    
})