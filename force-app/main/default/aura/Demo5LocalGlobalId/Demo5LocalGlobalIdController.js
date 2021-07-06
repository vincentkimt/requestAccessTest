({
	showId : function(component, event, helper) {
		var input=component.find("localIdDemo");
        console.log(input.getLocalId());
        console.log(input.getGlobalId());
        console.log(input.get('v.input1'));
        
	},
    showMultipleId : function(component,event,helper){
        var input=component.find("localIdDemo");
        input.forEach(function(item,index){
            console.log("item_"+index+"Local ID"+item.getLocalId());
            console.log("item_"+index+"Global ID"+item.getGlobalId());
            
            
        });
    }
})