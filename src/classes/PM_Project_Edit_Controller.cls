public with sharing class PM_Project_Edit_Controller {

	public Project__c project{get;set;}
    public String pName{get;set;}

    public List<SelectOption> selectedUsers{get;set;}
    public List<SelectOption> usersList = new List<SelectOption>();
    public String nonSelectedUserId = '(';

    public PM_Project_Edit_Controller(ApexPages.StandardController stdController) {
        this.project = (Project__c)stdController.getRecord();
        Id pid = ApexPages.currentPage().getParameters().get('pid');
        /*Project__c project = [select Id,name from Project__c where Id=: pid];
        pName = project.name;*/

        project = Database.query('select '+getAllFields('Project__c')+' from Project__c where Id = :pid');
        pName = project.name;

        List<ProjectJobAssociation__c> pja = [select Name,UserLink__c from ProjectJobAssociation__c where ProjectLink__c =: pid];      
        selectedUsers = new List<SelectOption>();
        for(ProjectJobAssociation__c spja : pja){
            User user1 = [select Id,Name from User where Id =: spja.UserLink__c];
            nonSelectedUserId += '\'' + user1.Id + '\',';
            selectedUsers.add(new SelectOption(spja.UserLink__c,user1.Name));
        }
        nonSelectedUserId = nonSelectedUserId.subString(0,nonSelectedUserId.length()-1);
        if(!pja.isEmpty()){
            nonSelectedUserId += ')';
        } else {
            nonSelectedUserId = '(\'\')';
        }
    }

    public List<SelectOption> getUsersList(){
        UserRole userRole = [select Id,Name from UserRole where Name='Software Engineer'];
        Id userRoleId = userRole.Id;
        List<User> users = Database.query('select Id,Name from User where UserRoleId =: userRoleId and Id not in ' + nonSelectedUserId);
        for(User usr : users){
            usersList.add(new SelectOption(usr.Id,usr.Name));
        }
        return usersList;
    }

    public PageReference customSave(){
        project.Team__c = '  ';
        for(SelectOption sc : selectedUsers){
            project.Team__c += sc.getLabel() + ', ';
        }
        project.Team__c = project.Team__c.subString(0,project.Team__c.length()-2);

        try{
            upsert project;  
        } 
        catch(Exception e){
            ApexPages.addMessages(e);
        }

        List<ProjectJobAssociation__c> pjaList = [select Id from ProjectJobAssociation__c where ProjectLink__c =: project.Id];
        Delete pjaList;

        pjaList = new List<ProjectJobAssociation__c>();
        for(SelectOption sc : selectedUsers){
            ProjectJobAssociation__c pja = new ProjectJobAssociation__c();
            pja.ProjectLink__c = project.Id;
            pja.UserLink__c = sc.getValue();
            pjaList.add(pja);
        }
        Insert pjaList; 

        return new PageReference('/'+ project.Id);
    }

    public String getRecordName() {
        return 'Hello ' + (String)project.get('name') + ' (' + (Id)project.get('Id') + ')';
    }

    public static String getAllFields(String sobjectname){
        if(!Schema.getGlobalDescribe().containsKey(sobjectname)) 
        return 'Exception';
        //return new Map<String, String>{'Exception' => 'Invalid object name'};
        Map<String, Schema.SObjectField> fields = Schema.getGlobalDescribe().get(sobjectname).getDescribe().SObjectType.getDescribe().fields.getMap();
        List<String> accessiblefields = new List<String>();
        for(Schema.SObjectField field : fields.values()){
            if(field.getDescribe().isAccessible())
                accessiblefields.add(field.getDescribe().getName());
        }
        String allfields='';
        for(String fieldname : accessiblefields)
            allfields += fieldname+',';
  
        allfields = allfields.subString(0,allfields.length()-1);
        //return new Map<String, String>{sobjectname => allfields};
        return allfields;
    }
}