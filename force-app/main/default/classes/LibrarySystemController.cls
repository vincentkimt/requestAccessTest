/**
* Developed by - Vincent Lal
* Description - This class works as a controller of LibrarySystem.cmp
* The purpose of this class is to facilitate all the server side apex calls.
*/
public class LibrarySystemController {

    /**
* This is a wrapper class used to send and recieve the attributes from client side to server side.
*/
    public class wrapReturn{
        @AuraEnabled public List<Borrowing_History__c> listOfLibraryItems{get;set;}
        @AuraEnabled public List<Borrowing_History__c> listOfLibraryItemsAvailable{get;set;}
        @AuraEnabled public List<Borrowing_History__c> listOfLibraryItemsBorrowed{get;set;}
        @AuraEnabled public List<Borrowing_History__c> listOfLibraryItemsSelected{get;set;}
        @AuraEnabled public String recordIdOfEmployee{get;set;}
    }

    /**
* This method returns the number of Items that the user search after the scanning from the barcode
* scanner. it receives a list of Items of String. These items are iterated and All items are fetched from
* Salesforce.
*/
    @AuraEnabled
    public static wrapReturn searchLibraryItems(List<String> listItems){
        wrapReturn wrapRet = new wrapReturn();
        List<String> lstToSearch = listItems;
        List<Borrowing_History__c>  lstOfLib = new List<Borrowing_History__c>();

        List<Borrowing_History__c> lstOfLibAvailable = new List<Borrowing_History__c>();
        List<Borrowing_History__c> lstOfLibBorrowed = new List<Borrowing_History__c>();

        lstOfLib=[SELECT Name,Status__c,Library_Item__r.Available_Quantity__c FROM Borrowing_History__c WHERE Name IN :lstToSearch];

        for(Borrowing_History__c bhs : lstOfLib){
            if(bhs.Status__c == 'Available'){
                lstOfLibAvailable.add(bhs);
            }else{
                lstOfLibBorrowed.add(bhs);
            }
        }
        wrapRet.listOfLibraryItems=lstOfLib;
        wrapRet.listOfLibraryItemsAvailable=lstOfLibAvailable;
        wrapRet.listOfLibraryItemsBorrowed=lstOfLibBorrowed;
        return wrapRet;
    }


    /**
* This method search the Employees based on the name entered by user.
* It returns the list to employes from the Salesforce.
*/
    @AuraEnabled
    public static List<Employee__c> searchEmployeeToIssue(String searchStr){
        List<Employee__c> employeeList = new List<Employee__c>();
        String strSearch = '%' + searchStr + '%';

        employeeList=[SELECT Name FROM Employee__c WHERE Name LIKE :strSearch];

        return employeeList;
    }

    /**
* This method update the borrowing history records and update the Employee__c to null.
* This will set the item available for the employee to borrow.
*/
    @AuraEnabled
    public static void returnBorrowedItems(List<Borrowing_History__c> returnItemList){
        List<Borrowing_History__c> bhcList = new List<Borrowing_History__c>();
        Borrowing_History__c bhcUpdate;
        for(Borrowing_History__c bhc : returnItemList){
            bhcUpdate = new Borrowing_History__c();

            bhcUpdate.Id=bhc.Id;
            bhcUpdate.Employee__c = null;
            bhcUpdate.Date_Of_Actual_Return__c = Date.today();
            bhcUpdate.Email__c ='';
            bhcList.add(bhcUpdate);
        }
        if(bhcList.size()>0){
            update bhcList;
        }

    }

    /**
* This method set the selected items to the Employee.
* It also create a transactional record in Employee_Borrowing_History__c. This record
* is used to track the history of items borrowed and candidate borrowing history.
* This method also check for validations. 3 validations are checked before item is issued.
* 1. The employee cannot borrow more than 4 items. The limit is stored in a custom label which can be
* modified by config.
* 2. All items of library cannot be issued. Atleast One item should be reserved for the library.
* 3. If Employee tries to borrow limited(point 2) items in different transaction. The validation will
* stop the issue.
*/
    @AuraEnabled
    public static String issueLibraryItems(wrapReturn wrapData){
        String employeeId = wrapData.recordIdOfEmployee;

        List<Borrowing_History__c> listofSelectedItems = wrapData.listOfLibraryItemsSelected;
        List<Borrowing_History__c> listofItemsUpdate = new List<Borrowing_History__c>();

        Employee__c employe = [SELECT ID,Name FROM Employee__c WHERE Id=:employeeId];

        List<Employee_Borrowing_History__c> employeeLimit = [SELECT Id FROM Employee_Borrowing_History__c WHERE Employee__c =:employe.Id AND isActiveBorrowItem__c = true];
        Integer limitEmployee;
        Integer limititem;

        limitEmployee = Integer.valueof(System.Label.EmployeeLimitOfBorrow);
        limititem = Integer.valueof(System.Label.ItemLimitOfIssue);

        if((employeeLimit.size() + listofSelectedItems.size()) > limitEmployee){
            return 'EmployeeLimitExceed';
        }

        Set<Id> setOfId = new Set<Id>();
        Map<Id,Integer> mapOfParentQty = new Map<Id,Integer>();
        Map<String,Integer> mapOfChildQty = new Map<String,Integer>();
        Integer counter=0;
        for(Borrowing_History__c bhc : listofSelectedItems){
            setOfId.add(bhc.Id);
        }
        List<Employee_Borrowing_History__c> listOfemployeeHistory = new List<Employee_Borrowing_History__c>();
        Employee_Borrowing_History__c ebh;
        String returnString = 'Items';
        List<Borrowing_History__c> lstOfItems = [SELECT Id,DateOfBorrow__c,Name,DateOfReturn__c,Employee__c,Status__c,Library_Item__c,Library_Item__r.Available_Quantity__c FROM Borrowing_History__c WHERE Id IN :setOfId];
        for(Borrowing_History__c itemList : lstOfItems){

            if(itemList.Library_Item__r.Available_Quantity__c < limititem){
                returnString = returnString +' ' + itemList.Name + ' has only ' + itemList.Library_Item__r.Available_Quantity__c
                + ' Quantity left.';
            }

            mapOfParentQty.put(itemList.Library_Item__c,Integer.valueOf(itemList.Library_Item__r.Available_Quantity__c));
            if(mapOfChildQty.containsKey(itemList.Library_Item__c)){
              counter =  mapOfChildQty.get(itemList.Library_Item__c);
              counter ++;
              mapOfChildQty.put(itemList.Library_Item__c,counter);
              counter = 0;
            }else{
                mapOfChildQty.put(itemList.Library_Item__c,1);
            }

        }
        if(returnString != 'Items'){
            returnString = returnString + ' Deselect these Items';
            return returnString;
        }

        String returnStringAllitemsCannotbeIssued;
        for(Borrowing_History__c itemListnew : lstOfItems){
            if(mapOfChildQty.containsKey(itemListnew.Library_Item__c) &&
            mapOfParentQty.containsKey(itemListnew.Library_Item__c) &&
            (mapOfParentQty.get(itemListnew.Library_Item__c) == mapOfChildQty.get(itemListnew.Library_Item__c))){
                returnStringAllitemsCannotbeIssued='At least 1 Item should be reserved for Library.';
            }
        }
        if(returnStringAllitemsCannotbeIssued == 'At least 1 Item should be reserved for Library.'){
            return returnStringAllitemsCannotbeIssued;
        }

        //Issue logic starts
        for(Borrowing_History__c bhcData : lstOfItems){
            ebh = new Employee_Borrowing_History__c();
            ebh.Employee__c = employe.Id;
            ebh.Name = employe.Name + ' Borrowed ' + bhcData.Name;
            ebh.isActiveBorrowItem__c = true;
            ebh.Item_Borrowed__c=bhcData.Id;
            bhcData.DateOfBorrow__c = date.today();
            bhcData.DateOfReturn__c = Date.Today().addDays(10);
            bhcData.Status__c = 'Borrowed';
            bhcData.Employee__c = employe.Id;
            listofItemsUpdate.add(bhcData);
            listOfemployeeHistory.add(ebh);
        }

        if(listofItemsUpdate.size()>0){
            update listofItemsUpdate;
        }

        if(listOfemployeeHistory.size()>0){
            Insert listOfemployeeHistory;
        }
        return 'success';
    }
    /**
     * This method search the History of Employee selected by user. The method queries Employee_Borrowing_History__c
     *
     * and fetch records based on Employee Name.
     */
    @AuraEnabled
    public static List<Employee_Borrowing_History__c> searchHistoryOfEmployeeSelected(String employeeId){


        List<Employee_Borrowing_History__c> empHistory = [SELECT Name, ItemName__c, isActiveBorrowItem__c,Date_Of_Borrow__c,Date_of_Return__c,Date_of_Actual_Return__c,Overdue_Days__c FROM Employee_Borrowing_History__c WHERE Employee__c =:employeeId ORDER BY isActiveBorrowItem__c DESC];

        return empHistory;
    }
    /**
     *This method search the History of Employee selected by user. The method queries Employee_Borrowing_History__c
     *
     * and fetch records based on Item Name.
     */
    @AuraEnabled
    public static List<Employee_Borrowing_History__c> searchHistoryOfItemSelected(String itemNameToSearch){


        List<Employee_Borrowing_History__c> empHistory = [SELECT Name, isActiveBorrowItem__c,ItemName__c,Date_Of_Borrow__c,Date_of_Return__c,Date_of_Actual_Return__c,Overdue_Days__c  FROM Employee_Borrowing_History__c WHERE ItemName__c =:itemNameToSearch ORDER BY isActiveBorrowItem__c DESC];

        return empHistory;
    }


}