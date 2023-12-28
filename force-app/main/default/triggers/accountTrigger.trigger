trigger accountTrigger on Account (before insert) {

    if(Trigger.isBefore){
        if(Trigger.isInsert){

            Utils.validateCPF(Trigger.new);
        }
    }
}