@IsTest
private class OpportunityServiceTest {

    @IsTest
    private static void blockOpportunityDeleteTest(){

        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
        User u = new User(Alias = 'standt', Email='standarduser@testorg.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standarduser2323@test2323org.com');

        System.runAs(u) {

            List<Opportunity> opportunities = new List<Opportunity>();

            Opportunity newOpp = new Opportunity();

            newOpp.Name = 'LessonOppName';
            newOpp.StageName = 'Closed Won';
            newOpp.CloseDate = System.today();

            opportunities.add(newOpp);

            insert opportunities;

            Opportunity[] doomedopps = [
                SELECT Id, Name 
                FROM Opportunity 
                WHERE Name = 'LessonOppName'
            ];
         
            String error;

            try {
                delete doomedopps;
            } catch (Exception e) {
                error = e.getMessage();
            }

            System.assertEquals(true, error.contains('You dont have permission to delete this opportunity!'), 'The messages arent the same!');
        }
    }
    @IsTest
    private static void sendEmailToOwnerTest(){

        List<Opportunity> opportunities = new List<Opportunity>();

        Opportunity opportunity = new Opportunity();

        opportunity.Name = 'LessonOppName';
        opportunity.StageName = 'Prospecting';
        opportunity.CloseDate = System.today();

        opportunities.add(opportunity);
        insert opportunities;

        for(Opportunity opps : opportunities){

            opps.StageName = 'Closed Won';
        }

        Test.startTest();

        update opportunities;

        Integer invocations = Limits.getEmailInvocations();

        Test.stopTest();    

        system.assertEquals(1, invocations, 'Only one email should be sent!');
    }
}