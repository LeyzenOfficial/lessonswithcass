public class CustomTesterService {
    @AuraEnabled
    public static List<CustomTester__c> customTesterGrabber(Integer i){

        return [SELECT Id, BringItBack__c, Name FROM CustomTester__c LIMIT :i];

    }
}