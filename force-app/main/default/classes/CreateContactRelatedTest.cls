@IsTest
public class CreateContactRelatedTest {

    @IsTest
    public static void createContactLinkTest(){

        List<contact> conList = new List<contact>();

        List<account> acclist = new List<account>();

        Account oneAcc = new Account();

        oneAcc.name = 'matt';

        accList.add(oneAcc);

        Insert acclist;


        For(Account newAcc: accList){

            Contact newCon = new Contact();

            newCon.LastName = 'Orsi';
            newCon.AccountId = newAcc.id;

            conList.add(newCon);
            System.assertEquals(newAcc.id, newCon.AccountId, 'These dont match');
        }
        insert conList;   
    }
    @IsTest
    private static void countContactsTest(){

        Account account = new Account();

        account.Name = 'Matt';
        insert account;

        Contact contact = new Contact();

        contact.LastName = 'Pingola';
        contact.AccountId = account.id;

        insert contact;

        contact.LastName = 'Pingoleta';
        Test.startTest();
        update contact;
        Test.stopTest();

        Account accounts = [SELECT Id, name, Total_Contacts__c FROM Account WHERE name = 'Matt'];


        System.assertEquals(2, accounts.Total_Contacts__c, 'There should only be 1 contact on the account');
    }
}