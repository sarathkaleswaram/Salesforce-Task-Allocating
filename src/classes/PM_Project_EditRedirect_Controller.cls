public with sharing class PM_Project_EditRedirect_Controller {

	public Project__c mysObject{get;set;}

    // The extension constructor initializes the private member
    // variable mysObject by using the getRecord method from the standard
    // controller.
    public PM_Project_EditRedirect_Controller(ApexPages.StandardController stdController) {
        this.mysObject = (Project__c)stdController.getRecord();
    }

    public String getRecordName() {
        return 'Hello ' + (String)mysObject.get('name') + ' (' + (Id)mysObject.get('Id') + ')';
    }

    public PageReference redirectToAnotherVisualforcePage(){
        PageReference newpage = new PageReference ('/apex/PM_Project_Edit');
        newpage.getParameters().put('pid',mysObject.Id);
        newpage.setRedirect(true);
        return newpage;
    }
}