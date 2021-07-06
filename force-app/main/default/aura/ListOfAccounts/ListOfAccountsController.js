({
	doInit : function(component, event, helper) {
		
        var action=component.get("c.getAccounts");

        action.setCallback(this,function(response){
            var state=response.getState();
            if(state==="SUCCESS"){
                component.set("v.accountsList",response.getReturnValue());
            }
        })
        
       $A.enqueueAction(action);
	},
    
    handleDetails : function(component, event, helper){
        $A.createComponent("c:AccountDetails",
                           {"accId":event.getSource().get("v.value").trim(),
                            "recordAvailable" : true},function(modalComponent, status, errorMessage){
             if (status === "SUCCESS") {
         		console.log('body=-='+modalComponent+'--stat--'+status);
                    //Appending the newly created component in div
                    var body = component.find( 'showChildModal' ).get("v.body");
                    body.push(modalComponent);
                    component.find( 'showChildModal' ).set("v.body", body);
                 component.set("v.retString",status);
                }
                else if (status === "INCOMPLETE") {
                   console.log('incmplt');
                }
                else if (status === "ERROR") {
                    console.log('err');
                }
        });
    }
})