public class Assignment1Apex {

    public static void getContact(String idOfAccount){
       
        
        for(Contact con : [SELECT Id, Name, AccountId FROM Contact WHERE AccountId =: idOfAccount]){
            System.debug('Account related to Contact '+con.Id + ' ' + con.Name + ' ' +con.AccountId );
        }
        
    }
}