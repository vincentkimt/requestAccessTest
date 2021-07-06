public class VFDemo8Controller {

    public List<SelectOption> accountList{get;set;}
    public String selectedAccountId{get;set;}
    public Account selectedAccount{get;set;}
    public List<Contact> listContact{get;set;}
    public String selectedContactId{get;set;}
    public Contact selectedContact{get;set;}
    public List<ContactWrapper> wrapperList{get;set;}
    public VFDemo8Controller(){
        wrapperList=new List<contactWrapper>();
        accountList = new List<SelectOption>();
        selectedAccount=new Account();
        listContact=new List<Contact>();
        accountList.add(new SelectOption('','--None--'));//Adding a 'none' so that we have a default selected value for the dropdown.
    for(Account acc : [SELECT Id,Name 
                       FROM Account
                       LIMIT 10]){
                           
     accountList.add(new SelectOption(acc.Id,acc.Name));//This is value,Lable. So it lable appear in dropdown and ID is it's value that is sent to controller.
                       }
    }
    
    public void fetchSelectedAccount(){
       listContact.clear();//so that is doesn't hold older values with every onchange
        wrapperList = new List<contactWrapper>();
        for(Account acc: [SELECT Id,Rating,OwnerId,Name 
                          FROM Account
                          WHERE Id=:selectedAccountId]){
                              selectedAccount=acc;
                              
                              
                          }
        listContact = [SELECT Id,Name,Email,FirstName,LastName 
                                             FROM Contact 
                                             WHERE AccountId =:selectedAccountId AND AccountId !=NULL];
          if(String.isBlank(selectedAccountId)){
           
            selectedAccount = new Account();
        	}
        //Fill WrapperList
        for(Contact con : listContact){
            wrapperList.add(new ContactWrapper(con));
        }
        System.debug('wrapper lst size:'+wrapperList.size());
    }
    
    public void fetchContactDetails(){
        selectedContact=new Contact();
        
        for(Contact con : [SELECT Id,FirstName,LastName,BirthDate,Email FROM Contact WHERE Id=:selectedContactId]){
            selectedContact=con;
        }
    }
    public void saveContactDetails(){
        update selectedContact;
        selectedContact = new Contact();
     	fetchSelectedAccount();
    }

    public void editWrapper(){
        
    }
    public void saveWrapper(){
        List<Contact> contactUpdateList=new List<Contact>();
        for(contactWrapper rec : wrapperList){
            if(rec.isSelected){
                contactUpdateList.add(rec.conRecord);
          }
        }
        
        if(contactUpdateList.size() > 0){
            update contactUpdateList;
        }
        fetchSelectedAccount();
        
    }
    public class contactWrapper{
        public boolean isSelected{get;set;}
        public Contact conRecord{get;set;}
        
        public contactWrapper(Contact con){
            isSelected=false;
            conRecord=new Contact();
            conRecord=con;
        }
        
        
    }
}