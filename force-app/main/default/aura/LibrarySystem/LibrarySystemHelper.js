({
    //Method to search the items scanned by barcode scanner.
    searchItemHelper: function (component, event, helper) {
        var action = component.get('c.searchLibraryItems');
        component.set('v.itemsFound', false);
        component.set('v.itemsFoundinAvailable', false);
        component.set('v.borrowedItemExist', false);
        component.set('v.showNoItemFound', false);

        action.setParams({ listItems: component.get('v.listItemsToSearch') });

        action.setCallback(this, function (response) {

            var state = response.getState();
            if (state === "SUCCESS") {
                component.set('v.wrapperObject', response.getReturnValue());
                var listAvailable = component.get('v.wrapperObject.listOfLibraryItemsAvailable');
                var listBorrowed = component.get('v.wrapperObject.listOfLibraryItemsBorrowed');
                var listOfAllItems = component.get('v.wrapperObject.listOfLibraryItems');
                if (listOfAllItems.length > 0) {
                    component.set('v.itemsFound', true);

                }
                if (listAvailable.length > 0) {
                    component.set('v.itemsFoundinAvailable', true);
                }
                if (listBorrowed.length > 0) {
                    component.set('v.borrowedItemExist', true);
                }
                if (!(listOfAllItems.length > 0)) {
                    component.set('v.showNoItemFound', true);
                }

                component.set('v.listItemsToSearch', '');


            }

        });


        $A.enqueueAction(action);
        component.find('LibraryItemName').focus();

    },
    //method to show the modal for issue items
    showModalMethodHelper: function (component, event) {
        component.set('v.showModal', true);
    },

    //Method to handle the selection of library items at issue item modal
    handleSelectionHelper: function (component, event) {


        var selectedRows = event.getParam('selectedRows');
        component.set('v.selectedRowsCount', selectedRows.length);

        component.set('v.wrapperObject.listOfLibraryItemsSelected', selectedRows);

        if (selectedRows.length < 1) {
            component.set('v.showIssueitemButtonOnModal', false);
        } else {

            component.set('v.showIssueitemButtonOnModal', true);
        }


    },

    //Helper method to close the modal. it also refresh the view so that the other modals are refreshed.
    helperCloseModal: function (component, event) {
        if (component.get("v.showModal") == true) { component.set("v.showModal", false); $A.get('e.force:refreshView').fire(); }

        if (component.get("v.showListView") == true) { component.set("v.showListView", false); $A.get('e.force:refreshView').fire(); }
        if (component.get("v.showListViewEmployee") == true) { component.set("v.showListViewEmployee", false); $A.get('e.force:refreshView').fire(); }
        if (component.get("v.showBorrowingHistory") == true) { component.set("v.showBorrowingHistory", false); $A.get('e.force:refreshView').fire(); }
        if (component.get("v.showReturnBook") == true) { component.set("v.showReturnBook", false); $A.get('e.force:refreshView').fire(); }
        if (component.get("v.showIssueitemButtonOnModal") == true) { component.set("v.showIssueitemButtonOnModal", false); }

    },

    //This enables the Employee Search
    searchEmployeeEnableHelper: function (component, event) {

        component.set('v.showEmployeeSearch', true);

    },
    //This method search the employee for issueing the items
    searchEmployeeHelper: function (component, event) {
        component.set('v.showErrorIfEmployeeLimitReached', false);
        component.set('v.employeeList', null);
        component.set('v.showEmployeeSearchResult', false);
        component.set('v.wrapperObject.recordIdOfEmployee', null);

        var action = component.get('c.searchEmployeeToIssue');
        action.setParams({ searchStr: component.find("SearchEmployeeText").get("v.value") });
        action.setCallback(this, function (response) {
            var state = response.getState();

            if (state === "SUCCESS") {
                component.set('v.employeeList', response.getReturnValue());

                component.set('v.showEmployeeSearchResult', true);
            }

        });

        $A.enqueueAction(action);
    },

    //THis method handles the selection of employee to whome the item is to be issued.
    handleSelectionEmployeeHelper: function (component, event) {
        var selectedRows = event.getParam('selectedRows');
        if (selectedRows.length > 0) {
            component.set('v.wrapperObject.recordIdOfEmployee', selectedRows[0].Id);

            component.set('v.showErrorIfNoEmployeeSelected', false);
            var selectedItemRow = component.get('v.selectedRowsCount');
            if (selectedItemRow > 0) {
                component.set('v.showIssueitemButtonOnModal', true);
            }
        }


    },

    //This method facilitates the issuing of items. The items are issued through the apex controller.
    issueItemsHelper: function (component, event, helper) {
        var action = component.get('c.issueLibraryItems');
        var empId = component.get('v.wrapperObject.recordIdOfEmployee');
        component.set('v.showErrorIfEmployeeLimitReached', false);
        component.set('v.showErrorIfQuantityNotIssueable', false);
        component.set('v.bulkItemError', false);

        if (typeof empId === undefined || empId === null) {
            component.set('v.showErrorIfNoEmployeeSelected', true);
        } else {
            action.setParams({ wrapData: component.get("v.wrapperObject") });
            action.setCallback(this, function (response) {
                var state = response.getState();

                if (state === "SUCCESS") {
                    var quantityIssue = response.getReturnValue().includes("Quantity");
                    var bulkIssue = response.getReturnValue().includes('At least 1');
                    if (response.getReturnValue() === 'EmployeeLimitExceed') {
                        component.set('v.showErrorIfEmployeeLimitReached', true);
                    } else if (quantityIssue) {
                        component.set('v.showErrorIfQuantityNotIssueable', true);
                        component.set('v.errorIfItemNotIssueable', response.getReturnValue());
                    } else if (bulkIssue) {
                        component.set('v.bulkItemError', true);
                        component.set('v.bulkItemErrorMsg', response.getReturnValue());

                    } else {
                        helper.helperCloseModal(component, event);

                        helper.showToast();
                    }
                } else {
                    component.set('v.showErrorIfNoEmployeeSelected', true);
                }

            });
        }
        $A.enqueueAction(action);
    },
    //This method shows the toast message.
    showToast: function (component, event, helper) {

        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": "Success!",
            "message": "The Library Items has been Updated successfully."
        });
        toastEvent.fire();
    },
    //This metod shows the return item modal
    handleReturnBookModalHelper: function (component, event, helper) {
        component.set('v.showReturnBook', true);
    },

    //This method calls the apex controller and it handle the returning the items
    handleReturnBookHelper: function (component, event, helper) {
        var listBorrowed = component.get('v.wrapperObject.listOfLibraryItemsBorrowed');
        var action = component.get('c.returnBorrowedItems');
        action.setParams({ returnItemList: listBorrowed });
        action.setCallback(this, function (response) {
            var state = response.getState();

            if (state === "SUCCESS") {
                helper.helperCloseModal(component, event);
                helper.showToast();
            }

        });

        $A.enqueueAction(action);

    },
    //this method handle the modal of Browse Item screen
    handleBrowseItemsHelper: function (component, event, helper) {
        component.set('v.showListView', true);
    },
    //This handles the scanned item adding to search list. On press of Enter key the item is added.
    addSearchTermsHelper: function (component, event, helper) {

        if (event.which == 13) {
            var textEntered = component.find("LibraryItemName").get("v.value");

            var lstToAdd = component.get('v.listItemsToSearch');
            lstToAdd.push(textEntered);
            component.set('v.listItemsToSearch', lstToAdd);
            component.find("LibraryItemName").set("v.value", '');
        }
    },
    //This method shows the list of employee to issue items.
    handleEmployeeHistoryHelper: function (component, event, helper) {
        component.set("v.showListViewEmployee", true);
    },
    //This method handles the searching the employee for issuing the items.
    searchEmployeeHistoryHelper: function (component, event, helper) {

        component.set('v.employeeListForHistory', null);
        component.set('v.showEmployeeSearchForHistory', false);
        var action = component.get('c.searchEmployeeToIssue');
        action.setParams({ searchStr: component.find("SearchEmployeeTextForHistory").get("v.value") });
        action.setCallback(this, function (response) {
            var state = response.getState();

            if (state === "SUCCESS") {
                component.set('v.employeeListForHistory', response.getReturnValue());
                component.set('v.showEmployeeSearchForHistory', true);
            }

        });

        $A.enqueueAction(action);

    },
    //This method handle the view of showing the employee history.
    handleSelectionEmployeeShowHistoryHelper: function (component, event, helper) {
        component.set('v.employeeListForHistoryshowbutton', true);
        var selectedRows = event.getParam('selectedRows');
        if (!(selectedRows === 'undefined')) {
            component.set('v.employeeIdForHistoy', selectedRows[0].Id);
        }

    },

    //This handles the fetching of employee history based on the employee name by calling the apex controller.
    seeEmployeeHistoryHelper: function (component, event, helper) {
        var empId = component.get('v.employeeIdForHistoy');
        component.set('v.showNoEmployeeHistoryFound', false);


        var action = component.get('c.searchHistoryOfEmployeeSelected');
        action.setParams({ employeeId: empId });
        action.setCallback(this, function (response) {
            var state = response.getState();

            if (state === "SUCCESS") {
                var empHistoryList = response.getReturnValue();
                if (empHistoryList.length > 0) {
                    component.set('v.historyOfSelectedEmployee', response.getReturnValue());
                    component.set('v.showNoEmployeeHistoryFound', false);
                    component.set('v.showEmployeeHistory', true);
                }
                else {
                    component.set('v.showNoEmployeeHistoryFound', true);

                    component.set('v.historyOfSelectedEmployee', null);
                }

            }

        });

        $A.enqueueAction(action);
    },

    //This method enable the modal for borrowing history view.
    handleBorrowingHistoryModalHelper: function (component, event, helper) {
        component.set("v.showBorrowingHistory", true);
    },

    //This method calls the apex controller for showing the search library item history
    searchLibrayItemHistoryHelper: function (component, event, helper) {

        var itemName = component.find("searchLibraryItemForHistory").get("v.value");


        var action = component.get('c.searchHistoryOfItemSelected');
        action.setParams({ itemNameToSearch: itemName });
        action.setCallback(this, function (response) {
            var state = response.getState();

            if (state === "SUCCESS") {
                component.set('v.libraryHistoryList', response.getReturnValue());

                component.set('v.showLibraryItemForHistoryFound', true);

            }

        });

        $A.enqueueAction(action);

    },

    searchBulkRecordsHelper: function (component, event, helper) {
        console.log('will navigate one day');
    }
})