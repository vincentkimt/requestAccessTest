({
    helperInit : function(component,event,helper) {
        
        var action = component.get('c.fetchContacts');
        action.setParams({recordId : component.get('v.recordId')});
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set('v.wrapperList', response.getReturnValue());
  				console.log('success from the First apex call');

                
            }else{
            }
        });
        
        ///////////NOTHING,JUST CHECKING THAT One JS Method can Contain two action.setCallback and $A.enqueAction(action)//////////
        
        var action1 = component.get('c.justExecuteSomething');
        action1.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                console.log('success from the second apex call');
                console.log('return--?');
                console.log(response.getReturnValue());
            }else{
            }
        });
        
        
        
        
        $A.enqueueAction(action1);
        
        
        $A.enqueueAction(action);
        
    },
    helperShowModal : function(component,event,helper){
        component.set('v.showModal',true);
        
    },
    
    helperCloseModal : function(component,event,helper){
        component.set("v.showModal",false);
    },
    helperHandleSelection : function(component,event,helper){
       
        
        var selectedRows = event.getParam('selectedRows');
                component.set('v.selectedRowsCount',selectedRows.length);

        component.set('v.contactList',selectedRows);
    },

    helperUpdateContact: function(component,event,helper){
   
        var action = component.get('c.saveContacts');
        component.set('v.wrapperList.recordId',component.get('v.recordId'));
        component.set('v.wrapperList.contactsListUpdate',component.get('v.contactList'));
        
        action.setParams({wrap : component.get('v.wrapperList')});
        console.log('ss');
        action.setCallback(this, function(response){ 
            var state= response.getState();
            if(state === "SUCCESS"){
                component.set('v.showModal',false);
                let returned = response.getReturnValue();
				console.log('=====');
                console.log(returned);
            }
                                         });
	}    
})