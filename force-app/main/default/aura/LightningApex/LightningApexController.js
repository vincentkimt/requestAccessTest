({
	handleClick : function(component, event, helper) {
        console.log("I am  In");
		var action=component.get("c.fetchAccounts");
        
        action.setCallback(this, function(response){
            var state =response.getState();
            if(component.isValid() && state === "SUCCESS"){
                component.set("v.accts", response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
	}
})