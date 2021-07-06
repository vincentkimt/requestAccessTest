({
	doInit : function(component, event, helper) {
		
        var data={'name': 'vincent',
                  'email' : 'test@email.com'
                 };
        
        component.set('v.jsObject',data);
        component.set('v.userData',{'var1' : 'value1 for var 1',
                                    'var2' : 'value2 for var 2'});
	}
})