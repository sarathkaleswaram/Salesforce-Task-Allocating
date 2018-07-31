trigger Test1 on Account (before insert,before update) {
    for(Account acc:Trigger.New){
        acc.Name='Pradeep';
        acc.Phone='9052976680';
        if(Trigger.IsUpdate){
            if(acc.Phone=='9052976680'){
              acc.Phone='8885272518';
            }
        }
    }
}