@isTest
public class AccountManagerTest {
		
    @isTest static void testGetAccount(){
        RestRequest request = new RestRequest();
        String accountId = createAccountAndContact();
        
        request.requestURI = 'https://hungryvacations-dev-ed.my.salesforce.com/services/apexrest/Accounts/'+accountId+'/contacts';
        RestContext.request = request;
        Account response = AccountManager.getAccount();
        System.assert(response != null);
        
    }
    
    
    static Id createAccountAndContact(){
        
        Account acc = new Account(Name='fakeAccount');
        
        Insert acc;
        
        Contact con1 = new Contact(FirstName='fake',LastName='Con1',AccountId=acc.Id);
        Contact con2 = new Contact(FirstName='fake',LastName='Con2',AccountId=acc.Id);
        List<Contact> insertContact = new List<Contact>();
        insertContact.add(con1);insertContact.add(con2);
        Insert insertContact;
        return acc.id;
        
    }
}