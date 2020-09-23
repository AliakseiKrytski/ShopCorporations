public with sharing class AccountTriggerHandler {
    private Boolean m_isExecuting = false;


    public AccountTriggerHandler(boolean isExecuting){
        m_isExecuting = isExecuting;
    }

    public void onBeforeInsert(Account[] newAccounts){

    }

    public void onAfterInsert(Account[] newAccounts){

    }

    public void onBeforeUpdate(Account[] oldAccounts, Account[] updatedAccounts, Map<Id, Account> updatedAccountsMap){
    
    }

    public void onAfterUpdate(Account[] oldAccounts, Account[] updatedAccounts, Map<Id, Account> updatedAccountsMap){
        AccountTriggerHandlerHelper.rotateAccountRating(updatedAccountsMap);
    }

    public void onBeforeDelete(Account[] AccountsToDelete, Map<Id, Account> oldAccountsMap){

    }

    public void onAfterDelete(Account[] deletedAccounts, Map<Id, Account> oldAccountsMap){

    }

    public void onUndelete(Account[] restoredAccounts){

    }


    public boolean isTriggerContext {
        get{ return m_isExecuting;}
    }
}
