trigger JobStageChange on Job__c (before insert, before update) {

	for(Job__c job : Trigger.New){
		Project__c project = [select OffshoreProjectManager__c from Project__c where Id =: job.MasterTest__c];
		if(job.Job_Stage__c == 'Production')
			job.Assigned_To__c = job.Production_Resource__c;
		if(job.Job_Stage__c == 'QC')
			job.Assigned_To__c = job.QC_Resource__c;
		if(job.Job_Stage__c == 'QA')
			job.Assigned_To__c = job.QA_Resource__c;
		if(job.Job_Stage__c == 'Delivery')
			job.Assigned_To__c = job.Delivery_Resource__c;
		if(job.Job_Stage__c == 'Approval')
			job.Assigned_To__c = project.OffshoreProjectManager__c;
							
		if(job.Job_Status__c == 'Completed'){
			if(job.Job_Stage__c == 'Production'){
				job.Job_Stage__c = 'QC';
				job.Job_Status__c = 'Not Started';
				job.Assigned_To__c = job.QC_Resource__c;
			} else if(job.Job_Stage__c == 'QC'){
				job.Job_Stage__c = 'QA';
				job.Job_Status__c = 'Not Started';
				job.Assigned_To__c = job.QA_Resource__c;
			} else if(job.Job_Stage__c == 'QA'){
				job.Job_Stage__c = 'Delivery';
				job.Job_Status__c = 'Not Started';
				job.Assigned_To__c = job.Delivery_Resource__c;
			} else if(job.Job_Stage__c == 'Delivery'){
				job.Job_Stage__c = 'Approval';
				job.Job_Status__c = 'Pending';
				job.Assigned_To__c = project.OffshoreProjectManager__c;
			}
		}
	}
}