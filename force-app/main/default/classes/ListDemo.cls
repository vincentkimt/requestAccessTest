public class ListDemo {

    public ListDemo(){
        List<String> myList = new List<String>();
        List<Account> accountList = new List<Account>();
        List<Student__c> studentList = new List<Student__c>();
        List<String> stringList = new List<String>{'a','b'};
            
        myList.add('c');
        myList.add('d');
        System.debug('the list is '+myList);
        //to check size of list
        System.debug('size of mylist '+myList.size());
        
        //merge two list
        myList.addAll(stringList);
        
        System.debug('List after AddAll '+myList);
        
        //clearing a list
        stringList.clear();
        System.debug('cleared list is stringList'+ stringList.size());

        //get and remove
        myList.remove(2);
        System.debug('element at 1 '+ myList.get(1));
    }
}