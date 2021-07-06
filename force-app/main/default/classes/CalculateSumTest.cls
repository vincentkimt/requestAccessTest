@isTest
public class CalculateSumTest {
	//Use below way to declare a test method
    @isTest
    static void testSum(){
        CalculateSum obj = new CalculateSum();
        obj.sum(10, 20);
        System.assertEquals(20, obj.c);//error bcs actual is 30 and we are giving 20
    }
    
    //OR below way to make atest method. Note: there's no annotation below method.
    static testMethod void testFindMaximum(){
          CalculateSum obj = new CalculateSum();
        obj.maxNumber(98,66);
        System.assertEquals(98, obj.max);
        obj.maxNumber(99, 100);
        System.assertEquals(100, obj.max);

    }
}