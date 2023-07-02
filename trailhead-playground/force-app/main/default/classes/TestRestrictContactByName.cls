@IsTest
public class TestRestrictContactByName {

    @isTest
    static void VerifyInvalidName(){

        Database.SaveResult dmlOperation = Database.insert(new Contact(LastName = 'INVALIDNAME'));
        


        System.assert(dmlOperation.getErrors().size() > 0);
    }

}