public class AccountContactsQueuebleJobProcessor implements Queueable {
	public void execute(QueueableContext context) {
    	List<Account> selectedAccounds = [SELECT BillingAddress FROM Account LIMIT 150];
         
        // a.
        List<Id> withBillingAddressAccountIds = new List<Id>();
        for (Account account : selectedAccounds) {
            if (account.BillingAddress != null) {
                withBillingAddressAccountIds.add(account.Id);
            }
        }
        List<Contact> relatedContacts = [SELECT Is_Synced__c, Processed_By_Queue__c
                                        FROM Contact
                                        WHERE AccountId IN :withBillingAddressAccountIds];
        
        // b.
        for (Contact contact : relatedContacts) {
            contact.Is_Synced__c = false;
            contact.Processed_By_Queue__c = true;
        }
        update relatedContacts;        
    }
}