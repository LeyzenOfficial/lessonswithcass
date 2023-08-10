trigger OpportunityTrigger on Opportunity (before delete, after update) {

    Trigger_Manager__c tm = [SELECT Id, Name, Active__c FROM Trigger_Manager__c WHERE name = 'Opportunity' LIMIT 1];

    if(!TM.Active__c){
        return;
    }

    if(Trigger.isBefore){
        if(Trigger.isDelete){

           OpportunityService.blockOpportunityDelete(Trigger.old);
        }
    }

    if(Trigger.isAfter){
        if(Trigger.isUpdate){

            OpportunityService.sendEmailToOwner(Trigger.new, Trigger.oldMap);
        }
    }
}