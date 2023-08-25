public class AccountAndContactController {
 
    @AuraEnabled
    public static AccountsAndContacts createAccountsAndContacts(Integer i, String s){

        List<Contact> contactList = new List<Contact>();

        try{
            Account newAcc = new Account();

            newAcc.Name = s;

            insert newAcc;

            For(Integer a = 0; a<i; a++){
            
                Contact newContact = new Contact();

                newContact.LastName = s + a;
                newContact.AccountId = newAcc.Id;

                contactList.add(newContact);   
            }

            insert contactList;

            contactList = [SELECT Id, LastName, Account.Name FROM Contact WHERE AccountId = :newAcc.Id];

            AccountsAndContacts aAC = new AccountsAndContacts();

            aAC.accounts = new List<Account> {newAcc};
            aAC.contacts = contactList;

            return aAC;
            

        } catch (Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }

    public class AccountsAndContacts{

        @AuraEnabled public List<Account> accounts {get;set;}
        @AuraEnabled public List<Contact> contacts {get;set;}
    }
}