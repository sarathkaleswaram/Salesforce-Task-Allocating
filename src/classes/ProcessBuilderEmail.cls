public class ProcessBuilderEmail {
    @InvocableMethod(label='Send email' )
    public static void Email(){
        /*  Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
string[] to = new string[]{'pradeep.mounik@gmail.com'};
string[] Cc = new string[]{'ksb994@gmail.com'};
mail.setToAddresses(to);
mail.setCcAddresses(Cc);
mail.setSubject('mail vachindi roiii');
mail.setPlainTextBody('manchigunnavaaa....');
mail.setTemplateId('00X7F000000DuME');
Messaging.sendEmail(new Messaging.SingleEmailMessage[]{mail});  */          
        EmailTemplate templateId = [Select id from EmailTemplate where name = 'Apex test'];
        List<Messaging.SingleEmailMessage> allmsg= new List<Messaging.SingleEmailMessage>();
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        string[] to = new string[]{'pradeep.mounik@gmail.com'};
            string[] Cc = new string[]{'ksb994@gmail.com'};
                mail.setToAddresses(to);
        mail.setCcAddresses(Cc);
        mail.setTemplateId(templateId.Id);
        // mail.setTargetObjectId(AccountId);
        mail.setSaveAsActivity(false);
        allmsg.add(mail);
        Messaging.sendEmail(allmsg,false);
    }
}