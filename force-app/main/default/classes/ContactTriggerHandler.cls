public class ContactTriggerHandler {
    
    public static void checkDuplicate(List<Contact> dups,Map<Id,Contact> oldMap){
        
        Set<String> fNameSet = new Set<String>();
        Set<String> lNameSet = new Set<String>();
        Set<Date> dobSet = new Set<Date>();
        Set<String> emailSet = new Set<String>();
        for(Contact con : dups){
            if(oldMap==NULL || 
               con.FirstName != oldMap.get(con.Id).FirstName ||
               con.LastName != oldMap.get(con.Id).LastName||
               con.Email != oldMap.get(con.Id).Email ||
               con.BirthDate != oldMap.get(con.Id).BirthDate){//if condition so that it will run only if fname,lname,email,dob is changed and nothing else
                   
                   fNameSet.add(con.FirstName);
                   lNameSet.add(con.LastName);
                   emailSet.add(con.Email);
                   dobSet.add(con.Birthdate);
               }
        }
        
        Set<String> allContactSet=new Set<String>();
        
        
        if(fNameSet.size()>0){
            for(Contact con : [SELECT Id,FirstName, LastName, Email, Birthdate
                               FROM Contact
                               WHERE FirstName IN: fNameSet AND LastName IN: lNameSet 
                               AND Email IN: emailSet AND Birthdate IN: dobSet]){
                                   
                                   
                                   allContactSet.add(con.FirstName + con.LastName + con.Email +  con.Birthdate);
                                   
                                   
                                   
                               }
            for(Contact con : dups){
                String temp = con.FirstName + con.LastName + con.Email + con.Birthdate;
                if(allContactSet.contains(temp)){
                    con.addError('Dup Value');
                }
                else{
                    allContactSet.add(temp);
                }
            }
        }
        
    }
    
    public static void createCandidate(List<Contact> conList){
        List<Candidate__c> candList = new List<Candidate__c>();
        Candidate__c can;
        for(Contact con: conList){
            can=new Candidate__c();
            can.Name='ChildOf-'+con.name;
            can.Contact__c=con.Id;
                candList.add(can);
                
        }
        if(candList.size()>0){
            Insert candList;
        }
    }
}