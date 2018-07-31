global class TaskAndHoursSplitBatch implements Database.Batchable<sObject> {
	
	String query;
	List<Job__c> jobToSave = new List<Job__c>();
    //List<Task> taskToSave = new List<Task>();
	
	global TaskAndHoursSplitBatch() {
		
	}
	
	global Database.QueryLocator start(Database.BatchableContext BC) {
		//query = [select Assigned_To__c,Delivery_Hours_Estimated__c,QC_Hours_Estimated__c,QA_Hours_Estimated__c,Production_Hours_Estimated__c,Production_Resource__c,QC_Resource__c,QA_Resource__c,Delivery_Resource__c,Job_ID__c,Expected_Delivery__c,Job_Status__c,Job_Criticality__c,Remarks__c,Estimated_Total_Job_Hours__c from Job__c];
		query = 'select '+getAllFields('Job__c')+' from Job__c';
		return Database.getQueryLocator(query);
	}

   	global void execute(Database.BatchableContext BC, List<Job__c> scope) {
   		for(Job__c job : scope){
            Project__c project =  [select Production__c,QA__c,QC__c,Delivery__c,OffshoreProjectManager__c from Project__c where Id =: job.MasterTest__c ];
            
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
            taskToSave.add(t);
*/
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
       //insert taskToSave;
       update jobToSave;
	
	}
	
	global void finish(Database.BatchableContext BC) {
		
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