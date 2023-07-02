@IsTest
public class AnimalLocatorTest{
        
    @IsTest
    static void TestGetAnimalById(){

        Test.startTest();        
        String name = AnimalLocator.getAnimalNameById(2);
        System.assert(name.equals('Test'));
        Test.stopTest(); 
    }

    @IsTest
    static void TestHttpGet(){
        Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock()); 
        HttpResponse response = AnimalLocator.makeGetCallout();    
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = response.getBody();
        String expectedValue = '{"animals": ["majestic badger", "fluffy bunny", "scary bear", "chicken", "mighty moose"]}';
        System.assertEquals(expectedValue, actualValue);
        System.assertEquals(200, response.getStatusCode());
    }

}