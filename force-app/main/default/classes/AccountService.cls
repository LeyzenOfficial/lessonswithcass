public class AccountService {

    public static void updateContact(List<Account> newList, Map<id, account> oldMap){

        List<Contact> contactsToBeUpdated = new List<Contact>();

        List<Contact> conList = [SELECT ID, Name, OwnerId, AccountId FROM Contact];

        if(conList.isEmpty()){ return; } 

        for(account newAcc: newList){

            if(newAcc.OwnerId != oldMap.get(newAcc.Id).OwnerId){

                for(Contact newCon: conList){

                    If(newCon.AccountId == newAcc.id){

                        newCon.OwnerId = newAcc.OwnerId;
                        contactsToBeUpdated.add(newCon);
                    }    
                }   
            }
        }
        if(!conList.isEmpty()){
            update contactsToBeUpdated;
        } 
    }

    public static void blockAccountDelete(List<Account> accounts){

        List<Contact> contacts = [SELECT Id, Name, AccountId FROM Contact];

        for(Account acc : accounts){

            for(Contact con : contacts){

                if(con.AccountId == acc.Id){

                    acc.addError('You cannot delete an account with a contact associated!');

                }
            }
        }
    }

    public static void updateMailingCityContacts(List<Account> accounts, Map<id, Account> oldAccounts){

        List<Account> accs = [SELECT Id, BillingCity, (SELECT Id FROM Contacts) FROM Account WHERE Id IN :accounts];
        List<Contact> contacts = new List<Contact>();

        for(Account acc : accs){

            if(acc.BillingCity != oldAccounts.get(acc.Id).BillingCity){

                for(Contact con : acc.contacts){

                    con.MailingCity = acc.BillingCity;
                    contacts.add(con);
                }
            }
        }
        update contacts;
    }

    public static void updateOpportunityStage(List<Account> accounts, Map<Id, Account> oldAccounts){

        List<Account> accs = [SELECT Id, Name, (SELECT Id, CreatedDate, StageName FROM Opportunities) FROM Account WHERE Id IN :accounts];
        List<Opportunity> opportunities = new List<Opportunity>();

        Date myDate = System.today();
        Date newDate = myDate.addDays(-30);

        for(Account account : accs){

            for(Opportunity opp : account.Opportunities){

                if(opp.CreatedDate < newDate && opp.StageName != 'Closed Won'){

                    opp.StageName = 'Closed Lost';

                    opportunities.add(opp);

                }
            }
        }
        if(!opportunities.isEmpty()){
            update opportunities;
        }
    }

    public static void sendEmailToContactsWhenAccountTypeChanges(List<Account> accounts, Map<Id, Account> oldAccounts){

        Set<Id> accIds = new Set<Id>();

        for(Account acc : accounts){

            if(acc.Type != oldAccounts.get(acc.Id).Type){

                accIds.add(acc.Id);
            }
        }

        if(accIds.size() == 0){
            return;
        }

        List<Contact> conList = [SELECT Id, LastName, Email, AccountId, Account.Name FROM Contact WHERE AccountId = :accIds];

        if(conList.size() == 0){
            return;
        }

        List<Messaging.SingleEmailMessage> emailList = new List<Messaging.SingleEmailMessage>();

        for(Contact con : conList){

                    
            if(con.Email == null){
                continue;
            }

            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setTargetObjectId(con.Id);
            mail.setSenderDisplayName('System Administrator');
            mail.setUseSignature(false);
            mail.setBccSender(false);
            mail.setSaveAsActivity(false);
            mail.setSubject(' Account Update Info.');
            String body = 'Dear '+con.LastName+', <br/>';
            body+='Your account information has been updated successfully.<br/><br/>Account Name : '+con.Account.Name;
            mail.setHtmlBody(body);
            mail.toAddresses = new String[]{con.Email};
            
            emailList.add(mail);  
        } 
        

        if(emailList.size() == 0){
            return;
        }

        Messaging.SendEmailResult[] results = Messaging.sendEmail(emailList);
    }
    @AuraEnabled
    public static List<Account> accountGrabber(Integer i){

        return [SELECT Id, Name, Website, Phone, Rating FROM Account LIMIT :i];
    }

    @AuraEnabled
    public static Account createAccount(String accName){

        try{
            Account newAcc = new Account();
            newAcc.Name = accName;
        
            insert newAcc;
            return newAcc;
        } catch (Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static List<Account> createAccounts(Integer i){

        List<Account> accountList = new List<Account>();

        try{
            For(Integer a = 0; a<i; a++){
            
                Account newAcc = new Account();

                newAcc.Name = 'MassAccountTester' + a;
                
                accountList.add(newAcc);   
            }

            insert accountList;
            return accountList;

        } catch (Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }
}
