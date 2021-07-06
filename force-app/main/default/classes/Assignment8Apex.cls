public class Assignment8Apex {

    public void sendEmail(){
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        List<Account> listAccount=new List<Account>();
        Date fromDate=Date.Today();
        Date toDate=fromDate.addDays(-7);
       
        for(Account acc: [SELECT Id, Name, Email__c 
                          FROM Account
                          WHERE lastmodifieddate <=:fromDate 
                         AND lastmodifieddate >=:toDate
                         LIMIT 1]){
                             acc.Email__c = 'vincentkimt@gmail.com';
                              listAccount.add(acc);
                              
				
      
                          }
        	
        
        
    }
}