@isTest
public class ParkLocatorTest {
		
    @isTest static void testCallout(){
         Test.setMock(WebServiceMock.class, new ParkServiceMock());
        
        String[] nameOfPark = ParkLocator.country('India');
        String parkName1=nameOfPark[0];
        System.assertEquals(parkName1,'park1');
        
    }
}