@IsTest
private class ContactServiceTest {

    @TestSetup
    static void makeData(){
   
        Contact contact1 = new Contact();

        contact1.LastName = 'Contact1';
        contact1.Email = 'Matt.orsi@hotmail.com';
        contact1.Phone = '1234567890';

        insert contact1;
    }
    
    @IsTest
    private static void preventDuplicateEmailContactRecordsTest(){

        Contact contact2 = new Contact();

        contact2.LastName = 'Contact2';
        contact2.Email = 'Matt.orsi@hotmail.com';
        contact2.Phone = '1334567890';

        String error;

        try {
            insert contact2;
        } catch (Exception e) {
            error = e.getMessage();
        }

        System.assertEquals(true, error.contains('There is a duplicate contact with the same email!'), 'The messages arent the same!');

    }

    @IsTest
    private static void preventDuplicatePhoneContactRecordsTest(){

        Contact contact2 = new Contact();

        contact2.LastName = 'Contact2';
        contact2.Email = 'Matt123.orsi@hotmail.com';
        contact2.Phone = '1234567890';

        String error;

        try {
            insert contact2;
        } catch (Exception e) {
            error = e.getMessage();
        }

        System.assertEquals(true, error.contains('There is a duplicate contact with the same phone number!'), 'The messages arent the same!');

    }

    @IsTest
    private static void createContactTest(){

        Account newAcc = new Account();
        newAcc.Name = 'lol';
        
        insert newAcc;

        String contactName = 'Test contact';
        String accId = newAcc.Id;
        Test.startTest();
        ContactService.createContact(contactName, accId);
        Test.stopTest();

        List<Contact> conList = [SELECT Id, Name FROM Contact];

        System.assertEquals(false, conList.isEmpty(), 'Contact list should not be empty!');
    }

}