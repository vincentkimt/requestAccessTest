public class VFDemo7Controller {

    
    public boolean showEdit{get;set;}
    public Account acc{get;set;}
    public VFDemo7Controller(){
         acc=new Account();
        showEdit=True;
        
    }
    
    public void Save(){
        showEdit=False;
        Upsert acc;
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM,'Record is successfully updated'));

    }
    
    public void Edit(){
         showEdit=True;

    }
    
    public void Cancel(){
        
    }
}