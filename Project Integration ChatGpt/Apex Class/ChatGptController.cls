/**
 * @description       : Controller ChatGpt LWC
 * @author            : Christian Niro
 * @group             :
 * @last modified on  : 01-23-2023
 * @last modified by  : 
 **/
public without sharing class ChatGptController{
    private static String CHAT_GPT_KEY = OpenIA__c.getOrgDefaults().ApiKey__c;
    private static final String ENDPOINT = OpenIA__c.getOrgDefaults().Url__c;
    @AuraEnabled
    public static string getQueryData(String searchString){
        try{
            String searchQueryEscaped = (searchString).trim();
            Http http = new Http();
            String reqBody = '{"model": "text-davinci-003","prompt":"' + searchQueryEscaped + 
                         '","max_tokens": 4000,"temperature": 0,' + 
                         '"stream": false,"top_p": 0.5}';

            HttpRequest request = new HttpRequest();
            request.setEndpoint(ENDPOINT);
            request.setMethod('POST');
            request.setHeader('Authorization', 'Bearer ' + String.escapeSingleQuotes(CHAT_GPT_KEY).trim());
            request.setTimeout(120000);
            request.setHeader('Content-Type', 'application/json;charset=UTF-8');
            request.setBody(reqBody);
            HttpResponse response = http.send(request);

            if (response.getStatusCode() != 200){
                System.debug('The status code returned was not expected: ' + response.getStatusCode() + ' ' + response.getBody());
                return response.getBody();
            }


            return response.getBody();

        } catch (Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }

}