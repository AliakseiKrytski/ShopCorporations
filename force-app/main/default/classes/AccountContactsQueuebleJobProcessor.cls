public class AccountContactsQueuebleJobProcessor implements Queueable {
	public void execute(QueueableContext context) {
        List<Account> selectedAccounds = new List<Account>();
        List<Id> withBillingAddressAccountIds = new List<Id>();
        List<Contact> relatedContacts = new List<Contact>();

        selectedAccounds = [SELECT BillingAddress FROM Account LIMIT 150]; 

        // a.
        for (Account account : selectedAccounds) {
            if (account.BillingAddress != null) {
                withBillingAddressAccountIds.add(account.Id);
            }
        }
        relatedContacts = [SELECT Is_Synced__c, Processed_By_Queue__c
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