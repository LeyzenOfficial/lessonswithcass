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

    @AuraEnabled
    public static void updatePizzaStock(String pizzaType, Integer numberOfPizzas) {

        try {

            List<Pizza_Ingredient__c> pizzaIngredients = [SELECT Id, Name, Stock__c FROM Pizza_Ingredient__c];

            if(pizzaType == 'Pepperoni Pizza'){

                for(Pizza_Ingredient__c pI : pizzaIngredients){

                    if(pI.Name == 'Dough'){
                        pI.Stock__c = pI.Stock__c - 1 * numberOfPizzas;                
                    } else if(pI.Name == 'Cheese'){
                        pI.Stock__c = pI.Stock__c - 2 * numberOfPizzas;
                    } else if(pI.Name == 'Pepperoni'){
                        pI.Stock__c = pI.Stock__c - 10 * numberOfPizzas;
                    }
                }
            }

            if(pizzaType == 'Cheese Pizza'){

                for(Pizza_Ingredient__c pI : pizzaIngredients){

                    if(pI.Name == 'Dough'){
                        pI.Stock__c = pI.Stock__c - 1 * numberOfPizzas;                
                    } else if(pI.Name == 'Cheese'){
                        pI.Stock__c = pI.Stock__c - 5 * numberOfPizzas;
                    }
                }
            }

            if(pizzaType == 'Mushroom Pizza'){

                for(Pizza_Ingredient__c pI : pizzaIngredients){

                    if(pI.Name == 'Dough'){
                        pI.Stock__c = pI.Stock__c - 1 * numberOfPizzas;                
                    } else if(pI.Name == 'Cheese'){
                        pI.Stock__c = pI.Stock__c - 2 * numberOfPizzas;
                    } else if(pI.Name == 'Mushroom'){
                        pI.Stock__c = pI.Stock__c - 10 * numberOfPizzas;
                    }
                }
            }

            if(pizzaType == 'Pineapple Pizza'){

                for(Pizza_Ingredient__c pI : pizzaIngredients){

                    if(pI.Name == 'Dough'){
                        pI.Stock__c = pI.Stock__c - 1 * numberOfPizzas;                
                    } else if(pI.Name == 'Cheese'){
                        pI.Stock__c = pI.Stock__c - 2 * numberOfPizzas;
                    } else if(pI.Name == 'Pineapple'){
                        pI.Stock__c = pI.Stock__c - 8 * numberOfPizzas;
                    }
                }
            }

            if(pizzaType == 'Bacon Bomber Pizza'){

                for(Pizza_Ingredient__c pI : pizzaIngredients){

                    if(pI.Name == 'Dough'){
                        pI.Stock__c = pI.Stock__c - 1 * numberOfPizzas;                
                    } else if(pI.Name == 'Cheese'){
                        pI.Stock__c = pI.Stock__c - 2 * numberOfPizzas;
                    } else if(pI.Name == 'Bacon'){
                        pI.Stock__c = pI.Stock__c - 12 * numberOfPizzas;
                    }
                }
            }

            update pizzaIngredients;

        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    @AuraEnabled
    public static void updateReStock(String ingredient, Integer numberOfIngredients){

        try {

            Pizza_Ingredient__c pizzaIngredient = [SELECT Id, Name, Stock__c FROM Pizza_Ingredient__c WHERE Name = :ingredient];

            pizzaIngredient.Stock__c = pizzaIngredient.Stock__c + numberOfIngredients;

            update pizzaIngredient;


        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }

    }

    public static void checkLowStock(List<Pizza_Ingredient__c> ingredients){

        User u = [SELECT Id, Name, Email FROM User WHERE id = :UserInfo.getUserId()];

        String textBody = '';

        for(Pizza_Ingredient__c pi: ingredients){

            if(pi.Stock__c <= 10){

                textBody = textBody + 'Ingredient ' + pi.Name + ' needs to be restocked!' + '\n' +
                        '(Current stock: ' + pi.Stock__c + ')' + '\n\n';
            }

        }

        if(String.isBlank(textBody)){
            return;
        }

        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        message.toAddresses = new String[] { u.Email };
        message.subject = 'STOCK IS LOW!';
        message.plainTextBody = textBody;
        Messaging.SingleEmailMessage[] messages = new List<Messaging.SingleEmailMessage> {message};
        Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);

    }

    public static void createPizzaOrderNotification(List<Pizza_Order__c> newOrders) {

        Set<String> recipientsIds = new Set<String>();
    
        // Step 1: Retrieve the Id of the specific public group
        Group publicGroup = [SELECT Id FROM Group WHERE DeveloperName = 'Pizza_Makers'];
    
        // Step 2: Add the Ids of all users in the public group to recipientsIds
        List<GroupMember> groupMembers = [SELECT UserOrGroupId FROM GroupMember WHERE GroupId = :publicGroup.Id];
        for (GroupMember member : groupMembers) {
            recipientsIds.add(member.UserOrGroupId);
        }
    
        // Get the Id for our custom notification type
        CustomNotificationType notificationType =
        [SELECT Id, DeveloperName 
            FROM CustomNotificationType 
            WHERE DeveloperName='Notificationtest'];

        for (Pizza_Order__c order : newOrders) {

            // Create a new custom notification
            Messaging.CustomNotification notification = new Messaging.CustomNotification();
    
            // Set the contents for the notification
            notification.setTitle('New pizza order!');
            notification.setBody('A new pizza has been ordered!');
    
            // Step 3: Set the notification type and target to the public group Id
            notification.setNotificationTypeId(notificationType.Id);
            notification.setTargetId(order.Id);
    
            // Actually send the notification

            notification.send(recipientsIds);

        }
    }
}
