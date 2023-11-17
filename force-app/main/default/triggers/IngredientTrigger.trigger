trigger IngredientTrigger on Pizza_Ingredient__c (before insert, after update) {

    if(Trigger.isAfter){
        if(Trigger.isUpdate){

            PizzaOrderService.checkLowStock(Trigger.new);

        }
    }
}