public class DetectCardNumber {
    
    public static void findCardNumber(){
        //Enter your string at below line-last part.
        //((?:(?:\\d{4}[- ]){3}\\d{4}|\\d{16}))(?![\\d])
        //
   		Matcher pm1 = Pattern.compile('^((3\\d{3})|(4\\d{3})|(5\\d{3})|(6\\d{3}))-?\\d{4}-?\\d{4}-?\\d{4}$').matcher('My credit card number is . Please decode 3123-9999-9282-2722 it.' );
        boolean check1 = pm1.find();
        Matcher pm2 = Pattern.compile('(.*)(\\d{16})(.*)').matcher('My credit card number is 5422323212124432. Please decode it.');
	    boolean check2 = pm2.find();
        if(check1){
        System.debug('masked num - '+'xxxx-xxxx-xxxx-' + pm1.group().substring(15,19));
         }
        else if(!check2){
	        System.debug('masked num - '+'xxxxxxxxxxxx' + pm2.group(2).substring(12,16));
        }
       }
}