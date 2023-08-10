@istest
public with sharing class NewTestLessons {
    
    @istest
    public static void setCityTest(){
        
        FieldTrip ft = new FieldTrip();

        ft.setCity('Boca');

        System.assertEquals('Boca', ft.city, 'City is not valid!');
        
    }

    @istest
    public static void setCountryTest(){
        
        FieldTrip ft = new FieldTrip();

        ft.setCountry('USA');

        System.assertEquals('USA', ft.country, 'Country is not valid!');
        
    }

    @istest
    public static void setTicketPriceTest(){
        
        FieldTrip ft = new FieldTrip();

        ft.setTicketPrice(10.00);

        System.assertEquals(10.00, ft.ticketPrice, 'Ticket price is not valid!');
        
    }
}