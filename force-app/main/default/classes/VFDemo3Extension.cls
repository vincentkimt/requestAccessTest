public class VFDemo3Extension {
    public String message{get;set;}//make setters and getters automatically, without them cannot use it in vfpage
    public VFDemo3Extension(ApexPages.StandardController stdController) {//used for standard controller in VF Page.
		Account acc = (Account) stdController.getRecord();//retreive this(Id passed in URL) record if found display Welcome message on the VF Page. 
        if(acc.Name!=Null){
            message='Welcome '+acc.Name;
        }
        else{//else display below message on VF Page See line 3 of VFDemo3.vfp
            message='Enter New Values';
        }
    }

    
    public PageReference myCancel(){//when user click cancel from VFDemo3. it gets navigated to a custom page. default cancel button navigates to Home page.
        PageReference pageRef = new PageReference('/apex/HTML_session_New1');
        return pageRef;
    }
}