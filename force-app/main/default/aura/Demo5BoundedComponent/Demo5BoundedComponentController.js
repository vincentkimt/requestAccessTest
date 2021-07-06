({
	updateParent : function(component, event, helper) {
		console.log('updating parent attr.');
        component.set('v.parentAttribute','update parent attribute bounded');
	},
    
    parentChangeHandler : function(component, event, helper) {
		console.log("parent attribute changed");
       console.log(event.getParam('oldValue'));
       console.log(event.getParam('Value'));
}
    
})