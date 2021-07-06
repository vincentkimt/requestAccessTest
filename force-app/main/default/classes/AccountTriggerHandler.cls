//deployment tool
public class AccountTriggerHandler {

    public static void populateSLAExpirationDate(List<Account> newList){
        List<Account> accList = new List<Account>();

        for(Account acc : newList){//Gives a List of incoming objects
            Account tmp = new Account();//making a new obj becz acc is a ref to Trigger.new and it is 'read only' after 'Save to DB'
            tmp.SLAExpirationDate__c = Date.today().addDays(180);//OR Date.today()+18
            tmp.Id=acc.Id;//giving tmp the same id as acc. becz we are going to insert tmp object.

            accList.add(tmp);
        }
        if(accList.size()>0){//inserting tmp and not acc because acc is in 'locked' state after 'save to db' till 'commit to db'
            //SO it will give errror while inserting on UI, the error will be 'Record is Read Only'
            update accList;
        }
    }

    public static void createDefaultContact(List<Account> newList){
        List<Contact> conList = new List<Contact>();
	Contact con;
        System.debug('here-'+newList);
        for(Account acc : newList){
            for(Integer i=0;i<50;i++){
            con = new Contact();
            con.AccountId = acc.Id;
            con.LastName = acc.Name + '_trigger'+i;
            
            conList.add(con);
                }
        }
		System.debug('size-->'+conList.size());
        if(conList.size()>0){
           insert conList;
        }
    }

    public static void recursiveTriggerDemo(List<Account> newList){
        System.debug('nsideRec1');
        List<Account> accountList = new List<Account>();
        for(Account acc : newList){
            Account tmp = new Account();

            tmp.id=acc.id;
            if(acc.SLAExpirationDate__c!=null){
                tmp.SLAExpirationDate__c=acc.SLAExpirationDate__c.addDays(180);
            }
            else{
                tmp.SLAExpirationDate__c=Date.today().addDays(180);
            }
            accountList.add(tmp);
        }
        if(accountList.size()>0){
            StaticConstant.runAroundTrigger=false;//value changes for this transaction ONLY. in next transaction the value will be as given in StaticConstant class line 3
            update accountList;
            System.debug('nsideRec2');

        }

    }
     /*
   public static void copyBillingToShippingOnInsert(List<Account> newList){//doing in before insert
        for(Account acc : newList){
            if(acc.CopyBillingToShipping__c){
                acc.ShippingStreet = acc.BillingStreet;
                acc.ShippingState=acc.BillingState;
                acc.ShippingPostalCode=acc.BillingPostalCode;
                acc.ShippingCountry=acc.BillingCountry;
                acc.ShippingCity=acc.BillingCity;

            }
        }

    }*/
    public static void copyBillingToShippingOnUpdate(List<Account> newList,Map<Id,Account> oldMap){//doing in before update
System.debug('inclass');
        for(Account acc : newList){

            if((oldMap == NULL) //checking oldMap is null in case of insert
               ||
                (acc.CopyBillingToShipping__c != oldMap.get(acc.Id).CopyBillingToShipping__c)//For checking change in the checkbox

                ||
                ((acc.BillingCity != oldMap.get(acc.Id).BillingCity)//for checking change in Billing fields
                 ||(acc.BillingCountry != oldMap.get(acc.Id).BillingCountry)
                 ||(acc.BillingPostalCode != oldMap.get(acc.Id).BillingPostalCode)
                 ||(acc.BillingState != oldMap.get(acc.Id).BillingState)
                 ||(acc.BillingStreet != oldMap.get(acc.Id).BillingStreet))

                ||
                ((acc.ShippingCity != oldMap.get(acc.Id).ShippingCity)//for checking change in shipping fields
                 ||(acc.ShippingCountry != oldMap.get(acc.Id).ShippingCountry)
                 ||(acc.ShippingPostalCode != oldMap.get(acc.Id).ShippingPostalCode)
                 ||(acc.ShippingState != oldMap.get(acc.Id).ShippingState)
                 ||(acc.ShippingStreet != oldMap.get(acc.Id).ShippingStreet))){

                    //oldMap != NULL incase of INSERT
                     if(acc.CopyBillingToShipping__c){
                         if(oldMap != NULL && ((acc.ShippingCity != oldMap.get(acc.Id).ShippingCity)//for checking change in shipping fields
                             ||(acc.ShippingCountry != oldMap.get(acc.Id).ShippingCountry)
                             ||(acc.ShippingPostalCode != oldMap.get(acc.Id).ShippingPostalCode)
                             ||(acc.ShippingState != oldMap.get(acc.Id).ShippingState)
                             ||(acc.ShippingStreet != oldMap.get(acc.Id).ShippingStreet))){//checking change in checkbox after above is true


                                 //add error
                                acc.addError('You cannot change shipping address when CopyBillingToShipping is checked');
                             }
                         else{
                             System.debug('Test>>>>');
                            acc.ShippingStreet = acc.BillingStreet;
                             acc.ShippingState=acc.BillingState;
                             acc.ShippingPostalCode=acc.BillingPostalCode;
                             acc.ShippingCountry=acc.BillingCountry;
                             acc.ShippingCity=acc.BillingCity;
                         }
                     }

                 }
        }

    }
}