public with sharing class requestAccessCustomerHandler {
    public static final String ACCESS_KEY='?access_key=500658dbfd071f71084405dbd4aab7b2';
    public static final String METHOD='validate';
    
    @AuraEnabled
    public static Map<String,String> verifyVAT(String searchKey) {
        


        Boolean vatStatus=true;
        map<String,String> mapReturn = new map<String,String>();
        String vatCompanyAddress;
        String vatCompanyName;
        System.debug('vat number-'+searchKey);
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        String vatNumber='&vat_number='+searchKey;
        request.setEndpoint('callout:vatLayer'  + ACCESS_KEY  + vatNumber );
        request.setMethod('GET');
        HttpResponse response = http.send(request);
       
        if (response.getStatusCode() == 200) {
            // Deserialize the JSON string into collections of primitive data types.
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            // Cast the values in the 'body' key as a list
            vatStatus = (Boolean) results.get('valid');
            if(vatStatus){
                mapReturn.put('Status','Valid');
                vatCompanyName=(String) results.get('company_name');
                mapReturn.put('Company Name',vatCompanyName);
                vatCompanyAddress=(String) results.get('company_address');
                mapReturn.put('Company Address',vatCompanyAddress);
            }else{
                mapReturn.put('Status','Invalid VAT number');
            }
           
            
        } 
/*
        mapReturn.put('Status','Valid');
        mapReturn.put('Company Name','vatCompanyName');
        mapReturn.put('Company Address','vatCompanyAddress');
       */
       
        return mapReturn;
    }

    @AuraEnabled
    public static String insertCustomer(CustomWrapperCustomer wrapper) {
        
        String returnStr=wrapper.companyName + ',' + 
                        wrapper.country + ',' +
                        wrapper.companyAddress + ',' +
                        wrapper.companyZipCode + ',' +
                        wrapper.companyCity + ',' +
                        wrapper.region + ',' +
                        wrapper.companyEmail + ',' +
                        wrapper.vatNumber ;


        
        Customer__c customer=new Customer__c();
        customer.Name=wrapper.companyName;
        customer.Country__c=wrapper.country;
        customer.Company_Address__c = wrapper.companyAddress;
        customer.Company_ZipCode__c = wrapper.companyZipCode;
        customer.Company_City__c=wrapper.companyCity;
        customer.Company_Region__c=wrapper.region;
        customer.VAT_Number__c=wrapper.vatNumber;

        customer.Company_Email__c=wrapper.companyEmail;
        Insert customer;
        
        return returnStr;
    }
        


}