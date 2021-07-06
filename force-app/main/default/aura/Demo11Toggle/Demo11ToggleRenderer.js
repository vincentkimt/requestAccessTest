({
	// Your renderer method overrides go here
    render : function(cmp, helper) {
 			var ret = this.superRender();
        console.log('render');
        return ret;
},
    rerender : function(component, helper) {
   this.superRerender();
   console.log('rerender'); 
},
    afterRender: function (component, helper) {
    this.superAfterRender();
      console.log('afterRender'); 

},
    unrender: function () {
    this.superUnrender();
    console.log('unrender'); 
}
})