@RestResource(urlMapping='/Accounts/*/contacts')
global with sharing class AccountManager {

    
    @HttpGet
    global static Account getAccount(){
        RestRequest req = RestContext.request;
        String recordId = req.requestURI.substringBetween('Accounts/', '/contacts');
        
       
        Account objAccount = [SELECT Id,Name,(SELECT Id,Name FROM Contacts) FROM Account WHERE Id = :recordId LIMIT 1];
       
        return objAccount;
    }
}