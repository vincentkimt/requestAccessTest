public class MapDemo {

    public MapDemo(){
        //Initialize a map
        Map<String,String> stringMap = new Map<String,String>();
        Map<Id,Account> accMap = new Map<Id,Account>();
        Map<Id, List<Contact>> accIdtoContactMap = new Map<Id, List<Contact>>();
        //adding value to map using put method.
        stringMap.put('key1', 'value1');
        
        //get a value
        System.debug('a value of key key1 '+ stringMap.get('key1'));//pass a key
        //get map size
        System.debug('size of map  '+ stringMap.size());
        
        System.debug('String map contains a key1? ' + stringMap.containsKey('key1'));//true or false
        
        set<String> setOfKeys = stringMap.keySet();
        
        //get all values
        List<String> listOfValues= stringMap.values();
        
        stringMap.clear();//clear all content of Map
        
        
    }
    
    public MapDemo(String codeName){//codename to differentiate within inside it. Pass 'accountIdtoContactMap' to run this one
        if(codeName == 'accountIdtoContactMap'){
        Map<Id,List<Contact>> accountIdtoContactMap = new Map<Id,List<Contact>>();
        Set<Id> accountIdSet = new Set<Id>();
           
        for(Account acc : [SELECT Id FROM Account WHERE Active__c = 'Yes']){
                
			accountIdSet.add(acc.Id);
        }
        
        for(Contact con : [SELECT Id, Name,accountId FROM Contact WHERE accountId IN: accountIdSet]){
            if(!(accountIdtoContactMap.containsKey(con.AccountId))){
                accountIdtoContactMap.put(con.AccountId,new List<Contact>());
            }
            accountIdtoContactMap.get(con.AccountId).add(con);
        }
        System.debug('Displaying values inside the map');//TODO 
        for(Id accList : accountIdtoContactMap.keySet()){
            System.debug('value');
        }
        
    }
        else if(codename == 'anotherWayOfDoingIt'){
         Map<Id,List<Contact>> accountIdtoContactMap = new Map<Id,List<Contact>>();
			//below query will give a List already made using query. so we don't have to check it using if condition.
            for( Account acc : [SELECT Id, (SELECT Id,Name FROM Contacts) FROM Account WHERE Active__c='Yes']){
                accountIdtoContactMap.put(acc.Id, acc.Contacts);//'Contacts' is a child relationship name. It is the list returned by inner query.
            }
            
        }
        
        
    }
}