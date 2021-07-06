public class TestUtil {//This class will be one per project. Used for utilities for Unit Testing

    public static List<Class__c> createClassRecords(String Name, Integer count, Boolean isInsert){
        
        List<Class__c> classList = new List<Class__c>();
        
        for(Integer i=1;i<=count;i++){
            Class__c classObj = new Class__c();
            
            classObj.Name=Name+i;
            classList.add(classObj);
        }
        if(isInsert){
            insert classList;
        }
        return classList;
    }
    
    public static List<Candidate__c> createCandidateRecords(String Name, Integer count, Boolean isInsert){
        
        List<Candidate__c> candidateList = new List<Candidate__c>();
        
        for(Integer i=1;i<=count;i++){
            Candidate__c candidateObj = new Candidate__c();
            
            candidateObj.Name=Name+i;
            candidateList.add(candidateObj);
        }
        if(isInsert){
            insert candidateList;
        }
        return candidateList;
    }
    
    
}