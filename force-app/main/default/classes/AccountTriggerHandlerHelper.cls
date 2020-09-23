public with sharing class AccountTriggerHandlerHelper {
    public static void rotateAccountRating(Map<Id, Account> updatedAccountsMap) {
        List<Account> accountsToUpdate = new List<Account>();
        accountsToUpdate = [SELECT Rating FROM Account WHERE Id IN :updatedAccountsMap.keySet()];
        for (Account accountToUpdate : accountsToUpdate) {
            if (accountToUpdate.Rating == 'Cold') {
                accountToUpdate.Rating = 'Warm';
            } else if (accountToUpdate.Rating == 'Warm') {
                accountToUpdate.Rating = 'Hot';
            } else {
                accountToUpdate.Rating = 'Cold';
            }
        }
        update accountsToUpdate;
    }
}
