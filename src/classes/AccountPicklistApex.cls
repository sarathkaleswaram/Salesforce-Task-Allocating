public class AccountPicklistApex {

    Public string selectedname{get;set;}
    public list<account> arecs{get;set;}
        Public List<Selectoption> getselectedaccnamefields(){
            List<Selectoption> pickname = new List<selectoption>();
            pickname.add(new selectOption('', '- None -'));
            for(Account acc :[select id,name from Account Limit 5]){
            pickname.add(new selectoption(acc.id,acc.name));
            }
            return pickname; 
        }
    public void fetch(){
        list<list<sobject>> lf=[find:selectedname in all fields returning account(id,name,billingcity,phone)];
    
    
    arecs=[select id,name,billingcity,phone from account where name=:selectedname];
    }
}