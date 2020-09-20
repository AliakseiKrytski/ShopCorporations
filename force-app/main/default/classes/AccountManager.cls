@RestResource(urlMapping='/Account/*')
global with sharing class AccountManager {
    @HttpGet
    global static Account getAccountById() {
        RestRequest request = RestContext.request;
        String accountId = request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);
        return [SELECT Name,Type,AccountNumber,Website,Phone
                FROM Account
                WHERE Id = :AccountId];
    }

    @HttpPost
    global static Id createAccount(String Name, String Type,
        String AccountNumber, String Website, String Phone) {
        Account thisAccount = new Account(
            Name=Name,
            Type=Type,
            AccountNumber=AccountNumber,
            Website=Website,
            Phone=Phone);
        insert thisAccount;
        return thisAccount.Id;
    }

    @HttpDelete
    global static void deleteAccount() {
        RestRequest request = RestContext.request;
        String accountId = request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);
        Account thisAccount = [SELECT Id FROM Account WHERE Id = :accountId];
        delete thisAccount;
    }

    @HttpPut
    global static Id upsertAccount(String Name, String Type, 
    String AccountNumber, String Website, String Phone, String Id) {
        Account thisAccount = new Account(
            Id=Id,
            Name=Name,
            Type=Type,
            AccountNumber=AccountNumber,
            Website=Website,
            Phone=Phone);
        upsert thisAccount;
        return thisAccount.Id;
    }

    @HttpPatch
    global static Id updateAccountFields() {
        RestRequest request = RestContext.request;
        String accountId = request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);
        Account thisAccount = [SELECT Id FROM Account WHERE Id = :accountId];
        Map<String, Object> params = (Map<String, Object>) JSON.deserializeUntyped(request.requestbody.tostring());
        for(String fieldName : params.keySet()) {
            thisAccount.put(fieldName, params.get(fieldName));
        }
        update thisAccount;
        return thisAccount.Id;
    }
}