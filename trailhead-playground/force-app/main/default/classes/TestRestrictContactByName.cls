@IsTest
public class TestRestrictContactByName {

    @isTest
    static void VerifyInvalidName(){

        Boolean validated;

        Test.startTest();

        try {
            Database.insert(new Contact(LastName = 'INVALIDNAME'));            
        } catch (DmlException e) {
            validated = e.getMessage().contains('FIELD_CUSTOM_VALIDATION_EXCEPTION');
        }        
        
        System.assert(validated);

        Test.stopTest();
    }

}