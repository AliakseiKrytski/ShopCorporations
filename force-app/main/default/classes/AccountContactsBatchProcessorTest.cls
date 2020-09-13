@isTest
public class AccountContactsBatchProcessorTest {
    @isTest static void queryLocatorBatchTest() {
        List<Account> testAccounts = new List<Account>();
        Account currentAccount;
        for (Integer i = 0; i < 150; i++) {
            testAccounts.add(new Account(Name='Acc'+i, BillingCountry='Belarus', BillingCity='Minsk'));
        }
        insert testAccounts;
        
        List<Contact> testContacts = new List<Contact>();
        for (Account account : testAccounts) {
            testContacts.add(new Contact(LastName=account.Name+' contact', AccountId=account.Id, Is_Synced__c=false));
        }
        insert testContacts;
        
        Test.startTest();        
        Database.executeBatch(new AccountContactsQueryLocatorProcessor());
        Test.stopTest();

        Integer actualUpdatedContactsCount = [SELECT Count() 
                                                 FROM Contact 
                                                 WHERE Is_Synced__c = TRUE AND MailingCountry != NULL AND MailingCity != NULL];
        System.assertEquals(150, actualUpdatedContactsCount);
        
      	Integer actualUpdatedAccountsCount = [SELECT Count()
                                                 FROM Account 
                                                 WHERE Updated_By_Contact__c = TRUE];
        System.assertEquals(150, actualUpdatedAccountsCount);
    }
    
    @isTest static void iterableBatchTest() {
        List<Account> testAccounts = new List<Account>();
        Account currentAccount;
        for (Integer i = 0; i < 150; i++) {
            testAccounts.add(new Account(Name='Acc'+i, BillingCountry='Belarus', BillingCity='Minsk'));
        }
        insert testAccounts;
        
        List<Contact> testContacts = new List<Contact>();
        for (Account account : testAccounts) {
            testContacts.add(new Contact(LastName=account.Name+' contact', AccountId=account.Id, Is_Synced__c=false));
        }
        insert testContacts;
        
        Test.startTest();        
        Database.executeBatch(new AccountContactsIterableProcessor());
        Test.stopTest();

        Integer actualUpdatedContactsCount = [SELECT Count() 
                                                 FROM Contact 
                                                 WHERE Is_Synced__c = TRUE AND MailingCountry != NULL AND MailingCity != NULL];
        System.assertEquals(150, actualUpdatedContactsCount);
        
      	Integer actualUpdatedAccountsCount = [SELECT Count()
                                                 FROM Account 
                                                 WHERE Updated_By_Contact__c = TRUE];
        System.assertEquals(150, actualUpdatedAccountsCount);
    }
}