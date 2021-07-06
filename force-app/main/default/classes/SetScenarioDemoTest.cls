@isTest
public class SetScenarioDemoTest {

    @isTest
    static void setDemoAvoidDupsInListTest(){
        
        
        
        List<Account> accountList = new List<Account>();
        for(Integer i=1;i<=5;i++){
            accountList.add(new Account(Name='Test'+i));
        }
        insert accountList;
        
        List<Contact> contactList = new List<Contact>();
        
        for(Integer i=1;i<=9;i++){
            Contact con = new Contact();
            con.LastName='setContact'+i;
            con.AccountId=accountList.get(Math.mod(i,3 )).Id;
            contactList.add(con);
        }
        for(Integer i=10;i<=15;i++){
            Contact con = new Contact();
            con.LastName='anotherContact'+i;
            con.AccountId=accountList.get(3).Id;
            contactList.add(con);
        }
        insert contactList;
        SetScenarioDemo obj=new SetScenarioDemo();
        obj.setDemoAvoidDupsInList();
        
        List<Id> listOfAccountIds = new List<Id>();
        for(Contact con : [SELECT Id, AccountId, LastName FROM Contact WHERE CreatedDate= TODAY AND LastName LIKE  'setContact%']){
            listOfAccountIds.add(con.AccountId);
        }
        
        for(Account acc : [SELECT Id, Active__c FROM Account WHERE Id IN: listOfAccountIds]){
            System.assertEquals('Yes', acc.Active__c);
        }
        
        listOfAccountIds.clear();

        for(Contact con : [SELECT Id,AccountId FROM Contact WHERE LastName LIKE 'anotherContact%']){
          	
            listOfAccountIds.add(con.AccountId);
        }
        for(Account acc : [SELECT Id, Active__c FROM Account WHERE Id IN: listOfAccountIds]){
            System.assertEquals(NULL, acc.Active__c);
        }
    } 
}