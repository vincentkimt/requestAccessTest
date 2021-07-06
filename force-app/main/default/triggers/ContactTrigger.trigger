trigger ContactTrigger on Contact (before insert, before update,after insert) {

    if(Trigger.isBefore && (Trigger.isUpdate || Trigger.isInsert)){
        ContactTriggerHandler.checkDuplicate(Trigger.new,Trigger.oldMap);
    }
    if(Trigger.isInsert && (Trigger.isAfter)){
        ContactTriggerHandler.createCandidate(Trigger.new);
    }
    
}