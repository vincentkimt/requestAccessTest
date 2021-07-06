/**
 * Developed By - Vincent Lal
 * Description - This class contains the unit test for LibrarySystemController.
 * Coverage is currently > 90%
 */
@isTest
public class LibrarySystemControllerTest {

    @testSetup
    public static void createData(){
        Library_Item__c libItembol = new Library_Item__c();
        libItembol.Name='Book Of Life';
        libItembol.Type__c='Book';
        Insert libItembol;
        Library_Item__c libItemAura = new Library_Item__c();
        libItemAura.Name='AURA';
        libItemAura.Type__c='Book';
        Insert libItemAura;

        Borrowing_History__c bhcBookOfLife = new Borrowing_History__c();
        bhcBookOfLife.Name='Book Of Life I';
        bhcBookOfLife.Status__c = 'Available';
        bhcBookOfLife.Type__c='Book';
        bhcBookOfLife.Library_Item__c=libItembol.id;
        Insert bhcBookOfLife;
        Borrowing_History__c bhcBookOfLifeII = new Borrowing_History__c();
        bhcBookOfLifeII.Name='Book Of Life II';
        bhcBookOfLifeII.Status__c = 'Available';
        bhcBookOfLifeII.Type__c='Book';
        bhcBookOfLifeII.Library_Item__c=libItembol.id;
        Insert bhcBookOfLifeII;
        Borrowing_History__c bhcAura101 = new Borrowing_History__c();
        bhcAura101.Name='AURA 101';
        bhcAura101.Status__c = 'Borrowed';
        bhcAura101.DateOfBorrow__c = Date.today();
        bhcAura101.DateOfReturn__c = Date.today();
        bhcAura101.Type__c='Book';
        bhcAura101.Library_Item__c=libItemAura.id;
        Insert bhcAura101;
        Employee__c emp = new Employee__c();
        emp.Name = 'Candidate Test';
        emp.Email__c = 'test@aol.com';
        Insert emp;
    }

    @isTest
    public static void testSearchLibraryItems(){
        List<String> strSearchList = new List<String>();
        List<Borrowing_History__c> bhcList = [SELECT Name FROM Borrowing_History__c];
        for(Borrowing_History__c bhc : bhcList){
            strSearchList.add(bhc.Name);
        }
        Borrowing_History__c bhcUpdate = [Select Id,Status__c,Employee__c,DateOfBorrow__c,DateOfReturn__c FROM Borrowing_History__c WHERE Name='AURA 101' ];

        Employee__c emp = [SELECT id FROM Employee__c WHERE name ='Candidate Test'];
        bhcUpdate.Employee__c=emp.Id;
        bhcUpdate.Status__c='Borrowed';

        bhcUpdate.DateOfBorrow__c = Date.today();
        bhcUpdate.DateOfReturn__c = Date.today();
        Update bhcUpdate;

        Test.startTest();
        LibrarySystemController.wrapReturn wrapReturnObj= new LibrarySystemController.wrapReturn();
        wrapReturnObj = LibrarySystemController.searchLibraryItems(strSearchList);

        List<Borrowing_History__c> borrowedItemsList = wrapReturnObj.listOfLibraryItemsBorrowed;
        List<Borrowing_History__c> availableItemsList = wrapReturnObj.listOfLibraryItemsAvailable;
        Borrowing_History__c bhcBorrowed = borrowedItemsList.get(0);
        Borrowing_History__c bhcAvailable = availableItemsList.get(0);
        Library_Item__c libItembol = [SELECT Name,Type__c FROM Library_Item__c WHERE Name ='Book Of Life'];
        Library_Item__c libItemAura = [SELECT Name,Type__c FROM Library_Item__c WHERE Name ='AURA'];

        System.assertEquals(true,wrapReturnObj.listOfLibraryItems.size()>0);
        System.assertEquals(true,wrapReturnObj.listOfLibraryItemsBorrowed.size()>0);
        System.assertEquals(true,wrapReturnObj.listOfLibraryItemsAvailable.size()>0);
        System.assertEquals('Book Of Life I',bhcAvailable.Name);
        System.assertEquals('Available', bhcAvailable.Status__c);
        System.assertEquals('AURA 101',bhcBorrowed.Name);
        System.assertEquals('Borrowed', bhcBorrowed.Status__c);

        Test.stopTest();

    }


    @isTest
    public static void testSearchEmployeeToIssue(){

        Test.startTest();
        List<Employee__c> empList= LibrarySystemController.searchEmployeeToIssue('Candidate');
        System.assertEquals('Candidate Test',empList.get(0).Name);
        System.assertEquals(true,empList.size()>0);

        Test.stopTest();
    }

    @isTest
    public static void testReturnBorrowedItems(){
        Borrowing_History__c bhcUpdate = [Select Id,Status__c,Employee__c,DateOfBorrow__c,DateOfReturn__c FROM Borrowing_History__c WHERE Name='AURA 101' ];

        Employee__c emp = [SELECT id FROM Employee__c WHERE name ='Candidate Test'];
        bhcUpdate.Employee__c=emp.Id;
        bhcUpdate.Status__c='Borrowed';

        bhcUpdate.DateOfBorrow__c = Date.today();
        bhcUpdate.DateOfReturn__c = Date.today();
        Update bhcUpdate;

        Test.startTest();
        List<Borrowing_History__c> itemList = [SELECT Id,Employee__c,Date_Of_Actual_Return__c FROM Borrowing_History__c WHERE Name='AURA 101'];
        LibrarySystemController.returnBorrowedItems(itemList);
        Test.stopTest();
        Borrowing_History__c bhcAssert = [Select Id,Status__c,Employee__c,Date_Of_Actual_Return__c FROM Borrowing_History__c WHERE Name='AURA 101' ];

        System.assertEquals('Available', bhcAssert.Status__c);
        System.assertEquals(null, bhcAssert.Employee__c);
        System.assertEquals(Date.today(), bhcAssert.Date_Of_Actual_Return__c);

    }

    @isTest
    public static void testIssueLibraryItems(){

        LibrarySystemController.wrapReturn wrapData = new LibrarySystemController.wrapReturn();
        wrapData.recordIdOfEmployee = [SELECT ID FROM Employee__c WHERE Name ='Candidate Test'].Id;
        wrapData.listOfLibraryItemsSelected = [SELECT Id,DateOfBorrow__c,DateOfReturn__c,Status__c,Employee__c FROM Borrowing_History__c WHERE Name='Book Of Life I'];
        String itemSearch = 'Book Of Life I';
        LibrarySystemController.wrapReturn wrapDataII = new LibrarySystemController.wrapReturn();
        wrapDataII.recordIdOfEmployee = [SELECT ID FROM Employee__c WHERE Name ='Candidate Test'].Id;
        wrapDataII.listOfLibraryItemsSelected = [SELECT Id,DateOfBorrow__c,DateOfReturn__c,Status__c,Employee__c FROM Borrowing_History__c WHERE Name='Book Of Life II'];

        Test.startTest();
        String returnString = LibrarySystemController.issueLibraryItems(wrapData);
        System.assertEquals('success',returnString);
        List<Employee_Borrowing_History__c> assertEmployeeBorrowHistoryByEmpId = LibrarySystemController.searchHistoryOfEmployeeSelected(wrapData.recordIdOfEmployee);
        List<Employee_Borrowing_History__c> assertEmployeeBorrowHistoryByItem = LibrarySystemController.searchHistoryOfItemSelected(itemSearch);
        System.assertEquals(true, assertEmployeeBorrowHistoryByEmpId.size()>0);
        System.assertEquals(true, assertEmployeeBorrowHistoryByItem.size()>0);

        String returnStringII = LibrarySystemController.issueLibraryItems(wrapDataII);
        System.assertEquals('Items Book Of Life II has only 1 Quantity left. Deselect these Items',returnStringII);
        Test.stopTest();

        Borrowing_History__c itemUpdated = [SELECT Id,Name,DateOfBorrow__c,DateOfReturn__c,Status__c,Employee__c FROM Borrowing_History__c WHERE Name='Book Of Life I' LIMIT 1];
        Employee_Borrowing_History__c employeeHistory = [SELECT Id,ItemName__c,Employee__c,Name,isActiveBorrowItem__c,Item_Borrowed__c FROM Employee_Borrowing_History__c WHERE Name= 'Candidate Test Borrowed Book Of Life I'LIMIT 1];
		Employee__c emp = [SELECT ID FROM Employee__c WHERE Name ='Candidate Test'];
        System.assertEquals('Borrowed',itemUpdated.Status__c);
        System.assertEquals(emp.Id, employeeHistory.Employee__c);
        System.assertEquals('Candidate Test Borrowed Book Of Life I', employeeHistory.Name);
        System.assertEquals(true,employeeHistory.isActiveBorrowItem__c);
		System.assertEquals(itemUpdated.Name, employeeHistory.ItemName__c);

    }


}