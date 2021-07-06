public class trycatchloop {
        string s='ho';
    
    {
        string s='helu';
        {
        }
    }
    
    public static void trywithloop(){
        
        for(Integer i=1;i<10;i++){
            
            try{
                if(i==5){
                    throw new NullPointerException();
                }
                System.debug('printing-i-'+i);
            }
            catch(Exception e){
                System.debug('exception-'+e.getMessage());
            }
        }
    }
    
    
    public void scopeVariable(){
        Integer i=1;
        String s='h';
        {
            Integer b=11;
            System.debug('i inside block-'+i);
        }
        {
            Integer b=11;
            SYstem.debug('b-'+b);
        }
        {
            System.debug('s-'+s);
           	Decimal theValue;
        	System.debug('thevalue-'+theValue);
            {
              //  integer theValue;
            }
        }
        
List<Account> acc = [SELECT Id FROM Account LIMIT 10];
Delete acc;
Database.emptyRecycleBin(acc);
System.debug(Limits.getLimitQueries()+';'+Limits.getLimitDmlStatements());
    Account ac=[SELECT Id,percentage__c FROM Account WHERE id='0016F000030uws9QAA'];
    Decimal percentage_mod = (ac.percentage__c * 100);
      System.debug(ac.percentage__c +'percentage-='+percentage_mod);
        Double x = 5;
        System.debug('double can take integer-'+x);
        Opportunity opp =[select id,StageName from opportunity limit 1];
        
        System.debug('-/-'+Opportunity.StageName.getDescribe().getLabel());
    }
    
    

}