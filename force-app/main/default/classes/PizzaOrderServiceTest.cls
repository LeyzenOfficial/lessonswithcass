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
    @isTest
    private static void updatePizzaStockTest() {

        List<Pizza_Ingredient__c> pizzaIngredients = new List<Pizza_Ingredient__c>();
        pizzaIngredients.add(new Pizza_Ingredient__c(Name = 'Dough', Stock__c = 100));
        pizzaIngredients.add(new Pizza_Ingredient__c(Name = 'Cheese', Stock__c = 100));
        pizzaIngredients.add(new Pizza_Ingredient__c(Name = 'Pepperoni', Stock__c = 100));
        pizzaIngredients.add(new Pizza_Ingredient__c(Name = 'Bacon', Stock__c = 100));
        pizzaIngredients.add(new Pizza_Ingredient__c(Name = 'Mushroom', Stock__c = 100));
        pizzaIngredients.add(new Pizza_Ingredient__c(Name = 'Pineapple', Stock__c = 100));

        insert pizzaIngredients;


        PizzaOrderService.updatePizzaStock('Pepperoni Pizza', 1);
        PizzaOrderService.updatePizzaStock('Cheese Pizza', 1);
        PizzaOrderService.updatePizzaStock('Mushroom Pizza', 1);
        PizzaOrderService.updatePizzaStock('Pineapple Pizza', 1);
        PizzaOrderService.updatePizzaStock('Bacon Bomber Pizza', 1);


        List<Pizza_Ingredient__c> updatedPizzaIngredients = [ SELECT Id, Name, Stock__c FROM Pizza_Ingredient__c];


        System.assertEquals(95, updatedPizzaIngredients[0].Stock__c, 'Dough stock should be updated');
        System.assertEquals(87, updatedPizzaIngredients[1].Stock__c, 'Cheese stock should be updated');
        System.assertEquals(90, updatedPizzaIngredients[2].Stock__c, 'Pepperoni stock should be updated');

        System.assertEquals(88, updatedPizzaIngredients[3].Stock__c, 'Bacon stock should be updated');
        System.assertEquals(90, updatedPizzaIngredients[4].Stock__c, 'Mushroom stock should be updated');
        System.assertEquals(92, updatedPizzaIngredients[5].Stock__c, 'Pineapple stock should be updated');
    }

    @isTest
    private static void updateReStockTest() {

        Pizza_Ingredient__c testIngredient = new Pizza_Ingredient__c();

        testIngredient.Name = 'Pepperoni';
        testIngredient.Stock__c = 10;

        insert testIngredient;


        Test.startTest();
        PizzaOrderService.updateReStock('Pepperoni', 5);
        Test.stopTest();


        Pizza_Ingredient__c updatedIngredient = [SELECT Id, Stock__c FROM Pizza_Ingredient__c WHERE Id = :testIngredient.Id];
        
        System.assertEquals(15, updatedIngredient.Stock__c, 'Stock__c should be updated to 15');
    }

    @isTest
    private static void testCheckLowStock() {


        Pizza_Ingredient__c ingredient = new Pizza_Ingredient__c(Name='Pepperoni ' , Stock__c=50);

        insert ingredient;

        ingredient.Stock__c = 5;

        Test.startTest();

        update ingredient;

        Integer invocations = Limits.getEmailInvocations();
        
        Test.stopTest();


        system.assertEquals(1, invocations, 'Only one email should be sent!');
    }

    @isTest
    private static void CreatePizzaOrderNotificationTest() {

        User myUser = [SELECT Id FROM User WHERE Id = :UserInfo.getUserId()];

        Group pizzaGroup = [SELECT Id FROM Group WHERE DeveloperName = 'Pizza_Makers'];

        System.runAs(myUser) {

            // Create a test user
            User testUser = new User(
                FirstName = 'Test',
                LastName = 'User',
                Alias = 'tuser',
                Email = 'leyley123@example.com',
                UserName = 'leyzenofficial@example.com',
                ProfileId = [SELECT Id FROM Profile WHERE Name = 'Standard User' LIMIT 1].Id,
                EmailEncodingKey = 'UTF-8',
                LanguageLocaleKey = 'en_US',
                LocaleSidKey = 'en_US',
                TimeZoneSidKey = 'America/New_York'
            );
            insert testUser;

            GroupMember groupMember = new GroupMember(
                GroupId = pizzaGroup.Id,
                UserOrGroupId = testUser.Id
            );
            insert groupMember;
        }

        // Create a test Pizza_Order__c record
        Pizza_Order__c testOrder = new Pizza_Order__c();

        testOrder.Pizza_type__c = 'Pepperoni Pizza';
        testOrder.Status__c = 'Ordered';
        testOrder.Amount__c = 1;

        Test.startTest();
        insert testOrder;
        Test.stopTest();
    }
}