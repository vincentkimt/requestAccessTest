public class FetchCustomSetting {
    
    public FetchCustomSetting(){
        
        List<String> csObjName=new List<String>();
        
        AuditTrailEmail__c mc = AuditTrailEmail__c.getOrgDefaults();
        System.debug('in AuditTrailEmail__c	 = '+mc.demoField__c);
        
        Map<String, Schema.SObjectType> gd = Schema.getGlobalDescribe();
        
        for(Schema.SObjectType thisObj : gd.values()) {
            if(thisObj.getDescribe().isCustomSetting()){
            System.debug(thisObj.getDescribe());
                csObjName.add(thisObj.getDescribe().getName());
                
            }
        }
        
    }
    
}