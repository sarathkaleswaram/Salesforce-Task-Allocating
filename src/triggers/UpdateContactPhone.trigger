trigger UpdateContactPhone on Account (after update) {
    for(Account acc:Trigger.New){
        List<Contact> conlist = [select Id,Phone from Contact where AccountId =: acc.Id];
        for(Contact con:conlist){
        con.Phone=acc.Phone;
        update con;
        
        
        }
    }

}