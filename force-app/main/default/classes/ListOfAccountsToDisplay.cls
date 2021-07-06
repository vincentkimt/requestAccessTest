public class ListOfAccountsToDisplay {

    @AuraEnabled
    public static List<Account> getAccounts(){
        return [SELECT Id,Name From Account Limit 10];
    }
}