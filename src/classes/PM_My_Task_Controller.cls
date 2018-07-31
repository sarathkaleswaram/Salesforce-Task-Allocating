public with sharing class PM_My_Task_Controller {
	public List<Job__c> jobList;
	public Boolean ifNull{get;set;}

	public Integer selectSize{get;set;}
	public Integer total{get;set;}
	public Integer totalRecords = 0;
	public Integer count = 0;
	public Integer limitSize = 20;

	public String search{get;set;}
	public String searchFilter = '';

	public PM_My_Task_Controller() {
		total = totalRecords = [select count() from Job__c where Assigned_To__c =: UserInfo.getUserId()];
		//jobList = [select MasterTest__c,Name,Job_ID__c,Job_Stage__c,Job_Status__c,Assigned_Date__c from Job__c where Assigned_To__c =: UserInfo.getUserId() limit : limitSize offset : count];
		if(total == 0){
			ifNull = true;
		} else {
			ifNull = false;
		}
	}

	public List<Job__c> getjobList(){
		if(search != null && (search).trim() !='')
        {
           searchFilter  = searchFilter + ' where Job_ID__c Like \'' + search + '%\' and ' ;
        }
		jobList = [select MasterTest__c,Name,Job_ID__c,Job_Stage__c,Job_Status__c,Assigned_Date__c from Job__c where Assigned_To__c =: UserInfo.getUserId() limit : limitSize offset : count];
		system.debug('checking');
		return jobList;
	}

	public void updatePage() {
        jobList.clear();
        limitSize = selectSize;
        jobList = [select MasterTest__c,Name,Job_ID__c,Job_Stage__c,Job_Status__c,Assigned_Date__c from Job__c where Assigned_To__c =: UserInfo.getUserId() limit : selectSize offset : count];
    }

    public void first(){
    	count = 0;
    }

    public void previous(){
    	count = count - limitSize;
    }

    public void next(){
    	count = count + limitSize;
    }

    public void last(){
    	count = totalRecords - math.mod(totalRecords,limitSize);
    }

    public Boolean getNxt() {
        if((count+ limitSize) > totalRecords)
            return true;
        else
            return false;
        
    }
    public Boolean getPrv() {
        if(count== 0)
            return true;
        else
            return false;
        
        
    }
}