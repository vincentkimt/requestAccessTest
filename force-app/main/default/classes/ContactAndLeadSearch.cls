public class ContactAndLeadSearch {
    public static  List<List< SObject>> searchContactsAndLeads(String name){
        List<List< SObject>> returnedList = new List<List<SObject>>();
        
        returnedList = [FIND 'Smith' IN ALL FIELDS 
                   RETURNING Lead(FirstName,LastName),Contact(FirstName,LastName)];
        
        return returnedList;
    }

}