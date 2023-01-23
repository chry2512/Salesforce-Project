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
    public static List<String> getAllFields(String fld){
        List<String> fieldList = new List<String>();

        Map<String, Schema.SObjectType> gd = Schema.getGlobalDescribe();
        Schema.SObjectType sobjType = gd.get(fld);
        Schema.DescribeSObjectResult describeResult = sobjType.getDescribe();

        Map<String, Schema.SobjectField> fieldsMap = describeResult.fields.getMap();

        for (String str : fieldsMap.keySet()){
            fieldList.add(fieldsMap.get(str).getDescribe().getLabel());

        }

        return fieldList;
    }

}