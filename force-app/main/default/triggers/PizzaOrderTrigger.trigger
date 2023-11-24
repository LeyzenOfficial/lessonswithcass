trigger PizzaOrderTrigger on Pizza_Order__c (after insert) {

    if(Trigger.isAfter){
        if(Trigger.isInsert){

            PizzaOrderService.createPizzaOrderNotification(Trigger.new);

        }
    }

}