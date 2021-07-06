public with sharing class AccountsController {

  public AccountsController(){



  }



  @AuraEnabled
  public static List <Account> getAccounts() {
    return [SELECT Id, name, industry, Type, NumberOfEmployees, TickerSymbol, Phone,Website,AnnualRevenue FROM Account LIMIT 10];
  }
 
  
  @AuraEnabled(cacheable = true)
  public static List <Account> getAccountsToLWC() {
    return [SELECT Id, Name,Website FROM Account LIMIT 10];
  }

}