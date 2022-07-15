public with sharing class AccountController {
    @AuraEnabled
    public static List<Account> getAccountList() {
        return [SELECT Id, Name FROM Account LIMIT 100];
    }
}
