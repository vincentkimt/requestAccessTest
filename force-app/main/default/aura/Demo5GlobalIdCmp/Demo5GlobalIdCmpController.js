({
	testGlobal : function(component, event, helper) {
		var globalId=component.getGlobalId();
        var btnCmp=document.getElementById(globalId+'_footer');
        alert(btnCmp.innerText);
	}
})