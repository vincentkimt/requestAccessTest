@isTest
public class RestCalloutExampleTest {
    
    @isTest static void testGetCallout(){
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        
        mock.setStaticResource('GetAnimalResource');
        mock.setStatusCode(200);
		mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        Test.setMock(HttpCalloutMock.class, mock);
        
        HttpResponse res = RestCalloutExample.restCalloutGET();
        
        System.assertNotEquals(null,res, 'The callout returned a null response');
        
        System.assertEquals(200, res.getStatusCode());
        
        System.assertEquals('application/json;charset=UTF-8',res.getHeader('Content-Type'));
        
        Map<String,Object> mapRes = (Map<String,Object>) Json.deserializeUntyped(res.getBody());
        
        List<Object> resList= (List<Object>) mapRes.get('animals');
        
        System.assertEquals(3,resList.size());

    }
    
    @isTest static void testRestCalloutPOST(){
        
        Test.setMock(HttpCalloutMock.class, new RestCalloutExampleMock());
		
        HttpResponse response = RestCalloutExample.restCalloutPOST();
        
        System.assertEquals('application/json', response.getHeader('Content-Type'));
        String expectedValue = '{"animals": ["majestic badger", "fluffy bunny", "scary bear", "chicken", "mighty moose"]}';
        
        String actualValue = response.getBody();
        
        System.assertEquals(expectedValue,actualValue);
        
        System.assertEquals(200, response.getStatusCode());
    	
        
    }
    

}