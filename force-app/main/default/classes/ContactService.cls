public class ContactService {
    
    @AuraEnabled
    public static List<Contact> contactGrabber(Integer i){

        return [SELECT Id, Name FROM Contact LIMIT :i];
    }
}