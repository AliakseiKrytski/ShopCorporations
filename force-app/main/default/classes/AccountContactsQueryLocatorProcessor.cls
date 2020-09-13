public class AccountContactsQueryLocatorProcessor implements Database.Batchable<sObject> {
    private static final String QUERY = 'SELECT AccountId, Is_Synced__c, MailingStreet, MailingCity, MailingState, MailingPostalCode, MailingCountry, Account.BillingStreet, Account.BillingCity, Account.BillingState, Account.BillingPostalCode, Account.BillingCountry, Account.Updated_By_Contact__c FROM Contact WHERE Is_Synced__c = FALSE';
    
	public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(QUERY);
    }
    
    public void execute(Database.BatchableContext bc, List<sObject> scope) {
        List<Contact> updatedContacts = new List<Contact>();
        Set<Account> updatedContactsAccounts = new Set<Account>();
   		for (sObject s : scope){
            Contact contact = (Contact)s;
            // a.
            copyAccountAddressToContact(contact.Account, contact);
            // b.
            contact.Is_Synced__c = true;
            
        	updatedContacts.add(contact);
            updatedContactsAccounts.add(contact.Account);
        }
        update updatedContacts;
        
        // c.
        for (Account account : updatedContactsAccounts) {
            account.Updated_By_Contact__c = true;
        }
        update new List<Account>(updatedContactsAccounts);
    }
    
    private void copyAccountAddressToContact(Account account, Contact contact) {
        contact.MailingStreet = account.BillingStreet;
        contact.MailingCity = account.BillingCity;
        contact.MailingState = account.BillingState;
        contact.MailingPostalCode = account.BillingPostalCode;
        contact.MailingCountry = account.BillingCountry;
    }
    
    public void finish(Database.BatchableContext bc) {
        
    }
}