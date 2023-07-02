public class AccountProcessor {

    @future
    public static void countContacts(List<String> accountIdList){                       

        if(!accountIdList.isEmpty()){
            Map<String,Account> accountMap = new Map<String,Account>();               
            Account currentAccount = new Account();
            Integer counter = 0;

            for(Contact contact:[select Id, AccountId from Contact where AccountId in: accountIdList order by AccountId]){                
                if(currentAccount?.Id != contact.AccountId){   
                    currentAccount = new Account(Id = contact.AccountId, Number_Of_Contacts__c = 1);     
                    accountMap.put(currentAccount.Id, currentAccount);
                }else{     
                    counter++;               
                    accountMap.remove(currentAccount.Id);           
                    currentAccount.Number_Of_Contacts__c = counter;
                    accountMap.put(currentAccount.Id, currentAccount);
                }                
            }

            Database.upsert(accountMap.values());
        }
    }

}