public with sharing class PM_MyTaskEdit_Controller {

	private final Job__c job;
    public Project__c project{get;set;}
    public Integer footageValue{get;set;}
    public Integer hoursValue{get;set;}
    public Integer jobsValue{get;set;}
    public Integer milesValue{get;set;}
    public Integer nodesValue{get;set;}
    public Integer unitsValue{get;set;}

    // The extension constructor initializes the private member
    // variable mysObject by using the getRecord method from the standard
    // controller.
    public PM_MyTaskEdit_Controller(ApexPages.StandardController stdController) {
        this.job = (Job__c)stdController.getRecord();
        project = [select Name,OffshoreProjectManager__c,Team_Lead__c,Client__c,Footage__c,Hours__c,Jobs__c,Miles__c,Nodes__c,Units__c from Project__c where Id =: job.MasterTest__c];
    }

    public String getRecordName() {
        return 'Hello ' + (String)job.get('name') + ' (' + (Id)job.get('Id') + ')';
    }

    public PageReference customSave(){
        update job;
        return new PageReference('/apex/PM_MyTaskPage');
    }
}