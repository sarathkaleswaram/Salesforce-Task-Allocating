trigger UpdateTitle on Account (after insert){

    for(Account acc : Trigger.New){
        Contact con  = new Contact();
        con.LastName = acc.Name;
        con.Phone    = '1234566778';
        con.AccountId  = acc.Id;
        if(acc.AnnualRevenue < 25000){
            con.Title = 'Junior';     
        }
        else{
            con.Title = 'senior';
        }
        insert con;
   }
   
}