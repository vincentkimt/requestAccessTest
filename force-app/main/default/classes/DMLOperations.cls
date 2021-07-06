public class DMLOperations {

    
    public void createRecordWrongWay(){
        	for(Integer i=1;i<160;i++){
            Account acc=new Account();
            acc.Name='Test-'+i;
            //insert acc; Commented because NEVER WRITE DML INSIDE LOOP
            System.debug('insert successful');
        }
    }
    
    public void createRecordRightWay(){
          List<Account> accountList = new List<Account>();
        	for(Integer i=1;i<11000;i++){
            Account acc=new Account();
            acc.Name='Test-'+i;
			accountList.add(acc);
        }
        
        if(accountList.size()>0){
            insert accountList;
        }
    }
    
    
    public void updateRecords(){
        List<Account> accountList = new List<Account>();
        
        accountList= [SELECT Id,Name, Active__c,
                     OwnerId, Type
                     FROM Account
                     WHERE Name LIKE '%Test'
                     AND Name !=NULL];
        List<Account> updatedAccList = new List<Account>();
        for(Account acc : accountList){
            acc.Active__c='Yes';
            updatedAccList.add(acc);
        }
        
        if(updatedAccList.size()>0){
            update updatedAccList;
        }
    }
    
     public void updateRecordsBetterWay(){
        
       //Writing the query in the for loop will not produce any error as it will automatically retrieve in batches.
       //Only MAX 50000 records are allowed to retreive.
       //The sql query may be inside a loop. but it runs only once, and if any data is fetched the loop runs. otherwise not.
        List<Account> updatedAccList = new List<Account>();
        for(Account acc : [SELECT Id,Name, Active__c,
                     OwnerId, Type
                     FROM Account
                     WHERE Name LIKE '%Test'
                     AND Name !=NULL]){
            acc.Active__c='Yes';
            updatedAccList.add(acc);
        }
        //Although we don't get error in above.
        //We may get error below, if we are updating above 10000 records. "TO MANY DMLs" 
        if(updatedAccList.size()>0){
            update updatedAccList;
        }
    }
    
    public void readRecord(){
        
        for(Account acc : [SELECT Id, Name, Active__c
                           FROM Account
                           WHERE Name LIKE 'Test%'
                          ]){
                              System.debug('AccId: '+acc.Id + '>>>'+acc.Name+'>>>'+acc.Active__c);
                          }
        
        //GIVES Too many SOQL queries: 101
        //for(Integer i =1;i<101;i++){
        //    List<Account> acc = [SELECT Name FROM Account WHERE Name LIKE 'Test%'];
        //}
    }
    public void deleteRecords(){
        List<Account> acc = new List<Account>();
        //FOR DELETE WE ONLY NEED ID
        acc = [SELECT Id 
               FROM Account
               WHERE Name LIKE 'Test%'];
        
        if(acc.size()>0){
            delete acc;
        }
       
    }
    
    
}