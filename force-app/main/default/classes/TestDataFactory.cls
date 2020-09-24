@isTest
public class TestDataFactory {
    public static Id createTestAccountRecords() {
        Account testAccount = new Account(
            Name='Test account record 1',
            Type='Prospect',
            AccountNumber='890984',
            Website='https://trailhead.salesforce.com',
            Phone='9167895');
        insert testAccount;
        return testAccount.Id;
    }  
}
