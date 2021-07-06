({
	doInit : function(component, event, helper) {
      $A.createComponent(
         "c:Component1",
         {
 
         },
         function(newCmp){
            if (component.isValid()) {
               component.set("v.body", newCmp);
            }
         }
      );
   },
   NavigateComponent : function(component,event,helper) {
      $A.createComponent(
         "c:Component2",
         {
           "res" : event.getParam("Pass_Result")
         },
         function(newCmp){
            if (component.isValid()) {
                component.set("v.body", newCmp);
            }
         }
      );
   }
})