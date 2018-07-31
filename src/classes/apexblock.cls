public class apexblock {
    public Boolean showA{get;set;}
    public String labelA{get;set;}
    public boolean showB{get;set;}
    public string labelB{get;set;}
    public string labelAB{get;set;}
    public string check{get;set;}
    public String showAccountName{get;set;}
    public boolean showAccount{get;set;}
    public List<Account> accList{get;set;}
    
    public apexblock(){        
        showA  = false;
        labelA = 'Show A';
        showB  = false;
        labelB = 'Show B';
        labelAB='Show All';
        check = 'initial';
        showAccount = false;
        showAccountName = 'Show Account';
    }
    
    public void showMethod(){
        accList = new List<Account>();
        
        Account acc1 = new Account(Name = 'ListTest1', Rating = 'Hot');
        Account acc2 = new Account(Name = 'ListTest2', Rating = 'Cold');
        
        accList.add(acc1);
        accList.add(acc2);
        
        if(showAccount){
            showAccount = false;
            showAccountName = 'Show Account';
        } else {
        	showAccount = true;            
            showAccountName = 'Hide Account';
        }
                
    }
    
    public void methodA(){
        if(!showA){
            showA = true;
            labelA = 'Hide A';            
        } else {
            showA = false;
            labelA = 'Show A';
        }        
    }
    
    public void methodB(){
        if (showB){
            showB = false;
            labelB = 'Show B';   
        }else{
            showB = true;
            labelB = 'Hide B';
        }
        
    }
    public void methodAB(){
        /*  if(labelAB == 'Show All')
{
methodA();
methodB();
labelAB = 'Hide All';
} else {
methodA();
methodB();
labelAB = 'Show All';
}*/
        /* if(showA && showB){
showA=true;
showB=true;
labelAB='Hide All';
check = 'second';
}
if(!showA && !showB){
showA=true;
showB=true;
labelAB='Hide All';
check = 'first';
}
*/
        if((!showA && !showB) || (showA && !showB) || (!showA && showB)){
            showA = true;
            showB = true;
            labelAB = 'Hide All'; 
            labelA = 'Hide A';
            labelB ='Hide B';
            check = 'if';
        }
        else{
            if(showA && showB){
                showA = false;
                showB = false;
                labelAB = 'Show All';
                labelB = 'Show B';
                labelA = 'Show A';
                check = 'else';}
        }
        
    }
}