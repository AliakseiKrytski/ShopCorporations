public with sharing class ContactsController {
    @AuraEnabled
    public static Contact[] getContactsByAccountId(Id accountId) {
        return [SELECT FirstName, LastName, Phone, Email 
                FROM Contact
                WHERE AccountId = :accountId];
    }
}
