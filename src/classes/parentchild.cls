public class parentchild {
    public list<Account> acclist{get;set;}
    public Contact Contact{get;set;}
    public string var{get;set;}
    public String contactLastName{get;set;}
    public String contactPhone{get;set;}
    public String accountName{get;set;}
    public String email{get;set;}
    
    public parentchild(){
        acclist = [select name,id,(select id,lastname,Phone from Contacts) from Account];
    }
    public void resetMethod(){
        var='';
    }
    public void insertMethod(){
        Contact con = new Contact();
        con.LastName = contactLastName;
        con.Phone = contactPhone;
        con.AccountId = Contact.AccountId;
        Insert con;
    }
    public PageReference sendEmail(){
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        string[] to = new string[]{'pradeep.mounik@gmail.com'};
            string[] Cc = new string[]{email};
         mail.setToAddresses(to);
        mail.setCcAddresses(Cc);
        mail.setSubject('mail vachindi roiii');
        mail.setPlainTextBody('manchigunnavaaa....');
        Messaging.sendEmail(new Messaging.SingleEmailMessage[]{mail});            
        return page.welcome3;
    }
}