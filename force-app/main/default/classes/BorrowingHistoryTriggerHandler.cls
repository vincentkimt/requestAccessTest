/**
 * Developed by- Vincent Lal
 * Description - This class is a handler of trigger BorrowingHistoryTrigger on object Borrowing_History__c.
 * It is called to handle the business logic.
 *
 *
 */
public class BorrowingHistoryTriggerHandler {

    /**
     * This method does three things
     * 1. If the Library item is returned by the Employee, the fields DateOfBorrow__c and DateOfReturn__c
     * are set to Null and the status__c field is set to available so that the item is available for other employee to borrow.
     *
     * 2. If the employee is issued a Library Item record, then the email id of that employee is set to
     * the Library item record
     *
     * 3. This method is also calling the future method. and sending the Employee_Borrowing_History__c record Ids
     *  This is to fetch the current existing 'true' marked record for the currently executing borrowing history record.
     */
    public void beforeTrigger(List<Borrowing_History__c> newList){

        List<Employee_Borrowing_History__c> employeeHistory = new List<Employee_Borrowing_History__c>();
        Set<String> setOfebhId = new Set<String>();
        Set<Id> setOfIdToUpdate = new Set<Id>();
        Set<Id> setOfIdOfEmployee = new Set<Id>();
        Employee_Borrowing_History__c ebh = new Employee_Borrowing_History__c();

        Map<Id,String> mapOfEmployeeEmail = new Map<Id,String>();
		List<Employee__c> employees = new List<Employee__c>();

        for(Borrowing_History__c ebhs : newList){
            setOfIdOfEmployee.add(ebhs.Employee__c);
        }

        if(setOfIdOfEmployee.size()>0){
        employees = [SELECT Id,Email__c FROM Employee__c WHERE Id IN :setOfIdOfEmployee];
        }

		for(Employee__c emp : employees){
                mapOfEmployeeEmail.put(emp.Id,emp.Email__c);
            }
        for(Borrowing_History__c bhc : newList){
                if(bhc.Employee__c == null){


                    bhc.DateOfBorrow__c = null;
                    bhc.DateOfReturn__c=null;
                    bhc.Status__c	= 'Available';

                }
                If(Trigger.isInsert){
                    bhc.Unique_Validation__c = bhc.Name;
                }
                setOfebhId.add(bhc.Name);

                if(bhc.Employee__c != null){
                    if(mapOfEmployeeEmail.containsKey(bhc.Employee__c)){
                    bhc.Email__c = mapOfEmployeeEmail.get(bhc.Employee__c);
					}
                }
            }

        for(Employee_Borrowing_History__c ebhs: [SELECT ID,isActiveBorrowItem__c
                                                FROM Employee_Borrowing_History__c
                                                WHERE isActiveBorrowItem__c=true AND
                                                ItemName__c IN:setOfebhId
                                                ]){
            setOfIdToUpdate.add(ebhs.Id);
        }

        updateOldHistory(setOfIdToUpdate);
}

    /**
     * This future method set the isActiveBorrowItem__c field to false because the item has been returned to Library
     * The EmployeeBorrowingHistory object's records are updated, So that the reporting and library transactions
     * are kept up to date and correct.
     *
     */
    @future
    public static void updateOldHistory(Set<Id> historyListId ){


        List<Employee_Borrowing_History__c> listOfHistoryBorrow = [SELECT Id,isActiveBorrowItem__c
         FROM Employee_Borrowing_History__c WHERE Id IN:historyListId];
		 List<Employee_Borrowing_History__c> listOfHistoryBorrowToUpdate = new List<Employee_Borrowing_History__c>();

		Employee_Borrowing_History__c ebhUpdate ;
        for(Employee_Borrowing_History__c ebh : listOfHistoryBorrow){
            ebhUpdate = new Employee_Borrowing_History__c();
            ebhUpdate.Id = ebh.Id;
            ebhUpdate.isActiveBorrowItem__c = false;
            listOfHistoryBorrowToUpdate.add(ebhUpdate);
        }
        if(listOfHistoryBorrowToUpdate.size()>0){
            update listOfHistoryBorrowToUpdate;
        }

    }


}