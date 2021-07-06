public class CalculateSum {
       
public Integer c;
    public void sum(Integer a, Integer b){
        
        c=a+b;
        System.debug('Sum Of two number is '+c);
    }
    
    public Integer max;
    public void maxNumber(Integer a, Integer b){
         
        if(a>b){
            max=a;
        }else{
            max=b;
        }
    }
}