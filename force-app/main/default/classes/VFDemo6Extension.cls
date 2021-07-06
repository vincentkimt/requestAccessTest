public class VFDemo6Extension {
    public boolean displayBanner{get;set;}
    public List<Account> listAccount {get;set;}
    public VFDemo6Extension(ApexPages.StandardController controller){
        listAccount=new List<Account>();
        
        for(Account acc : [SELECT Id,Name,Rating FROM Account LIMIT 10 ]){
            listAccount.add(acc);
        }
    }
    
    public void showBanner(){
        displayBanner=true;
    }
}