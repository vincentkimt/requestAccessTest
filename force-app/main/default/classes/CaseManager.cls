@RestResource(urlMapping='/Accounts/*')
global with sharing class CaseManager {

    
    @HttpGet
    global static Case getCaseById(){
        RestRequest req = RestContext.request;
        String caseId = req.requestURI.substring(req.requestURI.lastindexof('/')+1);
        Case caseResponse = [SELECT CaseNumber,Subject,Status,Origin,Priority
                             FROM Case 
                             WHERE Id = :caseId];
        
        return caseResponse;
    }
    
    @HttpPost
    global static Id createCase(String subject,String status, String origin, String priority){
        Case thisCase=new Case(Subject=subject,Status=status,Origin=origin,Priority=priority);
        
        Insert thisCase;
        
        return thisCase.Id;
    }
    
    @HttpDelete
    global static void deleteCase(){
        RestRequest req = RestContext.request;
        String caseId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        
        Case thisCase = [SELECT Id FROM Case WHERE Id = :caseId];
        delete thisCase;
     }
    
    @HttpPut
    global static Id upsertCase(String subject, String status, String origin, String priority, String id){
        
        Case thisCase = new Case(Subject=subject,Status=status,Origin=origin,Priority=priority,Id=id);
        
        Upsert thisCase;
        return thisCase.Id;
        
    }
    
    @HttpPatch
    global static Id updateCaseFields(){
        RestRequest req = RestContext.request;
        String caseId = req.requestURI.substring(req.requestURI.lastindexof('/')+1);
        Case thisCase = [SELECT Id 
                         FROM Case
                         WHERE Id = :caseId];
        
        Map<String,Object> caseRecord = (Map<String,Object>) JSON.deserializeUntyped(req.requestBody.tostring());
        
        for(String fieldName : caseRecord.keySet()){
            
            thisCase.put(fieldName, caseRecord.get(fieldName));
        }
        
        return thisCase.id;
        
    }
}