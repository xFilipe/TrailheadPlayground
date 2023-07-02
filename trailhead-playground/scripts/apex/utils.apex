


        // call https://th-apex-http-callout.herokuapp.com/animals/ + id
Integer id = 1;
Http http = new Http();
HttpRequest request = new HttpRequest();
String endpoint = 'https://th-apex-http-callout.herokuapp.com/animals/' + id;
request.setEndpoint(endpoint);
request.setMethod('GET');
        
HttpResponse response = http.send(request);

System.debug('response ' + response);

if(response.getStatusCode() == 200) {


    Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());

    System.debug('results ' + results);

    
    Object animal = (Object) results.get('animal');

    System.debug('animal' + animal);


}