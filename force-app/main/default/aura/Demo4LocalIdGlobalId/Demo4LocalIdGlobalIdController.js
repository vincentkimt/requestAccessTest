({
	showId : function(component, event, helper) {
		var inputCmp = component.find('inputLocalId');
        console.log(inputCmp.get('v.value'));
        console.log(inputCmp.getLocalId());
        console.log(inputCmp.getGlobalId());
	},
    showMultipleId : function(component, event, helper){
    var inputComponent = component.find('LocalId');
    inputComponent.forEach(function(item,index){
    console.log('item--'+index+'>>>>local ID>>'+item.getLocalId()+'>>>>Global ID>>'+item.getGlobalId());
});
}
})