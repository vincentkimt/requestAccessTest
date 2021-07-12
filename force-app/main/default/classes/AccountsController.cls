public with sharing class AccountsController {

  public AccountsController(){



  }



  @AuraEnabled
  public static List <Account> getAccounts() {
    return [SELECT Id, name, industry, Type, NumberOfEmployees, TickerSymbol, Phone,Website,AnnualRevenue FROM Account Where Industry <> '' AND Website <> '' AND Rating <> '' AND AnnualRevenue <> null LIMIT 10];
  }
 
  
  @AuraEnabled(cacheable = true)
  public static List <Account> getAccountsToLWC() {
    return [SELECT Id, Name,Website FROM Account LIMIT 10];
  }


  @AuraEnabled
  public static Contact getContact(Account acc){
    try {
      return [SELECT Id, Name FROM Contact Where AccountId=:acc.Id LIMIT 1];
    } catch (Exception e) {
      
      throw new AuraHandledException(e.getMessage());
    }
  }

}