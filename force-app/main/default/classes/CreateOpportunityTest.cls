@IsTest
private class CreateOpportunityTest {
    @IsTest
    private static void createOppTest(){

        Account newAcc = new Account();
        newAcc.Name = 'yoyoyo';
        newAcc.Industry = 'Agriculture';

        insert newAcc;

        Opportunity oppQuery = [SELECT Id, Name, AccountId FROM Opportunity];
        
        System.assertEquals(oppQuery.AccountId, newAcc.Id, 'These do not match');
    }
}