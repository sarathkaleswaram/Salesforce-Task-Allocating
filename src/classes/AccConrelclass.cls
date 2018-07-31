public class AccConrelclass {
    public List<Contact> conlist{get;set;}
    
    public AccConrelclass(){
        conlist = [select Name,Account.name,Account.Industry from Contact];
    }

}