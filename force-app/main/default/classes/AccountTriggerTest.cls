@isTest
private class AccountTriggerTest {
    @TestSetup
    static void makeData(){
        TestDataFactory.insertTestAccountRecords(200);
    }

    @isTest static void testUpdateAccount() {
        Account[] accounts = [SELECT AccountNumber FROM Account];
        for (Account account : accounts) {
            account.AccountNumber = '444444';
        }
        
        Test.startTest();
        Database.SaveResult[] results = Database.update(accounts, false);
        Test.stopTest();

        for (Database.SaveResult result : results) {
            System.assert(result.isSuccess());
        }
        for (Account updatedAccount : [SELECT Rating FROM Account]) {
            System.assertEquals('Warm', updatedAccount.Rating);
        }
    }
}
