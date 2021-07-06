({
	updateChild : function(component, event, helper) {
		console.log('updating child attr.');
        component.set('v.childAttribute','update child attribute');
	},
   	
    childChangeHandler : function(component, event, helper) {
	
       console.log("Child attribute changed");
       console.log(event.getParam('oldValue'));
       console.log(event.getParam('Value'));
}
})