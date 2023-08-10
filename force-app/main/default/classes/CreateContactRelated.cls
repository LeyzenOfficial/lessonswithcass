public class CreateContactRelated {
    
    public static void createContactLink(List<Account> listAcc){

        List<contact> conList = New List<contact>();

            For(Account newAcc: listAcc){

                Contact newCon = new Contact();

                newCon.LastName = 'Orsi';
                newCon.AccountId = newAcc.id;

                conList.add(newCon);

            }
        Insert conlist;
    }

    public static void countContacts(List<Contact> newList, List<Contact> oldList){

        Set<Id> accountIds = new Set<Id>();

        if(newList != null){

            for(contact c : newList){

                if(c.AccountId != null){
    
                    accountIds.add(c.AccountId);
                }
            }
        }
        
        if(oldList != null){

            for(Contact c : oldList){

                if(c.AccountId != null){
    
                    accountIds.add(c.AccountId);
                }
            }
        }
        
        List<Account> accounts = [SELECT Id, Total_Contacts__c, (SELECT Id FROM Contacts) FROM Account WHERE Id IN :accountIds];
        
        if(!accounts.isEmpty()){

            for(Account acc : accounts){
                acc.Total_Contacts__c = acc.contacts.size();
            }
        }
        update accounts;
    }
}