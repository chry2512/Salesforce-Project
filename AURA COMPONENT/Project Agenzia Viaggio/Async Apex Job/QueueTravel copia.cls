/**
 * @description       :
 * @author            : Christian Niro
 * @group             :
 * @last modified on  : 01-23-2023
 * @last modified by  : 
 **/
public class QueueTravel implements Queueable{
    String accEmail;
    String accName;
    String emailBody;
    public QueueTravel(String accEmail, String accName){
        this.accEmail = accEmail;
        this.accName = accName;
    }

    public void execute(QueueableContext context){

        List<Viaggio__c> vgg = [SELECT Id, Name, Periodo__c, Prezzo__c, Status__c, Number_Of_Reservartion__c, Select__c
                                FROM Viaggio__c];

        for (Viaggio__c v : vgg){

            v.Select__c = false;

        }

        update vgg;


        emailBody = 'Salve,\n\n' + accName + '\n\n il suo viaggio è stato correttamente prenotato \n\n' + '\n\nSaluti,' + '\n\nTrivago';

        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();

        mail.setSenderDisplayName('Trivago');
        mail.setSubject('Prenotazione Effettuata');
        mail.setSaveAsActivity(false);
        mail.setPlainTextBody(emailBody);
        mail.setToAddresses(new String[]{ accEmail });

        System.debug('### MAIL: ' + mail);

        if (!Test.isRunningTest()){
            Messaging.sendEmail(new Messaging.SingleEmailMessage[]{ mail });
        }
    }

}
