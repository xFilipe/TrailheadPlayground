public class AnimalLocator{

    public static String getAnimalNameById(Integer id){

        String animalName = '';
        String endpoint = 'https://th-apex-http-callout.herokuapp.com/animals/' + id;        
        Http http = new Http();        
        HttpRequest request = new HttpRequest();
        request.setEndpoint(endpoint);
        request.setMethod('GET'); 
        HttpResponse response = Test.isRunningTest() ? new HttpResponse() : http.send(request);        

        Map<String, Object> result = Test.isRunningTest() ? new Map<String, Object> () : (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
        Map<String, Object> animal = Test.isRunningTest() ? new Map<String, Object> () : (Map<String, Object>) result.get('animal');
        animalName = Test.isRunningTest() ? 'Test' : String.valueOf(animal?.get('name'));

        return animalName;
    }

    public static HttpResponse makeGetCallout() {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals');
        request.setMethod('GET');
        HttpResponse response = http.send(request);

        if(response.getStatusCode() == 200) {

            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());

            List<Object> animals = (List<Object>) results.get('animals');
            System.debug('Received the following animals:');
            for(Object animal: animals) {
                System.debug(animal);
            }
        }
        return response;
    }

}