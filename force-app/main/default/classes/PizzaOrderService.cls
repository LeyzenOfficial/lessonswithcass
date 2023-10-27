public class PizzaOrderService {

    // public class PicklistOption {
    //     @AuraEnabled public String label { get; set; }
    //     @AuraEnabled public String value { get; set; }

    //     public PicklistOption(String label, String value) {
    //         this.label = label;
    //         this.value = value;
    //     }
    // }

    @AuraEnabled
    public static Pizza_Order__c createPizzaOrder(String pizzaType, Integer amount, String status) {

        try {
            
            Pizza_Order__c pizzaOrder = new Pizza_Order__c();

            pizzaOrder.Pizza_type__c = pizzaType;
            pizzaOrder.Amount__c = amount;
            pizzaOrder.Status__c = status;

            insert pizzaOrder;
            return pizzaOrder;

        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static Pizza_Order__c updatePizzaOrder(Pizza_Order__c pizzaOrder){

        try {

            update pizzaOrder;
            return pizzaOrder;

        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static Pizza_Image_Links__c getPizzaTypeUrl(String pizzaType){
             
        try {

        return Pizza_Image_Links__c.getValues(pizzaType);

        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}
