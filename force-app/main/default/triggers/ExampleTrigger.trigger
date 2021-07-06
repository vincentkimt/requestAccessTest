trigger ExampleTrigger on Contact (before insert,after delete) {

    if(Trigger.isInsert){
        Integer recordCount = Trigger.New.size();
        EmailManager.sendMail('vincent.lal@appirio.com','email by trigger in apex',recordCount +' Contact were inserted');
        
        
    }
    else if (Trigger.isDelete) {
        // Process after delete
    }
}