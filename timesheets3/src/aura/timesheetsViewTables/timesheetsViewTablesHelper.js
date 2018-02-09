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
    },
    
    addTimesheet: function (cmp, event, timeS){
        
        var listTimesheets = cmp.get("v.checked");
        var sizeList = cmp.get("v.checkedSize");
        
        listTimesheets.push(timeS);
        cmp.set("v.checked",listTimesheets);
        cmp.set("v.checkedSize",sizeList+1);
                
        console.log(cmp.get("v.checked"));
      
    },
    
    removeTimesheet: function (cmp, event, timeS){
        
        var listTimesheets = cmp.get("v.checked");
        var sizeList = cmp.get("v.checkedSize");
        
        listTimesheets.pop(timeS);
        cmp.set("v.checked",listTimesheets);
        cmp.set("v.checkedSize",sizeList-1);
        
        console.log(cmp.get("v.checked"));
    },
    
    updateTimesheets: function (cmp, event){
        
        console.log('Estoy en el Update helper');
        console.log('Esta es la lista que voy a pasar: '+ cmp.get("v.checked"));
        var action = cmp.get("c.saveUpdates");
        action.setParams({
            "timesheets": cmp.get("v.checked")
        });
        console.log('Llegue al callback');
        action.setCallback(this,function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                console.log('Success del callback');
                var clean = [];
                cmp.set("v.checked", clean);
                cmp.set("v.checkedSize",0);
                console.log('Limpie checked: ' + cmp.get("v.checked"));
                this.reload(cmp,event,this);
            }
            else {
                console.log("Failed with state: " + state);
            }
		});
        
        	$A.enqueueAction(action);
        },
})