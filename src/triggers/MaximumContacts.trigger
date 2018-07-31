trigger MaximumContacts on Contact (Before insert) {

for(Contact con : trigger.new){
    Account accId = [select Maximum_contacts__c from Account where Id =: con.AccountId];
    list<Contact> conlist = [select LastName from Contact where AccountId =: accID.Id];
    if(accId.Maximum_contacts__c <= conlist.size() ){
        con.addError('NO more contacts');
    }

}
}