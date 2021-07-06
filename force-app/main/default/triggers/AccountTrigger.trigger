trigger AccountTrigger on Account (after insert,after update,before insert, before update) {
   //AccountTriggerHandler.populateSLAExpirationDate(Trigger.new);
    if((Trigger.isInsert)&&(Trigger.isAfter)){
        System.debug('isAfter Insert');
        AccountTriggerHandler.createDefaultContact(Trigger.new);
    }
    System.debug('before update');
    if((Trigger.isInsert || Trigger.isUpdate)&&(Trigger.isAfter)){//this is called either on update or insert and after
        
        if(StaticConstant.runAroundTrigger)
        {
            AccountTriggerHandler.recursiveTriggerDemo(Trigger.new);
        }
    } System.debug('after update');
   /* if(Trigger.isInsert && Trigger.isBefore){//calling on insert and before.
        AccountTriggerHandler.copyBillingToShippingOnInsert(Trigger.new);
    } */
    
    if((Trigger.isUpdate || Trigger.isInsert) && Trigger.isBefore){//calling this trigger when an update/insert is done and done in Before
        System.debug('checking old map in trigger '+(Trigger.oldMap!=NULL));
        System.debug('trigger Map value '+ Trigger.oldMap);
        AccountTriggerHandler.copyBillingToShippingOnUpdate(Trigger.new,Trigger.oldMap);

    }
}