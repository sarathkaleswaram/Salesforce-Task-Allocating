trigger AccountNumberChangedOrNot on Account (before update) {
for(Account acc:trigger.new){
    Account old = Trigger.oldMap.get(acc.Id);
    if(old.AccountNumber != acc.AccountNumber){
    acc.Description = 'Account no. changed';
   } else{
       acc.Description = 'Account no. not changed';
   }
}

}