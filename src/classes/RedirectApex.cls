public with sharing class RedirectApex {
    private ApexPages.StandardController controller;

    public RedirectApex(ApexPages.StandardController controller){
        this.controller = controller;
    }

    public PageReference redirect(){
         PageReference nextPage = new PageReference('/' + '0017F00000Gsyz1');
        return nextPage;
    }
}