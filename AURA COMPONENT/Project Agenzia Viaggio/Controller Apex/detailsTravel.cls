/**
 * @description       :
 * @author            : Christian Niro
 * @group             :
 * @last modified on  : 10-17-2022
 * @last modified by  : 
 **/
public class detailsTravel{
    @AuraEnabled
    public static List<String> getAllObjects(){

        List<String> SobjectList = new List<String>();

        for (Schema.SObjectType objTyp : Schema.getGlobalDescribe().values()){
            String name = objTyp.getDescribe().getName();

            if (!name.containsIgnoreCase('history') && !name.containsignorecase('tag') && !name.containsignorecase('share') && !name.containsignorecase('feed')){
                SobjectList.add(name);
                System.debug('Name : ' + name);


            }
        }

        return SobjectList;
    }
    
    @AuraEnabled
    public static List<String> getAllTravel(String fld){
        // List<String> fieldList = new List<String>();
        List<String> SobjectList = new List<String>();

        String query = 'SELECT Id, Name, Periodo__c, Prezzo__c, Status__c, ECU_Number_Of_Reservartion__c, Select__c  FROM ' + fld + ' LIMIT 10 ';

        System.debug('query' + query);


        List<Viaggio__c> vgg = Database.query(query);

            for (Viaggio__c v : vgg){
             String name = String.valueOf(v.Name);

             SobjectList.add(name);
             System.debug('Name : ' + name);
            }
        

        return SobjectList;
        
    }
    

    @AuraEnabled
    public static List<Viaggio__c> getAllDetails(String name){

        String finalQuery;

        String query = 'SELECT Id, Name, Periodo__c, Prezzo__c, Status__c, ECU_Number_Of_Reservartion__c, Select__c  FROM Viaggio__c ';

        String condition = ' WHERE Name = ';


        finalQuery = query + condition + '\'' + name + '\'';


        System.debug('query' + finalQuery);


        List<Viaggio__c> vgg = Database.query(finalQuery);


        return vgg;
        
    }

}
