public class AnonymousCodeBlock {
     public static Boolean isFreezing(String celsiusTemp){ 
        if(String.isNotBlank(celsiusTemp) &&
        celsiusTemp.isNumeric()){ 
        return Decimal.valueof(celsiusTemp) <=0; 
        }
        return null; 
     }
    
    public static void runQuery(Integer option){
        if(option==3){
            List<Contact> lContacts = new List<Contact>();
            for(Contact c:[select firstname,lastname,Account.Name,Account.Id,Account.Type from Contact where
                           Account.Name='Abbott']){
                               lContacts.add(c);
                           }
            For(Contact cs: lContacts){
                System.debug('1-->'+cs.Account.Name+'--'+cs.Account.Id+'--'+cs.Account.Type+'-=---');
                System.debug('2-->'+cs.FirstName+'---'+cs.LastName);
            }
        }
        //////////////////////////
        if(option==1){
            Account a = [SELECT Id,Name,Type, (select Contact.FirstName,
                                              Contact.LastName from
                                              Account.Contacts) from
                        Account where Name='Abbott' Limit 1];
            List<Contact> contList=a.Contacts;
            for(Contact c:contList){
                System.debug('conFName-->'+c.FirstName+'--conLastName-->'+c.LastName+'---');
            }
        }
        
       
     }
    
    public static void genericNameFieldCompare(sObject oneObj, sObject twoObj){
        String oneName=(String) oneObj.get('Name');
        String twoName=(String) twoObj.get('Name');
        
        System.debug('name identified-->'+oneName+'---'+twoName);
    }
    
    public static void getPreferences(User u){
        Boolean show1 = User_Preference_cs__c.getInstance().Show_Help__c;
        Boolean show2 = User_Preference_cs__c.getValues(u.Id).Show_Help__c;
        //Boolean show3 = User_Preference_cs__c.Show_Help__c;
       // Boolean show4 = User_Preference_cs__c.getValues().Show_Help__c;
    }
    
    public static Boolean negativeTestcase(Integer option,String cel){
        
        if(option==1){
            
        System.debug('option-'+option);
            if(String.isNotBlank(cel) && cel.isNumeric()){
                return Decimal.valueOf(cel) <= 0;
            }
            else{
                return null;
            }
        }else if(option==2){
            System.debug('option-'+option);
            if(String.isNotBlank(cel) && cel.isNumeric()){
                                System.debug(Decimal.valueOf(cel));

                return Decimal.valueOf(cel) <= 0;
            }
            else{
                return null;
            }
        }else if(option==3){
			System.debug('option-'+option);
            if(String.isNotBlank(cel) && cel.isNumeric()){
                return Decimal.valueOf(cel) <= 0;
            }
            else{
                return null;
            }            
        }else if(option==4){
            System.debug('option-'+option);
            if(String.isNotBlank(cel) && cel.isNumeric()){
                return Decimal.valueOf(cel) <= 0;
            }
            else{
                return null;
            }
        }
        System.debug('no option');
        return false;
    }
    
    @future
    public static void createAccounts(){
Account acc;
        List<Account> accList = new List<Account>();
        for(Integer i=1;i<200;i++){
            acc=new Account();
            acc.Name='50 Contact Records '+i;
            accList.add(acc);
        }
        Insert accList;

    }
}