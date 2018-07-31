public class Arrayapex {
    public String[] str{get;set;}
    public List<Account> acc{get;set;}
    
    public Arrayapex(){
        str = new String[]{'Pradeep','Nikhil','Sharath','Veeresh'};
        Account acc1 = new Account();
        acc1.Name = 'Pradeep';
        acc1.BillingCountry = 'India';
        Account acc2 = new Account();
        acc2.Name = 'Nikil';
        acc2.BillingCountry = 'India';
        acc.add(acc1);
        acc.add(acc2);
        Insert acc;
    }
}