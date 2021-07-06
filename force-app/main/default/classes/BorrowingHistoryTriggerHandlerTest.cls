/**
 * Developed By - Vincent Lal
 * Description - This class contains the unit test for BorrowingHistoryTriggerHandler.
 * Coverage is currently > 90%
 */
@isTest
public class BorrowingHistoryTriggerHandlerTest {

    @testSetup
    public static void createData(){
        Library_Item__c libItemApex = new Library_Item__c();
        libItemApex.Name='Apex';
        libItemApex.Type__c='Book';
        Insert libItemApex;
        Library_Item__c libItemLWC = new Library_Item__c();
        libItemLWC.Name='LWC';
        libItemLWC.Type__c='Book';
        Insert libItemLWC;

        Borrowing_History__c bhcApex = new Borrowing_History__c();
        bhcApex.Name='Apex 101';
        bhcApex.Status__c = 'Available';
        bhcApex.Type__c='Book';
        bhcApex.Library_Item__c=libItemApex.id;
        Insert bhcApex;
        Borrowing_History__c bhcApex2 = new Borrowing_History__c();
        bhcApex2.Name='Apex 102';
        bhcApex2.Status__c = 'Available';
        bhcApex2.Type__c='Book';
        bhcApex2.Library_Item__c=libItemApex.id;
        Insert bhcApex2;
        Borrowing_History__c bhcLWC = new Borrowing_History__c();
        bhcLWC.Name='LWC 101';
        bhcLWC.Status__c = 'Borrowed';
        bhcLWC.DateOfBorrow__c = Date.today();
        bhcLWC.DateOfReturn__c = Date.today();
        bhcLWC.Type__c='Book';
        bhcLWC.Library_Item__c=libItemLWC.id;
        Insert bhcLWC;
        Employee__c emp = new Employee__c();
        emp.Name = 'Candidate Test';
        emp.Email__c = 'test@aol.com';
        Insert emp;
    }


    @isTest
    public static void testUpdateLiBItem(){
        Borrowing_History__c bhcUpdate = [Select Id,Status__c,Employee__c,DateOfBorrow__c,DateOfReturn__c FROM Borrowing_History__c WHERE Name='Apex 101' ];

        Employee__c emp = [SELECT id FROM Employee__c WHERE name ='Candidate Test'];
        bhcUpdate.Employee__c=emp.Id;
        bhcUpdate.Status__c='Borrowed';

        bhcUpdate.DateOfBorrow__c = Date.today();
        bhcUpdate.DateOfReturn__c = Date.today();

        Test.startTest();
        Update bhcUpdate;
        Test.stopTest();
        Employee__c empAssert = [SELECT id FROM Employee__c WHERE name ='Candidate Test'];

        Borrowing_History__c bhcAssert= [Select Id,Status__c,Employee__c,DateOfBorrow__c,DateOfReturn__c FROM Borrowing_History__c WHERE Name='Apex 101' ];
        System.assertEquals('Borrowed', bhcAssert.Status__c);
        System.assertEquals(empAssert.Id, bhcAssert.Employee__c);
        System.assertEquals(Date.today(), bhcAssert.DateOfBorrow__c);
    }

    //Test of Future method
    @isTest
    public static void testUpdateOldHistory(){
        LibrarySystemController.wrapReturn wrapData = new LibrarySystemController.wrapReturn();
        wrapData.recordIdOfEmployee = [SELECT ID FROM Employee__c WHERE Name ='Candidate Test'].Id;
        wrapData.listOfLibraryItemsSelected = [SELECT Id,DateOfBorrow__c,DateOfReturn__c,Status__c,Employee__c FROM Borrowing_History__c WHERE Name='Apex 101'];

        String str = LibrarySystemController.issueLibraryItems(wrapData);
        Set<Id> setOfIdToUpdate = new Set<Id>();

        List<Employee_Borrowing_History__c> ebhList= [SELECT ID,isActiveBorrowItem__c
                                                      FROM Employee_Borrowing_History__c];
        for(Employee_Borrowing_History__c ebhs: ebhList){
            setOfIdToUpdate.add(ebhs.Id);
        }
        Test.startTest();
        BorrowingHistoryTriggerHandler.updateOldHistory(setOfIdToUpdate);
        Test.stopTest();
        List<Employee_Borrowing_History__c> ebhListAssert= [SELECT ID,isActiveBorrowItem__c
                                                            FROM Employee_Borrowing_History__c];
        System.assertEquals(true,ebhList.get(0).isActiveBorrowItem__c);
        System.assertEquals(false,ebhListAssert.get(0).isActiveBorrowItem__c);






    }

}