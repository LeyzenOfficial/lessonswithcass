public class JokesCallOut {
    @AuraEnabled
    public static Joke getCallout(){

        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://v2.jokeapi.dev/joke/Any?format=json?type=twopart');
        request.setMethod('GET');
        HttpResponse response = http.send(request);

        try{
                // If the request is successful, parse the JSON response.
            if(response.getStatusCode() == 200) {
                // Deserialize the JSON string into collections of primitive data types.
                Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
                // Cast the values in the 'animals' key as a list
                
                String category = (String) results.get('category');
                String setup = (String) results.get('setup');
                String delivery = (String) results.get('delivery');
                String id = String.valueOf(results.get('id'));
                String jokeMessage = (String) results.get('joke');

                Joke joke = new Joke();

                joke.category = category;
                joke.setup = setup;
                joke.delivery = delivery;
                joke.name = id;
                joke.jokeMessage = jokeMessage;
                joke.response = JSON.serializePretty(results);

                return joke;
            }else{

                throw new AuraHandledException('Status code:' + response.getStatusCode());

            }

            } catch (Exception e){
                throw new AuraHandledException(e.getMessage());
        }
    }

    public class Joke{

        @AuraEnabled public String category {get;set;}
        @AuraEnabled public String setup {get;set;}
        @AuraEnabled public String delivery {get;set;}
        @AuraEnabled public String name {get;set;}
        @AuraEnabled public String response {get;set;}
        @AuraEnabled public String jokeMessage {get;set;}


    }
}

// Map<String, String> stringMap = new Map<String, String>();

// stringMap.put('error', 'false');
// stringMap.put('category', 'Pun');
// stringMap.put('type', 'twopart');
// stringMap.put('setup', 'I just got fired from my job at the keyboard factory.');
// stringMap.put('delivery', 'They told me I wasn\'t putting in enough shifts.');

// system.debug(stringMap.get('hello'));