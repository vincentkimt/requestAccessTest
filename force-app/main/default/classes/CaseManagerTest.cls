@isTest
public class CaseManagerTest {

    
    
    @isTest static void testGetCaseById(){
        Id recordId = createTestRecord();
        RestRequest request = new RestRequest();
        
        request.requestURI = 'https://hungryvacations-dev-ed.my.salesforce.com/services/apexrest/Cases/' + recordId;
        
        request.httpMethod = 'GET';
        
        RestContext.request=request;
        
        Case caseActual = CaseManager.getCaseById();
        System.assert(caseActual != null);
        System.assertEquals('Test record', caseActual.Subject);
        
    }

    @isTest static void testCreateCase(){
       Id recordId = CaseManager.createCase(
            'Ferocious chipmunk', 'New', 'Phone', 'Low');
        System.assert(recordId != Null);
        
        Case thisCase = [SELECT Id FROM Case WHERE Id=:recordId];
        
        System.assertEquals('New',thisCase.Status);
        
    }    
    @isTest static void testDeleteCase(){
        RestRequest request = new RestRequest();
        Id recordId = createTestRecord();
        request.requestURI = 'https://hungryvacations-dev-ed.my.salesforce.com/services/apexrest/Cases/' + recordId;
		request.httpMethod = 'GET';
		RestContext.request=request;
        
        CaseManager.deleteCase();
        List<Case> cases = [SELECT Id FROM Case WHERE Id=:recordId];
        System.assert(cases.size()==0);
    }
    
    @isTest static void testUpsertCase(){
        Id case1Id = CaseManager.upsertCase('Ferocious chipmunk', 'New','Phone','Low',null);
        System.assert(case1Id != Null);
        Case this1Case = [SELECT Id FROM Case WHERE Id=:case1Id];
        System.assertEquals('New',this1Case.Status);
        
        ID case2Id = CaseManager.upsertCase('Ferocious chipmunk', 'Working','Phone','Low',case1Id);
        System.assert(case1Id==case2Id);
        
        Case this2Case=[SELECT Id FROM Case WHERE Id=:case2Id];
        System.assert(this2Case != null);
        System.assertEquals('Working',this2Case.Status);
    }
    
    @isTest static void testUpdateCaseField(){
        RestRequest request = new RestRequest();
        
        request.httpMethod = 'GET';
        Id recordId = createTestRecord();
        request.requestURI = 'https://hungryvacations-dev-ed.my.salesforce.com/services/apexrest/Cases/' + recordId;
        request.addHeader('Content-Type', 'application/json');
        request.requestBody = Blob.valueOf('{"Status": "Working"}');
        RestContext.request=request;
        
        Id thisRecordId = CaseManager.updateCaseFields();
        System.assert(thisRecordId != Null);
        System.assert(thisRecordId == recordId);
        Case thisCase = [SELECT Id FROM Case WHERE Id=:thisRecordId];
        System.assertEquals('Working',thisCase.status);
        
        
        
        
    }
    static Id createTestRecord(){
         Case caseTest = new Case(
            Subject='Test record',
            Status='New',
            Origin='Phone',
            Priority='Medium');
        insert caseTest;
        return caseTest.Id;
    }
}