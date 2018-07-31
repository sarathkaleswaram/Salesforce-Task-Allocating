public with sharing class CustomObjectApex {
    
    public string accountId{get;set;}
    private final Salesforce__c myObject;
    
    public CustomObjectApex(ApexPages.StandardController stdController){
        this.myObject = (Salesforce__c)stdController.getRecord();
        
        accountId = ApexPages.currentPage().getParameters().get('aid');
        myObject.Account__c=accountId;
    }
    public PageReference methodsave(){
     	salesforce__c Salesforce = new Salesforce__c();
        Salesforce.Name=myObject.Name;
        Salesforce.Branch__c=myObject.Branch__c;
        Salesforce.Date__c=myObject.Date__c;
        Salesforce.Phone__c=myObject.Phone__c;
        Salesforce.Account__c=myObject.Account__c;
        insert Salesforce;
 	return new PageReference('/'+myObject.Account__c);
    }
    
}