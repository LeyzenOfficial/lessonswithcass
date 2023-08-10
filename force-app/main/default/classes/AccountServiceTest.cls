@istest
private class AccountServiceTest {

    @TestSetup
    static void makeData(){
   
        Trigger_Manager__c tm = new Trigger_Manager__c();

        tm.Active__c = true;
        tm.Name = 'Account';

        insert tm;

    }
    
    @istest
    private static void updateContactTest(){

        Account newAcc = new Account();
        newAcc.Name = 'Pingola';

        insert newAcc;

        Account accQuery = [SELECT ID, Name FROM Account LIMIT 1];

        User userQuery = [SELECT ID FROM User WHERE name <> 'Matheus Orsi' LIMIT 1];

        accQuery.OwnerId = userQuery.Id;

        update accQuery;

        Contact conQuery =  [SELECT ID, Name, Ownerid FROM Contact LIMIT 1];

        System.assertEquals(accQuery.OwnerId, conQuery.OwnerId, 'Ownerid are not the same!');

    }
    @IsTest
    private static void blockAccountDeleteTest(){

        List<Account> accounts = new List<Account>();

        Account newAccount = new Account();

        newAccount.Name = 'Matt';
        accounts.add(newAccount);

        insert accounts;

        Account[] doomedAccts = [
            SELECT Id, Name 
            FROM Account 
            WHERE Name = 'Matt']; 

        String error;

        try {
            delete doomedAccts;
        } catch (Exception e) {
            error = e.getMessage();
        }

        System.assertEquals(true, error.contains('You cannot delete an account with a contact associated!'), 'The messages arent the same!');
    }
    @IsTest
    private static void updateMailingCityContactsTest(){

        Account account = new Account();

        account.Name = 'Matt';
        account.BillingCity = 'Varrock';

        insert account;

        account.BillingCity = 'Falador';
        
        update account;

        List<Contact> cons = [SELECT Id, LastName, MailingCity FROM Contact WHERE AccountId = :account.Id];
        

        System.assertEquals(cons[0].MailingCity, account.BillingCity, 'It didnt work!');
    }
    @IsTest
    private static void updateOpportunityStageTest(){

        Account account = new Account();

        account.Name = 'Matt';

        insert account;

        Opportunity opportunity = new Opportunity();

        opportunity.Name = 'newOpp';
        opportunity.StageName = 'Prospecting';
        opportunity.CloseDate = System.today();
        opportunity.AccountId = account.Id;

        insert opportunity;

        account.Name = 'Cassio';

        update account;

        Opportunity opps = [SELECT Id, Name, StageName FROM Opportunity WHERE AccountId = :account.Id];

        System.assertNotEquals('Closed Lost', opps.StageName, 'The stage name should be closed lost');
    }
    @IsTest
    private static void sendEmailToContactsWhenAccountTypeChanges(){

        Account newAccount = new Account();

        newAccount.Name = 'MatheusOrsi';
        newAccount.Type = 'Prospect';

        insert newAccount;

        Contact contactFromAccountId = [SELECT Id, LastName, Email, AccountId, Account.Name FROM Contact WHERE AccountId = :newAccount.Id];

        contactFromAccountId.Email = 'minecraftlawls@gmail.com';

        update contactFromAccountId;

        newAccount.Type = 'Other';

        Test.startTest();

        update newAccount;

        Integer invocations = Limits.getEmailInvocations();

        Test.stopTest();    

        system.assertEquals(1, invocations, 'Only one email should be sent!');
    }
}