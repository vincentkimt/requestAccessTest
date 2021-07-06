public class CandidateTriggerHandler {
    
    
    public static void countCandidate(List<Candidate__c> newList, Map<Id,Candidate__c> oldMap){
        Set<Id> classIdSet = new Set<Id>();
        if(newList != NULL){
            for(Candidate__c can : newList){
                if(oldMap == NULL || can.class__c != oldMap.get(can.id).class__c){
                    if(can.class__c != NULL){
                        classIdSet.add(can.class__c);
                    }
                    if(oldMap != NULL && oldMap.get(can.id).class__c != NULL){
                        classIdSet.add(oldMap.get(can.id).class__c);
                    }
                }
            } 
        }
        else{
            for(Id classId: oldMap.keySet()){
                if(oldMap.get(classId).class__c != NULL){
                    classIdSet.add(oldMap.get(classId).class__c);
                }
            }
        } 
        
        List<Class__c> classList = new List<Class__c>();
        
        for(Class__c cls :[SELECT Count__c, (SELECT ID FROM Candidates__r) 
                           FROM Class__c
                           WHERE Id IN: classIdSet]){
                               cls.count__c = cls.Candidates__r.size();
                               classList.add(cls);
                           }
        
        if(classList.size() > 0){
            update classList;
        }
    } 
}