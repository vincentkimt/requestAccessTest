({

    afterRender: function (component, event, helper) {
        this.superAfterRender();
        component.find("LibraryItemName").focus();
    }
})