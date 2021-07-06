public class AccountHandler {

    public static Account insertNewAccount(String Account_name){
        Account accNew = new Account(Name=Account_name);
        
        try{
            insert accNew;
            System.debug('Record Inserted Successfuly');
            return accNew;
        }
        catch(DmlException e){
            System.debug('A DML exception has occurred: ' +
                e.getMessage());
            return null;
            
        }
    }
}