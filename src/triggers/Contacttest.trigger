trigger Contacttest on Contact (before insert) {
    for(Contact con:Trigger.New){
        con.LastName = 'Mr.'+con.LastName;
    }
}