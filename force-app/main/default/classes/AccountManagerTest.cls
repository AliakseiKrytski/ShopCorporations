@isTest
private class AccountManagerTest {
    @TestSetup
    static void makeData(){
        TestDataFactory.insertTestAccountRecords(1);
    }

    @isTest static void testGetAccountById() {
        Account testAccount = [SELECT Id FROM Account WHERE Name = 'Test account record 1'];

        RestRequest request = new RestRequest();
        request.requestUri = 'https://ap16.salesforce.com/services/apexrest/Account/' + testAccount.Id;
        request.httpMethod = 'GET';
        RestContext.request = request;

        Account resultAccount = AccountManager.getAccountById();

        System.assert(resultAccount != null);
        System.assertEquals('Test account record 1', resultAccount.Name);
    }

    @isTest static void testCreateAccount() {
        ID thisAccountId = AccountManager.createAccount(
            'Funset test', 'Prospect', '461647', 'https://trailhead.salesforce.com', '4684164');
        
        System.assert(thisAccountId != null);
        Account thisAccount = [SELECT Name,Type,AccountNumber,Website,Phone FROM Account WHERE Id = :thisAccountId];
        System.assert(thisAccount != null);
        System.assertEquals(thisAccount.Name, 'Funset test');
    }

    @isTest static void testDeleteAccount() {
        Account testAccount = [SELECT Id FROM Account WHERE Name = 'Test account record 1'];

        RestRequest request = new RestRequest();
        request.requestUri = 'https://ap16.salesforce.com/services/apexrest/Account/' + testAccount.Id;
        request.httpMethod = 'GET';
        RestContext.request = request;

        AccountManager.deleteAccount();

        List<Account> accounts = [SELECT Id FROM Account WHERE Id = :testAccount.Id];
        System.assert(accounts.size() == 0);
    }

    @isTest static void testUpsertAccount() {
        Account account1 = [SELECT Name,Type,AccountNumber,Website,Phone FROM Account WHERE Name = 'Test account record 1'];

        System.assert(account1 != null);
        System.assertEquals(account1.Website, 'https://trailhead.salesforce.com');

        ID account2Id = AccountManager.upsertAccount(
            account1.Name, account1.Type, account1.AccountNumber, 'https://trailhead.sales.com', account1.Phone, account1.Id);

        System.assertEquals(account1.Id, account2Id);
        Account account2 = [SELECT Website,Phone FROM Account WHERE Id = :account2Id];
        System.assert(account2 != null);
        System.assertEquals(account2.Website, 'https://trailhead.sales.com');
        System.assertEquals(account2.Phone, account1.Phone);
    }  

    @isTest static void testUpdateAccountFields() {
        Account account = [SELECT Name,Type,AccountNumber,Website,Phone FROM Account WHERE Name = 'Test account record 1'];

        RestRequest request = new RestRequest();
        request.requestUri = 'https://ap16.salesforce.com/services/apexrest/Account/' + account.Id;
        request.httpMethod = 'PATCH';
        request.addHeader('Content-Type', 'application/json');
        request.requestBody = Blob.valueOf('{"Website": "https://trailhead.force.com"}');
        RestContext.request = request;

        ID thisAccountId = AccountManager.updateAccountFields();

        System.assert(thisAccountId != null);
        Account thisAccount = [SELECT Website FROM Account WHERE Id = :thisAccountId];
        System.assert(thisAccount != null);
        System.assertEquals(thisAccount.Website, 'https://trailhead.force.com');
    }
}
