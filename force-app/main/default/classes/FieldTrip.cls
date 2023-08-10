public with sharing class FieldTrip {
    

        public String city;
        public String country;
        public Decimal ticketPrice;

        public void setCity(String city){
            this.city = city;
        }

        public void setCountry(String country){
            this.country = country;
        }

        public void setTicketPrice(Decimal ticketPrice){
            this.ticketPrice = ticketPrice;
        } 
}

// FieldTrip ft = new FieldTrip();

// ft.setCity('Itajai');
// ft.setCountry('Brasil');
// ft.setTicketPrice(500.00);

// System.debug(ft.city);
// System.debug(ft.country);
// System.debug(ft.ticketPrice);