public class LightningApexController {

    @AuraEnabled
    public static List<Account> fetchAccounts(){
        
        return [SELECT Id, Name, Type FROM Account LIMIT 10];
    }
}