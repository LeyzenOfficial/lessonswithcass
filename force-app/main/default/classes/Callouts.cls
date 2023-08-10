public class Callouts {

    public static void getCallout(){

        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals');
        request.setMethod('GET');
        HttpResponse response = http.send(request);

        // If the request is successful, parse the JSON response.
        if(response.getStatusCode() == 200) {
            // Deserialize the JSON string into collections of primitive data types.
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            // Cast the values in the 'animals' key as a list
            List<Object> animals = (List<Object>) results.get('animals');
            
            //{"animals":["majestic badger","fluffy bunny","scary bear","chicken"]}

            System.debug('Received the following animals:');
            List<Account> accounts = new List<Account>();

            for(Object animal: animals) {

                Account acc = new Account();
                acc.Name = (String) animal;

                accounts.add(acc);

                System.debug(animal);
            }
            insert accounts;
        }
    }
}