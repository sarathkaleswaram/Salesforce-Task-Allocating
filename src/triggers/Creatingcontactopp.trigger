trigger Creatingcontactopp on Account (after insert) {
    for(Account acc:Trigger.New ){

        Contact con     = new Contact();
        Opportunity opp = new Opportunity();
        opp.Account     = acc;
        opp.Name        = acc.Name;
        opp.closedate   = System.today();
        opp.stagename   = 'Qualification';
        con.LastName    = acc.name;
        con.AccountId   = acc.Id;
        opp.AccountId   = acc.Id;
        
        con.Account     = acc;
        insert con;
        insert opp;

    }
}