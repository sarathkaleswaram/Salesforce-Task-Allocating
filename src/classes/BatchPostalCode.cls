global class BatchPostalCode implements Database.Batchable<sObject> {
	
	String query;
	
	global BatchPostalCode() {
		
	}
	
	global Database.QueryLocator start(Database.BatchableContext BC) {
		String query = 'Select Id,Name from Account';
		system.debug('================================'+query);
		return Database.getQueryLocator(query);
	}

   	global void execute(Database.BatchableContext BC, List<Account> scope) {
   		for(Account acc : scope){
   			if(acc.Name == 'Bhavana Reddy'){
   				acc.Phone = '123456';
   			}
   		}system.debug('--------------------------------'+scope);
		update scope;
	}
	
	global void finish(Database.BatchableContext BC) {
		
	}
	
}