public class NoOfcontactsToDisplay {

    public class resultWrapperNoOfcontactsToDisplay{
        @AuraEnabled public Integer countOfAccContact{get;set;}
        @AuraEnabled public Integer countOfContact{get;set;}
        @AuraEnabled public List<Contact> contactsListUpdate{get;set;}
        @AuraEnabled public List<Contact> contactsList{get;set;}
        @AuraEnabled public String recordId{get;set;}
    }
    
	@AuraEnabled
    public static Boolean justExecuteSomething(){
        System.debug('justExecuteSomething');
        return false;
    }
    
    @AuraEnabled
    public static resultWrapperNoOfcontactsToDisplay fetchContacts(String recordId){
        resultWrapperNoOfcontactsToDisplay wrap = new resultWrapperNoOfcontactsToDisplay();

        	List<Contact> cOfAccContact = [SELECT Id,Name,Email,Phone From Contact where AccountId=:recordId];
        List<Contact> cOfContact = [SELECT Id,Name,Email,Phone From Contact where AccountId = null LIMIT 20];
        
        wrap.countOfAccContact = cOfAccContact.size();
        
        wrap.countOfContact = cOfContact.size();
        wrap.contactsList = cOfContact;
        return wrap;
    }
    
    @AuraEnabled
    public static Boolean saveContacts(resultWrapperNoOfcontactsToDisplay wrap){
        System.debug('----asdq2ds2');
        List<Contact> contList = wrap.contactsListUpdate;
        String recId = wrap.recordId;
        List<Contact> updateContact = new List<Contact>();
        for(contact con : contList){
            con.AccountId=recId;
            updateContact.add(con);
        }
        try{
        if(updateContact.size()>0){
            update updateContact;
                    System.debug('----updated');

        }
            return true;
        }catch(Exception e){
            return false;
        }
        
    }
}