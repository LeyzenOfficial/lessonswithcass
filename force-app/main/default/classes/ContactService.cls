public class ContactService {
    
    @AuraEnabled
    public static List<Contact> contactGrabber(Integer i){

        return [SELECT Id, Name FROM Contact LIMIT :i];
    }

    @AuraEnabled
    public static void createContact(String conName, String accountId){

        try{
            Contact newCon = new Contact();

            newCon.LastName = conName;
            newCon.AccountId = accountId;
            insert newCon;

        } catch (Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }
}