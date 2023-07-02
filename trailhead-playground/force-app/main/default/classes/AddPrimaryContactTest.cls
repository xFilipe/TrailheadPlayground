@IsTest
public class AddPrimaryContactTest{
    
    @IsTest
    static void TestAddPrimaryContact(){

        Contact contact = ObjectFactory.generatContacts(1, 'any')[0];
        insert contact;
                 
        List<Account> accounts = new List<Account>();
        accounts.addAll(ObjectFactory.generateAccount(50, 'NY'));
        accounts.addAll(ObjectFactory.generateAccount(50, 'CA'));    
        Database.insert(accounts);  


        Test.startTest();
        System.enqueueJob(new AddPrimaryContact(contact, 'CA'));
        Test.stopTest();

        List<Contact> newContactsCA = new List<Contact>([select Id from Contact where CreatedDate = today AND Account.BillingState =: 'CA']);
        System.assert(newContactsCA.size() == 50);        

    }


    @IsTest
    static void TestAddPrimaryContactError(){

        Test.startTest();
        System.enqueueJob(new AddPrimaryContact(new Contact(), 'XX'));
        Test.stopTest();

        List<Contact> newContactsCA = new List<Contact>([select Id from Contact where Account.BillingState =: 'XX']);
        System.assert(newContactsCA.isEmpty());        

    }
}