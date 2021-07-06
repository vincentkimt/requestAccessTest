({
    doInit: function (component, event, helper) {
        component.set('v.coloumns', [
            { label: 'Name', fieldName: 'Name', type: 'Text' },
            { label: 'Status', fieldName: 'Status__c', type: 'Text' },
        ]);
        component.set('v.coloumnsEmployee', [
            { label: 'Name', fieldName: 'Name', type: 'Text' }
        ]);
        component.set('v.coloumnsEmployeeHistory', [
            { label: 'Name', fieldName: 'Name', type: 'Text' },
            { label: 'Item Name', fieldName: 'ItemName__c', type: 'Text' },
            { label: 'isActiveBorrowItem', fieldName: 'isActiveBorrowItem__c', type: 'Checkbox' },
            { label: 'Date Of Borrow', fieldName: 'Date_Of_Borrow__c', type: 'Date' },
            { label: 'Date of Expected Return', fieldName: 'Date_of_Return__c', type: 'Date' },
            { label: 'Date of Actual Return', fieldName: 'Date_of_Actual_Return__c', type: 'Date' },
            { label: 'Overdue Days', fieldName: 'Overdue_Days__c', type: 'Number' }

        ]);
        component.set('v.coloumnsLibraryHistory', [
            { label: 'Name', fieldName: 'Name', type: 'Text' },
            { label: 'isActiveBorrowItem', fieldName: 'isActiveBorrowItem__c', type: 'Checkbox' },
            { label: 'ItemName	', fieldName: 'ItemName__c', type: 'Text' },
            { label: 'Date Of Borrow', fieldName: 'Date_Of_Borrow__c', type: 'Date' },
            { label: 'Date of Expected Return', fieldName: 'Date_of_Return__c', type: 'Date' },
            { label: 'Date of Actual Return', fieldName: 'Date_of_Actual_Return__c', type: 'Date' },
            { label: 'Overdue Days', fieldName: 'Overdue_Days__c', type: 'Number' }

        ]);

        component.find('LibraryItemName').focus();
    },

    searchItem: function (component, event, helper) {
        helper.searchItemHelper(component, event, helper);
    },
    closeModal: function (component, event, helper) {
        helper.helperCloseModal(component, event);
    },
    showModalMethod: function (component, event, helper) {
        helper.showModalMethodHelper(component, event);
    },

    handleSelection: function (component, event, helper) {
        helper.handleSelectionHelper(component, event);
    },

    searchEmployeeEnable: function (component, event, helper) {
        helper.searchEmployeeEnableHelper(component, event);

    },
    searchEmployee: function (component, event, helper) {
        helper.searchEmployeeHelper(component, event);

    },
    handleSelectionEmployee: function (component, event, helper) {
        helper.handleSelectionEmployeeHelper(component, event);
    },
    issueItems: function (component, event, helper) {
        helper.issueItemsHelper(component, event, helper);
    },
    handleReturnBook: function (component, event, helper) {
        helper.handleReturnBookHelper(component, event, helper);
    },
    handleReturnBookModal: function (component, event, helper) {
        helper.handleReturnBookModalHelper(component, event);

    },
    handleBrowseItems: function (component, event, helper) {
        helper.handleBrowseItemsHelper(component, event, helper);
    },
    addSearchTerms: function (component, event, helper) {
        helper.addSearchTermsHelper(component, event, helper);
    },
    handleEmployeeHistoryModal: function (component, event, helper) {
        helper.handleEmployeeHistoryHelper(component, event, helper);
    },
    handleBorrowingHistoryModal: function (component, event, helper) {
        helper.handleBorrowingHistoryModalHelper(component, event, helper);
    },
    searchEmployeeHistory: function (component, event, helper) {
        helper.searchEmployeeHistoryHelper(component, event, helper);
    },
    handleSelectionEmployeeShowHistory: function (component, event, helper) {
        helper.handleSelectionEmployeeShowHistoryHelper(component, event, helper);
    },
    seeEmployeeHistory: function (component, event, helper) {
        helper.seeEmployeeHistoryHelper(component, event, helper);
    },
    searchLibrayItemHistory: function (component, event, helper) {
        helper.searchLibrayItemHistoryHelper(component, event, helper);
    },
    searchBulkRecords: function (component, event, helper) {
        helper.searchBulkRecordsHelper(component, event, helper);
    }

})