trigger CandidateTrigger on Candidate__c (after insert, after update, after delete, after undelete) {

	//if(Trigger.isInsert && Trigger.isBefore){CandidateTriggerHandler.insertCandidate(Trigger.new); }
    
    //CandidateTriggerHandler.updateCandidate(Trigger.newMap,Trigger.oldMap);
    CandidateTriggerHandler.countCandidate(Trigger.new, Trigger.oldMap);

}