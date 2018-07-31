public with sharing class PM_Job_New_Controller {

    private Job__c job;
    private List<Project__c> projectList{get;set;}
    public Id cpCode{get;set;}
    public Project__c project{get;set;}
    public String jobCriticality{get;set;}
    public Id production_resource{get;set;}
    public Id qc_resource{get;set;}
    public Id qa_resource{get;set;}
    public Id delivery_resource{get;set;}

    // The extension constructor initializes the private member
    // variable mysObject by using the getRecord method from the standard
    // controller.
    public PM_Job_New_Controller(ApexPages.StandardController stdController) {
        this.job = (Job__c)stdController.getRecord();
        projectList = [select Company_project_code__c from Project__c];
        List<Event> task = Database.query('select '+getAllFields('Event')+' from Event');        
        system.debug('------------------------------------'+task);
    }

    public List<SelectOption> getCompanyProjectCode(){
        List<SelectOption> cpcso = new List<SelectOption>();
        for(Project__c pro : projectList){
            cpcso.add(new SelectOption(pro.Id,pro.Company_project_code__c));
        }
        return cpcso;
    }

    public static void test(){
      TaskAndHoursSplitBatch thb = new TaskAndHoursSplitBatch();
      database.executeBatch(thb);
      /* List<Job__c> jobList =  Database.query('select '+getAllFields('Job__c')+' from Job__c');
       List<Job__c> jobToSave = new List<Job__c>();
       List<Task> taskToSave = new List<Task>();

       for(Job__c job : jobList){
            Project__c project =  [select Production__c,QA__c,QC__c,Delivery__c,OffshoreProjectManager__c from Project__c where Id =: job.MasterTest__c ];
            
            Task t = new Task();
            if(job.Job_Stage__c == 'Production')
                t.OwnerId = job.Production_Resource__c;
            else if(job.Job_Stage__c == 'QC')
                t.OwnerId = job.QC_Resource__c;
            else if(job.Job_Stage__c == 'QA')
                t.OwnerId = job.QA_Resource__c;
            else if(job.Job_Stage__c == 'Delivery')
                t.OwnerId = job.Delivery_Resource__c;
            else
                t.OwnerId = project.OffshoreProjectManager__c;
            
            t.WhatId = job.Id;
            t.Subject = job.Job_ID__c;
            t.ActivityDate = job.Expected_Delivery__c;
            t.Status = job.Job_Status__c;
            t.Priority = job.Job_Criticality__c;
            t.Description = job.Remarks__c;
            taskToSave.add(t);

            job.Production_Hours_Estimated__c = Project.Production__c * job.Estimated_Total_Job_Hours__c /100;
            job.QA_Hours_Estimated__c = Project.QA__c* job.Estimated_Total_Job_Hours__c /100;
            job.QC_Hours_Estimated__c = Project.QC__c* job.Estimated_Total_Job_Hours__c /100;
            job.Delivery_Hours_Estimated__c = Project.Delivery__c* job.Estimated_Total_Job_Hours__c /100;
            
            if(job.Job_Stage__c == 'Production')
                job.Assigned_To__c = job.Production_Resource__c;
            else if(job.Job_Stage__c == 'QC')
                job.Assigned_To__c = job.QC_Resource__c;
            else if(job.Job_Stage__c == 'QA')
                job.Assigned_To__c = job.QA_Resource__c;
            else if(job.Job_Stage__c == 'Delivery')
                job.Assigned_To__c = job.Delivery_Resource__c;
            else
                job.Assigned_To__c = project.OffshoreProjectManager__c;

            jobToSave.add(job);
       }
       upsert taskToSave;
       upsert jobToSave;
       */
    }

    public void autoFill(){
        project = Database.query('select '+getAllFields('Project__c')+' from Project__c where Id =: cpCode');
    }

    public List<SelectOption> getUsersInProject(){
        List<SelectOption> ufp = new List<SelectOption>();
        List<ProjectJobAssociation__c> userInProject = [select ProjectLink__c,UserLink__c from ProjectJobAssociation__c where ProjectLink__c =: cpCode];
        for(ProjectJobAssociation__c pja : userInProject){
            User user = [select LastName from User where Id =: pja.UserLink__c];
            ufp.add(new SelectOption(pja.UserLink__c,user.LastName));
        }
        return ufp;
    }

    public void estimHoursMethod(){
        double estim_total_time = job.Estimated_Total_Job_Hours__c;
        job.Production_Hours_Estimated__c = estim_total_time * project.Production__c / 100;
        job.QC_Hours_Estimated__c = estim_total_time * project.QC__c / 100;
        job.QA_Hours_Estimated__c = estim_total_time * project.QA__c / 100;
        job.Delivery_Hours_Estimated__c = estim_total_time * project.Delivery__c / 100;
    }

    public PageReference customSave(){
        job.MasterTest__c = project.Id;
        job.Production_Resource__c = production_resource;
        job.QC_Resource__c = qc_resource;
        job.QA_Resource__c = qa_resource;
        job.Delivery_Resource__c = delivery_resource;
        job.Job_Criticality__c = jobCriticality;
         if(job.Job_Stage__c == 'Production')
            job.Assigned_To__c = job.Production_Resource__c;
        else if(job.Job_Stage__c == 'QC')
            job.Assigned_To__c = job.QC_Resource__c;
        else if(job.Job_Stage__c == 'QA')
            job.Assigned_To__c = job.QA_Resource__c;
        else if(job.Job_Stage__c == 'Delivery')
            job.Assigned_To__c = job.Delivery_Resource__c;
        else
            job.Assigned_To__c = project.OffshoreProjectManager__c;

        try{
            insert job;    
        }
        catch(Exception e){
            ApexPages.addMessages(e);
        }

      /*  Task t = new Task();
        if(job.Job_Stage__c == 'Production')
            t.OwnerId = job.Production_Resource__c;
        else if(job.Job_Stage__c == 'QC')
            t.OwnerId = job.QC_Resource__c;
        else if(job.Job_Stage__c == 'QA')
            t.OwnerId = job.QA_Resource__c;
        else if(job.Job_Stage__c == 'Delivery')
            t.OwnerId = job.Delivery_Resource__c;
        else
            t.OwnerId = project.OffshoreProjectManager__c;
        t.WhatId = job.Id;
        t.Subject = job.Job_ID__c;
        t.ActivityDate = job.Expected_Delivery__c;
        t.Status = job.Job_Status__c;
        t.Priority = job.Job_Criticality__c;
        t.Description = job.Remarks__c;

        Insert t; */

        return new PageReference('/' + job.Id);
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

    /*   Integer count = 0;
                        
    public PageReference incrementCounter() {
            count++;
            return null;
    }
                        
    public Integer getCount() {
        return count;
    } */
}