({
	callChild : function(component, event, helper) {
                console.log('1component-->');

		var childComponent=component.find('childCmp');
        console.log('2component-->'+childComponent);
        childComponent.callChild();
	}
})