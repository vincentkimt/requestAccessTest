({
    doEdit : function(component, event, helper) {
        
        var isEdit = component.get('v.flag');
        component.set('v.flag',!isEdit);
        
        if(isEdit){
            event.getSource().set('v.label','Edit');
            var editval = component.get('v.editText')
            component.set('v.editText',editval);
        }
        else
        {
            event.getSource().set('v.label','Save');
            component.set('v.editText','');
        }
    },
    toggle : function(component, event, helper){
        var cmp=component.find('idOfPara');
        $A.util.toggleClass(cmp, "toggleClass");
    },
    doInit : function(component, event, helper){
        console.log('inside init');
    },
    
    onRender : function(component, event, helper){
        
        console.log('inside OnRender');
    },
    changeValue : function(component, event, helper){
        component.set('v.textAttr','a new message is written here');
        
        console.log('inside changeValue method');
    },
    destroyChild : function(component,event,helper){
       var childComp =  component.find('childcomponent');
        childComp.destroy();
        console.log('inside destroy child js controller');
    }
})