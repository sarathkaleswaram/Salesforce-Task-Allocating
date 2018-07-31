global class updateAccountPhone implements Database.Batchable<sObject> {
	
	String query;
	
	global updateAccountPhone() {
		
	}
	
	global Database.QueryLocator start(Database.BatchableContext BC) {
		string query = 'select Id,Phone,Maximum_contacts__c from Account';
		return Database.getQueryLocator(query);
	}

   	global void execute(Database.BatchableContext BC, List<Account> scope) {
   		for(Account acc : scope){
   			acc.Phone ='9989927539';
   			acc.Maximum_contacts__c=8;
   			system.debug('oooooooooooooooooooooooooooo'+scope);
   		}
		update scope;
	}
	
	global void finish(Database.BatchableContext BC) {
		
	}
	
}