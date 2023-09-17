

List<ContactPointAddress> addresses = new List<ContactPointAddress>();

for(Account entity:[select Id, AddressesNumber__c, AddressesNeighborhood__c, AddressComplement__c, BillingAddress from account where AddressesNeighborhood__c != null ]){
    Address address = entity.BillingAddress;
    String formattedName = address?.street + ', ' + entity?.AddressesNumber__c + ', (' +address?.postalCode+') - ' + entity?.AddressesNeighborhood__c + ' - ' + address?.city + ' - ' + address?.state;

    ContactPointAddress contactAddress = new ContactPointAddress();
    contactAddress.ParentId = entity.Id;
    contactAddress.Name = formattedName;
    contactAddress.ExternalCode__c = 'entity.ExternalCode__c  ?? ';
    contactAddress.AddressesNumber__c = entity.AddressesNumber__c;
    contactAddress.AddressesNeighborhood__c = entity.AddressesNeighborhood__c;
    contactAddress.AddressesComplement__c = entity.AddressComplement__c;
    contactAddress.Country = address.Id;
    contactAddress.PostalCode = address.country;
    contactAddress.State = address.state;
    contactAddress.City = address.city;
    contactAddress.Street = address.street;    
    addresses.add(contactAddress);
}

System.debug('Teste >> ' + addresses.size() + addresses.get(0));





System.debug('teste  ' + ObjectFactory.generateAccount(1,'a'));












   // call https://th-apex-http-callout.herokuapp.com/animals/ + id
Integer id = 1;
Http http = new Http();
HttpRequest request = new HttpRequest();
String endpoint = 'https://th-apex-http-callout.herokuapp.com/animals/' + null;
request.setEndpoint(endpoint);
request.setMethod('GET');
        
HttpResponse response = http.send(request);

System.debug('response ' + response);

if(response.getStatusCode() == 200) {


    Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());

    System.debug('results ' + results);

    
    Map<String, Object> animal = (Map<String, Object>) results.get('animal');

    System.debug('animal' + animal.get('name'));



}