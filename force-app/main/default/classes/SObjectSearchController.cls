public with sharing class SObjectSearchController {
    private static final Set<String> SUPPORTED_SOBJECT_NAMES = new Set<String> { 
        'Account', 'Contact', 'Lead', 'Opportunity' };

    @AuraEnabled(cacheable=true)
    public static List<SObject> getSObjectList(String sObjectName, String searchKey) {
        if (SUPPORTED_SOBJECT_NAMES.contains(sObjectName)) {
            String key = '%' + searchKey + '%';
            String query = 'SELECT Id, Name FROM ' + sObjectName + 
                            ' WHERE Name LIKE :key WITH SECURITY_ENFORCED LIMIT 10';
            return Database.query(query);
        } else {
            throw new AuraHandledException('Searching records of "' + sObjectName + '" is not supported');
        }
    }
}
