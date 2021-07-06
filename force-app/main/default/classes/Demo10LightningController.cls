public class Demo10LightningController {

    @AuraEnabled
    public static List<Account> fetchAccounts(){
        return [SELECT Id,Name,Rating 
                FROM Account 
                LIMIT 10];
        
            }
    @AuraEnabled
    public static List<Contact> fetchContacts(String accountApexId){
        System.debug('IdOfAccount ='+accountApexId);
        return [SELECT Id,Name 
                FROM Contact 
                WHERE accountID =:accountApexId];
        
            }
}