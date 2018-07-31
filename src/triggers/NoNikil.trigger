trigger NoNikil on Account (before insert,before update) {

    for(Account acc : Trigger.New){
        if(acc.Name == 'Nikil' ){
                 Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        string[] to = new string[]{'pradeep.mounik@gmail.com'};
        string[] Cc = new string[]{'ksb994@gmail.com'};
        mail.setToAddresses(to);
        mail.setCcAddresses(Cc);
        mail.setSubject('mail vachindi roiii');
        mail.setPlainTextBody('manchigunnavaaa....');
        mail.setTemplateId('00X7F000000DuME');
        Messaging.sendEmail(new Messaging.SingleEmailMessage[]{mail});
        
            acc.addError(' no chillar names plzzz');
        }
        else if(acc.Phone == '9676215627')
            acc.addError(' no chillar phone no. plzzz');
    }
    
        
}