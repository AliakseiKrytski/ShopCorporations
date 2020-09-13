public class AccountContactsIterableProcessor implements Database.Batchable<Contact> {
	public Iterable<Contact> start(Database.BatchableContext bc) {
        return new UnsyncedContactsIterable();
    }
    
    public void execute(Database.BatchableContext bc, List<Contact> scope) {
        List<Contact> updatedContacts = new List<Contact>();
        Set<Account> updatedContactsAccounts = new Set<Account>();
   		for (Contact contact : scope){
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
    
    
    public class UnsyncedContactsIterator implements Iterator<Contact> {
		List<Contact> contacts { get; set; } 
   		Integer i { get; set; } 
 
       public UnsyncedContactsIterator() { 
           contacts = 
           [SELECT AccountId, 
            Is_Synced__c, 
            MailingStreet, MailingCity, MailingState, MailingPostalCode, MailingCountry, 
            Account.BillingStreet, Account.BillingCity, Account.BillingState, Account.BillingPostalCode, Account.BillingCountry, 
            Account.Updated_By_Contact__c 
            FROM Contact 
            WHERE Is_Synced__c = FALSE]; 
           i = 0; 
       }   
 
       public boolean hasNext(){ 
           return (i < contacts.size());
       }    
     
       public Contact next(){ 
           i++; 
           if(i > contacts.size()) {
               return null;
           } 
           return contacts[i-1]; 
       }         
    }
    
    public class UnsyncedContactsIterable implements Iterable<Contact>{
       public Iterator<Contact> Iterator() {
          return new UnsyncedContactsIterator();
       }
    }
}