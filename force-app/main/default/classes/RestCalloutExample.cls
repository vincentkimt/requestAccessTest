public class RestCalloutExample {

    
    public static HttpResponse restCalloutGET(){//get data from an endpoint.
        Http http=new Http();
        HttpRequest httpRequest=new HttpRequest();
        httpRequest.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals');
        httpRequest.setMethod('GET');
        HttpResponse httpResponse = http.send(httpRequest);
        
        if(httpResponse.getStatusCode() == 200){
            Map<String,Object> result = (Map<String,Object>) JSON.deserializeUntyped(httpResponse.getBody());
            List<Object> animals = (List<Object>) result.get('animals');
             	System.debug('Received the following animals:');
    		for (Object animal: animals) {
      		    System.debug(animal);
   			 }
        }
        return httpResponse;
    }
    
    public static HttpResponse restCalloutPOST(){//post data or create resource at an endpoint.
        Http http=new Http();
        HttpRequest httpRequest = new HttpRequest();
        HttpResponse httpResponse = new HttpResponse();
        httpRequest.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals');
        httpRequest.setMethod('POST');
        httpRequest.setHeader('Content-Type', 'application/json;charset=UTF-8');
        String body = '{"name":"mighty moose"}';
        httpRequest.setBody(body);
        httpResponse = http.send(httpRequest);
        if(httpResponse.getStatusCode() != 201){
           	System.debug('The status code returned was not expected: ' +
       		httpResponse.getStatusCode() + ' ' + httpResponse.getStatus());
		} else {
   			System.debug(httpResponse.getBody());
		}
            
		return httpResponse;
    }
    
}