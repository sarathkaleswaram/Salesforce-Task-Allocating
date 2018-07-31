public with sharing class Project_PM_Controller {
    private final ApexPages.standardController controller;
	private Project__c project;

    public List<SelectOption> selectedUsers{get;set;}
    public List<SelectOption> usersList = new List<SelectOption>();

    public Integer saveAndNew;

    public Project_PM_Controller(ApexPages.StandardController stdController) {
        this.controller = stdController; 
        this.project = (Project__c)stdController.getRecord();
        saveAndNew = 1;
        selectedUsers = new List<SelectOption>();
    }

    public List<SelectOption> getUsersList(){
        List<User> users = [select Id,Name from User where UserRoleId = '00E7F000000Mdri'];
        for(User usr : users){
            usersList.add(new SelectOption(usr.Id,usr.Name));
        }
        return usersList;
    }

    public PageReference customSave(){
        Project__c newProject = new Project__c();
        newProject.Client__c = project.Client__c;
        newProject.End_Customer__c = project.End_Customer__c;
        newProject.Operation_Region__c = project.Operation_Region__c;
        newProject.Work_Region__c = project.Work_Region__c;
        newProject.Client_Project_Manager__c = project.Client_Project_Manager__c;
        newProject.Project_code__c = project.Project_code__c;
        newProject.Company_project_code__c = project.Company_project_code__c;
        newProject.Name = project.Name;
        newProject.Project_Scope__c = project.Project_Scope__c;
        newProject.Cost_Centre__c = project.Cost_Centre__c;
        newProject.OffshoreProjectManager__c = project.OffshoreProjectManager__c;
        newProject.Team_Lead__c = project.Team_Lead__c;
        newProject.Project_Start_Date__c = project.Project_Start_Date__c;
        newProject.Project_End_Date__c = project.Project_End_Date__c;
        newProject.Units__c = project.Units__c;
        newProject.Nodes__c = project.Nodes__c;
        newProject.Footage__c = project.Footage__c;
        newProject.Miles__c = project.Miles__c;
        newProject.Jobs__c = project.Jobs__c;
        newProject.Hours__c = project.Hours__c;
        newProject.Production__c = project.Production__c;
        newProject.QC__c = project.QC__c;
        newProject.QA__c = project.QA__c;
        newProject.Delivery__c = project.Delivery__c;

        newProject.Team__c = '  ';
        for(SelectOption sc : selectedUsers){
            newProject.Team__c += sc.getLabel() + ', ';
        }
        newProject.Team__c = newProject.Team__c.subString(0,newProject.Team__c.length()-2);

        try{
            Insert newProject;  
        } 
        catch(Exception e){
            ApexPages.addMessages(e);
        }

        List<ProjectJobAssociation__c> pjaList = new List<ProjectJobAssociation__c>();
        for(SelectOption sc : selectedUsers){
            ProjectJobAssociation__c pja = new ProjectJobAssociation__c();
            pja.ProjectLink__c = newProject.Id;
            pja.UserLink__c = sc.getValue();
            pjaList.add(pja);
        }
        Insert pjaList;

        if(saveAndNew == 2){ 
            selectedUsers = new List<SelectOption>();
            usersList = new List<SelectOption>();
            PageReference pageRef = new PageReference('/apex/PM_Project_New');
            pageRef.setRedirect(true);
            return pageRef;
            /*
            return new PageReference('/'+ ApexPages.currentPage());*/
        }
        return new PageReference('/'+newProject.Id);
    }

    public void customSaveAndNew(){
        saveAndNew = 2;
        customSave();
    }

}