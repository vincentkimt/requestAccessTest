public class SetScenarioDemo {

    public SetScenarioDemo(){
        Set<String> stringSet = new Set<String>();
        
        stringSet.add('a');
        stringSet.add('b');
        stringSet.add('c');
        stringSet.add('C');//allowed. not duplicate
    }
    
    public void duplicateInSet(){
        //BELOW IS THE REASON THAT IT IS NOT Reccomended to create a sObject/Object type Set.
        Account a = new Account();
        a.Name='Test';
        Insert a;
        
        Set<Account> accSet= new Set<Account>();
        accSet.add(a);
        
        
        Account a2=new Account();
        a2.id=a.id;
        a2.Active__c='Yes';
        update a2;
        
        accSet.add(a2);//duplicate entry in SET
        
}
    
    public void setDemoAvoidDupsInList(){//when we have to keep unique values in list, we make use of SET.
        Set<Id> accountIdSet = new Set<Id>();
        List<Account> accountUpdateList= new List<Account>();
        for(Contact con : [SELECT Id, AccountId, LastName FROM Contact WHERE CreatedDate= TODAY AND LastName LIKE  'setContact%'])
        {
            if(!accountIdSet.contains(con.AccountId)){
                Account acc=new Account();
                acc.id=con.AccountId;
                acc.Active__c='Yes';
                accountUpdateList.add(acc);
                accountIdSet.add(con.AccountId);
            }
        }
        
        if(accountUpdateList.size()>0){
            update accountUpdateList;
            System.debug('List value '+accountUpdateList);
        }
    }
}