public with sharing class ContactsController {
    private static final Integer MAX_AVAILABLE_RECORDS_COUNT = 200;

    @AuraEnabled
    public static Contact[] getContactsByAccountId(Id accountId) {
        return [SELECT FirstName, LastName, Phone, Email 
                FROM Contact
                WHERE AccountId = :accountId];
    }

    @AuraEnabled(cacheable=true)
    public static Contact[] getSliceOfAllContacts(Integer offset, Integer maxCount) {
        if (maxCount > MAX_AVAILABLE_RECORDS_COUNT && maxCount <= 0) {
            throw new AuraHandledException('Value of the maxCount param is unavailable');
        } else if (offset < 0) {
            throw new AuraHandledException('Value of the offset param must be non-negative');
        } else {
            return [SELECT FirstName, LastName, Phone, Email 
                    FROM Contact
                    ORDER BY LastName, FirstName, Id
                    LIMIT :maxCount
                    OFFSET :offset];
        }
    }

    @AuraEnabled(cacheable=true)
    public static Integer getAllContactCount() {
        return [SELECT COUNT() FROM Contact];
    }
}
