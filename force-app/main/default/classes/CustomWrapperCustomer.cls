public with sharing class CustomWrapperCustomer {
 
    @AuraEnabled
    public String companyName { get; set; }
    @AuraEnabled
    public String country {get; set; }
    @AuraEnabled
    public String companyAddress { get; set; }
    @AuraEnabled
    public String companyZipCode { get; set; }
    @AuraEnabled
    public String companyCity { get; set; }
    @AuraEnabled
    public String region { get; set; }
    @AuraEnabled
    public String companyEmail { get; set; }
    @AuraEnabled
    public String vatNumber { get; set; }



}
