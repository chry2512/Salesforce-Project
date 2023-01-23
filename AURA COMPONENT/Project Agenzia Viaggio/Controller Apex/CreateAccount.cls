/**
 * @description       :
 * @author            : Christian
 * @group             :
 * @last modified on  : 10-28-2022
 * @last modified by  : 
 **/
public with sharing class CreateAccount{
    @AuraEnabled
    public static void createAccount(Account acc){

        try{

            String name = acc.Name;
            String numeberAcc = acc.AccountNumber;

            List<Account> accounts = [SELECT Name, AccountNumber
                                      FROM Account
                                      WHERE Name = :name AND AccountNumber = :numeberAcc];


            List<Viaggio__c> viaggi = [SELECT Id, Name, Periodo__c, Select__c, Prezzo__c, Status__c, Number_Of_Reservartion__c
                                       FROM Viaggio__c
                                       WHERE Select__c = TRUE
                                       LIMIT 1];


            if (accounts.size() == 0){


                acc.Viaggio__c = viaggi[0].Id;

                insert acc;


            } else{
                throw new AuraHandledException('IMPOSSIBILE INSERIRE ACCOUNT ! Esiste già un Account di Questpo Tipo');
            }

            Id jobId = system.enqueueJob(new QueueTravel(acc.Email_1__c, acc.Name));

        } catch (Exception e){
            throw new AuraHandledException('IMPOSSIBILE INSERIRE ACCOUNT' + e.getMessage());
        }
    }

    @AuraEnabled
    public static List<Viaggio__c> visualizerViaggio(){
        try{

            List<Viaggio__c> vgg = [SELECT Id, Name, Periodo__c, Prezzo__c, Status__c, Number_Of_Reservartion__c, Select__c
                                    FROM Viaggio__c
                                    LIMIT 10];

            return vgg;

        } catch (Exception e){
            throw new AuraHandledException('IMPOSSIBILE VISUALIZZARE VIAGGI DISPONIBILI' + e.getMessage());
        }
    }

    @AuraEnabled
    public static List<Viaggio__c> updateViaggio(String v2Name){
        try{

            List<Viaggio__c> vgg = [SELECT Id, Name, Periodo__c, Prezzo__c, Status__c, Number_Of_Reservartion__c, Select__c
                                    FROM Viaggio__c
                                    WHERE Name = :v2Name
                                    LIMIT 1];

            for (Viaggio__c v : vgg){

                v.Select__c = true;

            }

            update vgg;


            return vgg;


        } catch (Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }

}