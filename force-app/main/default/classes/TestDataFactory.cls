@isTest
public class TestDataFactory {
    public static void insertTestAccountRecords(Integer accountsNumber) {
        List<Account> testAccounts = new List<Account>();
        for (Integer i = 1; i <= accountsNumber; i++) {
            testAccounts.add(new Account(
                Name='Test account record ' + i,
                Type='Prospect',
                AccountNumber='' + (890984 + i),
                Website='https://trailhead.salesforce.com',
                Phone='' + (2000001 + i),
                Rating='Cold'));
        }
        insert testAccounts;
    }  
}
