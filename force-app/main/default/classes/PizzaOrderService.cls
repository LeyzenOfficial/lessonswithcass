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
    public static Pizza_Order__c updateToOrderProcessed(Pizza_Order__c pizzaOrder){

        try {

            update pizzaOrder;
            return pizzaOrder;

        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static Pizza_Order__c updateToOrderDone(Pizza_Order__c pizzaOrder){

        try {

            update pizzaOrder;
            return pizzaOrder;

        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static Pizza_Order__c updateToOrderDelivered(Pizza_Order__c pizzaOrder){

        try {

            update pizzaOrder;
            return pizzaOrder;

        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    // @AuraEnabled(cacheable=true)
    // public static List<PicklistOption> getDynamicPicklistValues() {
    //     List<PicklistOption> options = new List<PicklistOption>();

    //     options.add(new PicklistOption('Pepperoni Pizza', 'Pepperoni Pizza'));
    //     options.add(new PicklistOption('Cheese Pizza', 'Cheese Pizza'));
    //     options.add(new PicklistOption('Mushroom Pizza', 'Mushroom Pizza'));
    //     options.add(new PicklistOption('Pineapple Pizza', 'Pineapple Pizza'));

    //     return options;
    // }
}
