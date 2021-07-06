({
    navigate : function(component, event, helper) {
        var navigateEvent = $A.get("e.force:navigateToComponent");
        navigateEvent.setParams({
            componentDef: "c:navigatingTOComponent"
            //You can pass attribute value from Component1 to Component2
            //componentAttributes :{ }
        });
       console.log('inside cmp1');

        navigateEvent.fire();
    }
})