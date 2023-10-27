@istest
private class PizzaOrderServiceTest {
    
    @istest
    private static void createPizzaOrderTest(){


        PizzaOrderService.createPizzaOrder('Pepperoni Pizza', 2, 'Ordered');


        Pizza_Order__c createdPizzaOrder = [SELECT Id, Pizza_type__c, Amount__c, Status__c FROM Pizza_Order__c ];


        System.assertEquals('Pepperoni Pizza', createdPizzaOrder.Pizza_type__c, 'Pizza type should match');
        System.assertEquals(2, createdPizzaOrder.Amount__c, 'Amount should match');
        System.assertEquals('Ordered', createdPizzaOrder.Status__c, 'Status should match');
    }
    @istest
    private static void updatePizzaOrderTest(){

        Pizza_Order__c createdPizza = PizzaOrderService.createPizzaOrder('Pepperoni Pizza', 2, 'Ordered');

        createdPizza.Status__c = 'In Process';

        Pizza_Order__c updatedPizza = PizzaOrderService.updatePizzaOrder(createdPizza);


        System.assertEquals('In Process', updatedPizza.Status__c, 'Status should be in process');
    }
    @istest
    private static void getPizzaTypeUrlTest(){

        Pizza_Image_Links__c pizzaImageLink = new Pizza_Image_Links__c();

        pizzaImageLink.Pizza_Image_URL__c = 'https://www.recipetineats.com/wp-content/uploads/2023/05/Garlic-cheese-pizza_9.jpg';
        pizzaImageLink.Name = 'Cheese Pizza';

        insert pizzaImageLink;

        Pizza_Image_Links__c pizzaType = PizzaOrderService.getPizzaTypeUrl('Cheese Pizza');

        system.assertEquals('Cheese Pizza', pizzaType.Name, 'Pizza name should be Cheese Pizza');

    }
}