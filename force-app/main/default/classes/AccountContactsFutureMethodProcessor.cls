public class AccountContactsFutureMethodProcessor {
	@future
    public static void processWithBillingAddressAccountContacts()
    {   
        // a.
    	List<Account> selectedAccounds = [SELECT BillingAddress FROM Account LIMIT 150];
         
        // b.
        List<Id> withBillingAddressAccountIds = new List<Id>();
        for (Account account : selectedAccounds) {
            if (account.BillingAddress != null) {
                withBillingAddressAccountIds.add(account.Id);
            }
        }
        List<Contact> relatedContacts = [SELECT Is_Synced__c, Processed_By_Future__c
                                        FROM Contact
                                        WHERE AccountId IN :withBillingAddressAccountIds];
        
        // c.
        for (Contact contact : relatedContacts) {
            contact.Is_Synced__c = false;
            contact.Processed_By_Future__c = true;
        }
        update relatedContacts;
    }
}