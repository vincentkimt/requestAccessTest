public class Assignment2Apex {

    
    public static void getOpportunitiesWithAccId(){
        Map<Id,String> mapOfAcOp = new Map<Id,String>();
        for(Opportunity opp : [SELECT AccountId,Id FROM opportunity WHERE AccountId  != NULL]){
            mapOfAcOp.put(opp.AccountId,opp.Id);
        }
    }
}