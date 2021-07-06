({
	doInit : function(component, event, helper) {
		var action = component.get('c.fetchAccounts');
        action.setCallback(this,function(response){
        var state=response.getState();
        if(state === 'SUCCESS'){
            component.set('v.accountList',response.getReturnValue());
        }
	});
        $A.enqueueAction(action);
},
    getContactForAccount : function(component,event,helper){
       var accountId = component.get('v.selectedAccountId');
        var action = component.get('c.fetchContacts');
        action.setParams({"accountApexId" : accountId});
         action.setCallback(this,function(response){
        var state=response.getState();
        if(state === 'SUCCESS'){
            component.set('v.contactList',response.getReturnValue());
        }
	});
		$A.enqueueAction(action);
    },
    
    myFunc : function(component,event,helper){
       
        var isEmpty = $A.util.isEmpty(component.get('v.label'));
        var inputValue = component.find('userInput').get('v.value');
         console.log('item--'+inputValue);
        component.set('v.label',inputValue);
    }
})