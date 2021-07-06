public class LoginUtilityController {
   public LoginUtilityController(){
       
   }
   public PageReference createLogin(){
       LoginObject__c obj = new LoginObject__c();
       obj.User__c = UserInfo.getUserId();
       obj.DateTime__c = System.now();
       insert obj;
       PageReference pageRef = new PageReference('/apex/VFDemo4');
       return pageRef;
   }
}