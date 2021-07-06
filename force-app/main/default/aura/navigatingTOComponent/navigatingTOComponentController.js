({
    navigate : function(component, event, helper) {
        var navigateEvent = $A.get("e.force:navigateToComponent");
        navigateEvent.setParams({
            componentDef: "c:navigateFromComponent"
            //You can pass attribute value from Component2 to Component1
            //componentAttributes :{ }
        });
        console.log('inside cmp2');
        navigateEvent.fire();
    }
})