({
getValueFromApplicationEvent : function(cmp, event,helper) {
	var ShowResultValue = event.getParam("Pass_Result");
	// set the handler attributes based on event data
	cmp.set("v.Get_Result", ShowResultValue);
    var extraInfo = helper.returnExtraInfo();
    cmp.set("v.extraInfo",extraInfo);
},
    init : function(cmp,event,helper){
        var flow = cmp.find("flowData");
		flow.startFlow("Quick_Account");
        }
})