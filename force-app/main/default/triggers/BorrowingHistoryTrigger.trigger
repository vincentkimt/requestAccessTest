/**
 * Developed by- Vincent Lal
 * Description - This class is a trigger on object Borrowing_History__c.
 * It runs on two scenarios Insert and Update of the Borrowing_History__c
 * The handler BorrowingHistoryTriggerHandler is called to handle the business logic
 *
 *
 */

trigger BorrowingHistoryTrigger on Borrowing_History__c (before update,before insert, after update) {
    BorrowingHistoryTriggerHandler handler = new BorrowingHistoryTriggerHandler();

    if(Trigger.isBefore){
        handler.beforeTrigger(Trigger.new);
    }

    if(Trigger.isAfter && Trigger.isUpdate){

        //handler.afterTrigger();
    }

}