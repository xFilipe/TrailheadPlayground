public class AddPrimaryContact implements Queueable{

    private String state;
    private Contact currentContact;

    public AddPrimaryContact(Contact contact, String state) {
        this.state = state;
        this.currentContact = contact;
    }

    public void execute(QueueableContext context) {        

        List<Contact> contacts = new List<Contact>();
        Map<String,Account> accounts = new Map<String,Account>();        
        
        for(Account acc:[select id, PrimaryContactId__c from account where BillingState =: state limit 200]){
            Contact contact = new Contact();
            contact = currentContact.clone(false, false, false, false);
            contact.AccountId = acc.Id;
            contacts.add(contact);
            accounts.put(acc.Id, acc);
        }      

        if(!contacts.isEmpty()){  
            
            Database.insert(contacts);

            for(Contact contact: contacts){
                if(contact?.AccountId == accounts.get(contact?.AccountId).Id) accounts.get(contact.AccountId).PrimaryContactId__c = contact.Id;
            }               
            
            Database.update(accounts.values());
        } 
    }


}