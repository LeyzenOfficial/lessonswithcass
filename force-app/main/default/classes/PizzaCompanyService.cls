public class PizzaCompanyService {
    @AuraEnabled
    public static Pizza_Image_Links__c getPizzaTypeUrl(String pizzaType){
             
        return Pizza_Image_Links__c.getValues(pizzaType);

    }
}