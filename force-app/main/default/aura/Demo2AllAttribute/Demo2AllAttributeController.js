({
	doInit : function(component, event, helper) {
        var data={
            'name':'Lightning Component',
            'email':'training@appirio.com'
        };
        component.set('v.jsObject',data);
        component.set('v.accountObject',data);
        component.set('v.customType',{
            'myString': 'Test String',
            'myEmail':'vincent@appirio.com'});
	}
})