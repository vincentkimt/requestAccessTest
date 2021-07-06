({
	updateChild : function(component, event, helper) {
		component.set("v.childAttr","Child Updated");
	},
    
    callChildMethod:function(component,event,helper) {
        alert('called child from parent');
    }
})