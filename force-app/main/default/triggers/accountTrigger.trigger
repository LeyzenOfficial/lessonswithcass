trigger accountTrigger on Account (after insert, after update, before delete) {

    Trigger_Manager__c tm = [SELECT Id, Name, Active__c FROM Trigger_Manager__c WHERE name = 'Account' LIMIT 1];

    if(!TM.Active__c){
        return;
    }

    if(Trigger.isAfter){
        if(Trigger.isInsert){
            
            CreateContactRelated.createContactLink(Trigger.new);
            
            CreateOpportunity cO = new CreateOpportunity(Trigger.new);
            cO.createOpp();
            
        }
        
    }

    if(Trigger.isAfter){
        if(Trigger.isUpdate){

            AccountService.updateContact(Trigger.new, Trigger.oldMap);

            CreateOpportunity cO = new CreateOpportunity(Trigger.new, Trigger.oldMap);
            cO.createOpp();

            AccountService.updateMailingCityContacts(Trigger.new, Trigger.oldMap);

            AccountService.updateOpportunityStage(Trigger.new, Trigger.oldMap);

            AccountService.sendEmailToContactsWhenAccountTypeChanges(Trigger.new, Trigger.oldMap);
        }
    }

    if(Trigger.isBefore){
        if(Trigger.isDelete){

            AccountService.blockAccountDelete(Trigger.old);
        }
    }
}