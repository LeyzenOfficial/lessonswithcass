trigger userTrigger on User (after insert, after update) {

    if(Trigger.isAfter){
        if(Trigger.isInsert){

            UserService.addAdminToPublicGroup(Trigger.new);

        }
    }

    if(Trigger.isAfter){
        if(Trigger.isUpdate){

            UserService.addDeleteAdminUserGroup(Trigger.new, Trigger.oldMap);

        }
    }
}