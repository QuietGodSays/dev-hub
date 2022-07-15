public with sharing class NavigationWithParametersController {
    @AuraEnabled
    public static Account getRandomAccount() {
        List<Account> accounts = [SELECT Id FROM Account LIMIT 1];

        Account acc = accounts.size() == 1 ? accounts.get(0) : null;

        if (acc != null) {
            return acc;
        } else {
            throw new AuraHandledException('Error was occur while getting random account!');
        }
    }
}
