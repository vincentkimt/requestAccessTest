({
    lwcEventHandler : function(component, event, helper) {

        var eventdata=event.getParam('v');
        component.set("v.txtFromEvent",eventdata);
    }
})
