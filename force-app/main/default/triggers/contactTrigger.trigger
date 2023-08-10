trigger contactTrigger on Contact (after update, after insert, after undelete, after delete, before update, before insert) {
    
    if(Trigger.isAfter){
        if(trigger.isInsert || trigger.isUpdate || trigger.isDelete || trigger.isUndelete){
            CreateContactRelated.countContacts(Trigger.new, Trigger.old);
        }
    }
}