trigger CreatingAcctOnSalesforce on Salesforce__c (before insert) {
   Account acc = new Account();
    for(Salesforce__c sales : Trigger.New){
        acc.Name = sales.Name;
        acc.Phone = sales.Phone__c;
        
    }
    insert acc;
    Contact con = new Contact();
    Opportunity opp = new Opportunity();
    con.AccountId = acc.Id;
    con.LastName = acc.Name;
    con.Phone = acc.Phone;
    insert con;
}