public class ObjectFactory{
    
    public static List<Contact> generatContacts(Integer quantity, String lastName){

        List<Contact> contacts = new List<Contact>();
        for(Integer i = 0; i < quantity; i++) contacts.add(new Contact(FirstName = 'Test' + (i +1), LastName = lastName));

        return contacts;
    }

    public static List<Lead> generateLead(Integer quantity, String lastName, String company){

        List<Lead> leads = new List<Lead>();
        for(Integer i = 0; i < quantity; i++) leads.add(new Lead(FirstName = 'Test' + (i +1), LastName = lastName, Company = company));

        return leads;
    }

    public static List<Account> generateAccount(Integer quantity, String billingState){

        List<Account> accounts = new List<Account>();
        for(Integer i = 0; i < quantity; i++) accounts.add(new Account(Name = 'Test' + (i +1), BillingState = billingState));

        return accounts;
    }

}