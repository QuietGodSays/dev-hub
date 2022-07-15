public with sharing class LwcContactController {
    @AuraEnabled(Cacheable=true)
    public static List<Contact> findContacts(String searchKey) {
        String key = '%' + searchKey + '%';
        return [SELECT Id, Name, Title, Phone, Email FROM Contact WHERE Name LIKE :key];
    }

    @AuraEnabled(Cacheable=true)
    public static List<Contact> getContacts() {
        return [SELECT Id, Name, Title, Phone, Email FROM Contact LIMIT 10];
    }
}
