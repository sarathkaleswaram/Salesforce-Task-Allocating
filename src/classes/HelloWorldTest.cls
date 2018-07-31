@isTest
private class HelloWorldTest {
    @isTest static void updateLead(){
        Lead myLead = new Lead();
        myLead.FirstName = 'David';
        myLead.LastName = ' Liu';
        myLead.Company = 'Google';
        Insert myLead;
        
        myLead.Company = 'Microsoft';
        Update myLead;
    }
}