({
	doInit : function(component, event, helper) {
         component.set("v.recordAvailable",true);
		var recId = component.get("v.accId");
        if(recId != ''){
           
                    console.log('111recId--'+recId);

        }else{
            component.set("v.recordAvailable",false);
        }
	}
})