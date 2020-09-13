@isTest
public class AccountContactsQueuebleJobProcessorTest {
	@isTest static void simpleTest() {
        List<Account> testAccounts = new List<Account>();
        Account currentAccount;
        for (Integer i = 0; i < 150; i++) {
            if (i < 110) {
            	currentAccount = new Account(Name='Acc'+i, BillingCountry='Belarus', BillingCity='Minsk');	    
            } else {
                currentAccount = new Account(Name='Acc'+i);
            }
            testAccounts.add(currentAccount);
        }
        insert testAccounts;
        
        List<Contact> testContacts = new List<Contact>();
        for (Account account : testAccounts) {
            testContacts.add(new Contact(LastName=account.Name+' contact', AccountId=account.Id));
        }
        insert testContacts;
        
        Test.startTest();        
        System.enqueueJob(new AccountContactsQueuebleJobProcessor());
        Test.stopTest();

        List<Contact> actualUpdatedContacts = [SELECT Id 
                                                 FROM Contact 
                                                 WHERE Is_Synced__c = FALSE AND Processed_By_Queue__c = TRUE];
        System.assertEquals(110, actualUpdatedContacts.size());
    }
}