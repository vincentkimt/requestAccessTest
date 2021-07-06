@isTest
public class CandidateTriggerHandlerTest {
	public static List<Class__c> classList;
    public static List<Candidate__c> candidateList;
    
    public static void createData(){
        classList=new List<Class__c>();
        candidateList=new List<Candidate__c>();
         classList=TestUtil.createClassRecords('MyClass', 5, true);
        candidateList=TestUtil.createCandidateRecords('Student', 25, false);
        
        for(Integer i=0;i<candidateList.size();i++){
            candidateList.get(i).Class__c=classList.get(Math.mod(i,5)).Id;
        }
        
        insert candidateList;
    }
    @isTest
    public static void testCandidateInsert(){
       
        createData();
        Set<Id> setIdOfClass = new Set<Id>();
        for(Class__c classObj : classList){
            setIdOfClass.add(classObj.Id);
        }
        List<Class__c> countClassList = new List<Class__c>();
        for(Class__c classObj : [SELECT Id, Name,Count__c FROM Class__c WHERE Id IN: setIdOfClass]){
            System.assertEquals(5, classObj.Count__c);
        }
       
    }
     @isTest
    public static void testCandidateUpdate(){
        createData();
        
        List<Candidate__c> candidateListForQuery= new List<Candidate__c>();
        for(Candidate__c can : candidateList){
            if(can.Class__c == classList.get(0).Id){
                can.Class__c= classList.get(1).Id;
                candidateListForQuery.add(can);
            }
        }
        update candidateList;
        Set<Id> setIdOfClass = new Set<Id>();
        for(Candidate__c candidate : candidateListForQuery){
            setIdOfClass.add(candidate.Class__c);
        }
        
        for(Class__c  classObj : [SELECT Id, Count__c ,Name  FROM Class__c WHERE Id IN: setIdOfClass]){
            System.assertEquals(10, classObj.Count__c);
        }
    }
    @isTest
    public static void testCandidateDelete(){
          createData();
		
		List<Candidate__c> deleteList = new List<Candidate__c>();
        List<Id> idOfDeletedRecords = new List<Id>();
        for(Candidate__c cand : candidateList){
            if(cand.Class__c ==  classList.get(0).Id){
                deleteList.add(cand);
                idOfDeletedRecords.add(classList.get(0).Id);
            }
        }
        
		delete deleteList;
		
        for(Class__c classObj : [SELECT Id,Count__c,Name FROM Class__c WHERE Id IN: idOfDeletedRecords]){
            System.assertEquals(0, classObj.Count__c);
        }
        
    }
    @isTest
    public static void testCandidateUnDelete(){
          createData();
        
		List<Candidate__c> deleteList = new List<Candidate__c>();
		Set<Id> deletedCandidateSet = new Set<Id>();
        for(Candidate__c cand : candidateList){
            if(cand.Class__c ==  classList.get(0).Id){
                deleteList.add(cand);
                deletedCandidateSet.add(cand.Id);
            }
        }
        
		delete deleteList;
		
        deleteList.clear();
        
        deleteList=[SELECT Id 
                    FROM Candidate__c 
                    WHERE Id IN: deletedCandidateSet
                    ALL ROWS];
        
        undelete deleteList;//in undelete The Id field is also restored.
        
        for(Class__c classObj : [SELECT Id,Count__c,Name FROM Class__c WHERE Id IN: deletedCandidateSet]){
           System.assertEquals(5,classObj.Count__c);
        }
        
    }
}