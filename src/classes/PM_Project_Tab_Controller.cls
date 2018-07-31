public with sharing class PM_Project_Tab_Controller {

    public List<Project__c> projectList{get;set;}
    public Map<Id,Boolean> checkboxList{get;set;}
    public Boolean selectAllCheckBox{get;set;}

    // The extension constructor initializes the private member
    // variable mysObject by using the getRecord method from the standard
    // controller.
    public PM_Project_Tab_Controller() {
        projectList = [select Company_project_code__c,Name,Client__c,Project_code__c,OffshoreProjectManager__c,Team_Lead__c,Team_Count__c,Job_Count__c from Project__c];
        system.debug('-'+[select Id from Project__c]);
        selectAllCheckBox = false;
        checkboxList = new Map<Id,Boolean>();
        for(Project__c pro : projectList){
            checkboxList.put(pro.Id, false);
        }
    }

    public PageReference deleteMethod(){
        List<Project__c> prodel = new List<Project__c>();
        for(Id pid : checkboxList.keySet()){
            if(checkboxList.get(pid)){
                Project__c pro = [select name from Project__c where Id =: pid];
                prodel.add(pro);
            }
        }
        delete prodel;
        return new PageReference('/apex/PM_Project_Tab');
    }

    public void selectAll(){
        if(selectAllCheckBox){
            for(Project__c pro : projectList){
                checkboxList.put(pro.Id, true);
            }
        } else {
            for(Project__c pro : projectList){
                checkboxList.put(pro.Id, false);
            }
        }
        
    }
}