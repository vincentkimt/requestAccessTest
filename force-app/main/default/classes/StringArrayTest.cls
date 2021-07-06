public class StringArrayTest {

    public static List<String> generateStringArray(Integer tracker){
        List<String> stringList = new List<String>();
        Integer counter=0;
        while(tracker>0){
            stringList.add('Test '+counter++);
            tracker--;
        }
        return stringList;
    }
}