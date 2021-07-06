trigger AccountAddressTrigger on Account (before insert,before update) {

    if(Trigger.isInsert || Trigger.isUpdate){
        For(Account a : Trigger.new){
            if(a.Match_Billing_Address__c){
                if(!String.isBlank(a.BillingPostalCode))
                a.ShippingPostalCode = a.BillingPostalCode;
            }
        }
    }   


}