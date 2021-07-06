public class MapScenario {
 public void mapDemonstration(){
     
        Map<Id,Account> accId = new Map<Id, Account>();
     
        for(Contact con : [SELECT Id, AccountId, LastName FROM Contact WHERE CreatedDate= TODAY AND LastName LIKE  'setContact%'])
        {
                Account acc=new Account();
                acc.id=con.AccountId;
                acc.Active__c='No';
                accID.put(acc.Id, acc);
        }
        
        if(accID.size()>0){
            update accId.values();
        }
     
     for(Id accountId : accId.keySet()){
         System.debug('Value at key '+ accountId+ ' is '+accId.get(accountId));
     }
    }
}