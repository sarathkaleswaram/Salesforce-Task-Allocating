trigger HoursSplit on Job__c (before insert, after insert) {
    if(Trigger.isBefore){
        for (Job__c job : Trigger.New){
            Project__c project =  [select Production__c,QA__c,QC__c,Delivery__c,OffshoreProjectManager__c from Project__c where Id =: job.MasterTest__c ];
            
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
        }
    }
    
    if(Trigger.isAfter){
        for(Job__c job : Trigger.New){
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
            
            Insert t;
        }
    }
}