({
	doToggle : function(component, event, helper) {
		component.set("v.isBounded",!component.get("v.isBounded"));
        component.set("v.buttonLabel",component.get("v.isBounded")?"Show Unbounded":"Show Bounded");
	}
})