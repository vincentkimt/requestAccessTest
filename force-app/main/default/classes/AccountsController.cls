public with sharing class AccountsController {

  public AccountsController(){



  }



  @AuraEnabled
  public static List <Account> getAccounts() {
    return [SELECT Id, name, industry, Type, NumberOfEmployees, TickerSymbol, Phone,Website,AnnualRevenue,Rating FROM Account Where Industry <> '' AND Website <> '' AND Rating <> '' AND AnnualRevenue <> null LIMIT 10];
  }
 
  
  @AuraEnabled(cacheable = true)
  public static List <Account> getAccountsToLWC() {
    return [SELECT Id, Name,Website FROM Account LIMIT 10];
  }



  @AuraEnabled
  public static String saveAccountToSF(String id,String Industry,String Rating,String website,decimal revenue){
    try {
      Account acc=[Select id,Industry,Rating,Website,AnnualRevenue from Account where Id=:id];
      acc.Industry=Industry;
      acc.Rating=Rating;
      acc.website=website;
      acc.AnnualRevenue= revenue;

      update acc;
      return 'success';
    } catch (Exception e) {
      System.debug(Logginglevel.ERROR, e.getMessage());
      throw new AuraHandledException(e.getMessage());
    }
  }

}