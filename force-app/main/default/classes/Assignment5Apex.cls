public class Assignment5Apex {
    
    public void descriptionOfObject(){
            
    // sObject types to describe
    String[] types = new String[]{'Account','Student__c'};
    
    // Make the describe call
    Schema.DescribeSobjectResult[] results = Schema.describeSObjects(types);
    
    System.debug('Got describe information for ' + results.size() + ' sObjects.');
    
    // For each returned result, get some info
    for(Schema.DescribeSobjectResult res : results) {
        System.debug('sObject Label: ' + res.getLabel());
        System.debug('Number of fields: ' + res.fields.getMap().size());
        System.debug(res.isCustom() ? 'This is a custom object.' : 'This is a standard object.');
        // Get child relationships
        Schema.ChildRelationship[] rels = res.getChildRelationships();
        if (rels.size() > 0) {
            System.debug(res.getName() + ' has ' + rels.size() + ' child relationships.');
        }
        System.debug('field name : ' + res.fieldsets);
    }
        
        Schema.DescribeSObjectResult r = Account.sObjectType.getDescribe();
		List<String>apiNames =  new list<String>();
		for(string apiName : r.fields.getMap().keySet()){
           if(apiName.contains('modi'))
           { apiNames.add(apiName);}
        }
        System.debug(apiNames);
    }
 }