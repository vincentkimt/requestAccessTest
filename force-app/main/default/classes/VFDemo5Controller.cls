public class VFDemo5Controller {

    public Account acc{set;get;}
    
    public VFDemo5Controller(){//Constructor get called when the associated VF Page is loaded.
        acc=new Account();
        String accId = ApexPages.currentPage().getParameters().get('Id');
        
       /* if(accId!=null){
            acc = [SELECT Name,Rating FROM Account WHERE Id=:accId];//This assign atleast 0 records. So it gives error. see below for solution
        }*/
        
        for(Account temp : [SELECT Name,Rating FROM Account WHERE Id =:accId]){
            acc=temp;
        }
    }
    
    public void Save(){
        if(acc.Rating == '' || acc.Rating == NULL){         
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Please enter Rating'));
        }
        else{
        Upsert acc;
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM,'Record Successfully Updated!'));
		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING,'Only Name and Rating is insert/updated'));

        //PageReference pageRef=new PageReference('/'+acc.Id);
        PageReference pageRef=new PageReference('/apex/VFDemo2?Id='+acc.Id);

        //return pageRef;
        
        }
    }
}