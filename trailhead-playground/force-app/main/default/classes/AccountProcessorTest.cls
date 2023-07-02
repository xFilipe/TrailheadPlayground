@isTest
public class AccountProcessorTest{
    
    @isTest
    static void TestCountContacts() {

        Map<String, Contact> contacts = new Map<String, Contact>();
        List<Account> accounts = new List<Account>();

        accounts.add(new Account(Name = 'Test1'));      
        accounts.add(new Account(Name = 'Test2'));
        insert accounts;

        // for(Contact cc: RandomContactFactory.generateRandomContacts(3, 'Any'))
        for(Contact cc: ObjectFactory.generatContacts(3, 'Any')){
            cc.AccountId = cc.FirstName == 'Test1' ? accounts[0].Id : accounts[1].Id;
            contacts.put(contacts.containsKey(cc.AccountId) ? ' ' : cc.AccountId, cc);
        }
        
        insert contacts.values();

        Test.startTest();
        AccountProcessor.countContacts(new List<String>(contacts.keySet()));
        Test.stopTest();

        List<Account> accList = new List<Account>([select id from account where Number_Of_Contacts__c > 0]);
        System.assert(accList.size() == 2);  

    }

}