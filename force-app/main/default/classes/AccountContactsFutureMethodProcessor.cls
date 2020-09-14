public class AccountContactsFutureMethodProcessor {
	@future
    public static void processWithBillingAddressAccountContacts()
    {   
        List<Account> selectedAccounds = new List<Account>();
        List<Id> withBillingAddressAccountIds = new List<Id>();
        List<Contact> relatedContacts = new List<Contact>();

        // a.
    	selectedAccounds = [SELECT BillingAddress FROM Account LIMIT 150];
         
        // b.
        for (Account account : selectedAccounds) {
            if (account.BillingAddress != null) {
                withBillingAddressAccountIds.add(account.Id);
            }
        }
        relatedContacts = [SELECT Is_Synced__c, Processed_By_Future__c
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