@isTest
private class UtilsTest {

    @isTest
    private static void testValidCPF() {
        
        Account acc = new Account();

        acc.Name = 'Matheus';
        acc.CPF__C = '09334269928';

        insert acc;

        List<Account> accs = [SELECT Id, Name FROM Account];


        System.assertEquals(1, accs.size(), 'There should be 1 account!');
    }
}