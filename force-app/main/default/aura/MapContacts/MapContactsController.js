({
	doInit : function(component, event, helper) {
        console.log('creating fields');
        component.set('v.coloumns',[
            {label: 'Name', fieldName: 'Name', type: 'Text'},
            {label: 'Phone', fieldName: 'Phone', type: 'Phone'},
            {label: 'Email', fieldName: 'Email', type: 'Email'},
        ]);
		console.log('fields-->');
        console.log(component.get('v.coloumns'));
        
        helper.helperInit(component,event,helper);
        
        
	},
    showModal : function(component,event,helper) {
    	
        helper.helperShowModal(component,event,helper);
    
	},
    closeModal : function(component,event,helper){
        helper.helperCloseModal(component,event,helper);
    },
	handleSelection : function(component,event,helper){
    	helper.helperHandleSelection(component,event,helper);        
    },
    UpdateContacts : function(component,event,helper){
    helper.helperUpdateContact(component,event,helper);        
    }
})