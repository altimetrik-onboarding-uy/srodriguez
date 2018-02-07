({
    
	    reload: function (cmp, event, helper) {
        
            console.log('Estoy en el Reload');
            this.doCallback(cmp,event, function(response) {
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
    
    doCallback: function (cmp, event, callback){
        
        console.log(cmp.get("v.view"));
        var action = cmp.get("c.getTimesheets");
        action.setParams({
            "view": cmp.get("v.view")
        });
        
        if (callback) {
            action.setCallback(this, callback);
        }
        $A.enqueueAction(action);
    }
})