trigger Error on Contact (before delete) {
    for(Contact con:Trigger.Old){
        con.addError('cannot delete contact');
    }

}