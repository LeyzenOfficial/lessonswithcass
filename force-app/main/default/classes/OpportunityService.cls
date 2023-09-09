public class OpportunityService {
    
    public static void blockOpportunityDelete(List<Opportunity> Opportunities){

        User user = [SELECT Id, Profile.Name FROM User WHERE Id = :Userinfo.getUserId()];

        for(Opportunity o : Opportunities){

            if(o.StageName == 'Closed Won' || o.StageName == 'Closed Lost'){

                if(user.Profile.Name != 'System Administrator') {
    
                    o.addError('You dont have permission to delete this opportunity!');
                }
            }
        }
    }

    public static void sendEmailToOwner(List<Opportunity> opportunities, Map<Id, Opportunity> oldOpportunities){

        List<Id> usersToNotify = new List<Id>();

        for(Opportunity opp : opportunities){

            if(opp.StageName == 'Closed Won' && oldOpportunities.get(opp.Id).StageName != opp.StageName){

                usersToNotify.add(opp.OwnerId);
            }
        }

        if(!usersToNotify.isEmpty()){

            sendEmailToTheseGuys(usersToNotify);
        }
    }

    public static void sendEmailToTheseGuys(List<Id> userIds){

        List<String> emailList = new List<String>();
        List<User> userRecords = [SELECT Email FROM User WHERE Id IN :userIds];

        for(User userRec : userRecords){
            emailList.add(userRec.Email);
        }

        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        message.toAddresses = new String[] { 'minecraftlawls@gmail.com' };
        message.subject = 'You are cool!';
        message.plainTextBody = 'yay it worked!';
        Messaging.SingleEmailMessage[] messages =   new List<Messaging.SingleEmailMessage> {message};
        Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
    }
    @AuraEnabled
    public static List<Opportunity> opportunityGrabber(Integer i){

        return [SELECT Id, Name, StageName, CloseDate FROM Opportunity LIMIT :i];
    }

    @AuraEnabled
    public static List<Opportunity> createAmountOfOpportunities(Integer i, String name, String stage, Date closeDate, String trackingNumber, String orderNumber){
        
        List<Opportunity> opportunities = new List<Opportunity>();
        
        try {
            For(Integer a = 0; a<i; a++){
            
                Opportunity newOpportunity = new Opportunity();
                newOpportunity.Name = name + a;
                newOpportunity.StageName = stage;
                newOpportunity.CloseDate = closeDate;
                newOpportunity.TrackingNumber__c = trackingNumber;
                newOpportunity.OrderNumber__c = orderNumber;

                opportunities.add(newOpportunity);  
            }
            
            insert opportunities;
            return opportunities;
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}
