public with sharing class AccountTriggerHandler {
    public static Boolean hasFired = false;

    public static void beforeInsert(List<Account> newAccounts) {
        AccountTriggerHandlerHelper.applyDescription(newAccounts);
    }

    public static void afterInsert(Map<Id, Account> newAccounts) {
        /** after insert helper method execution **/
    }

    public static void beforeUpdate(Map<Id, Account> oldAccounts, Map<Id, Account> newAccounts) {
        //AccountTriggerHandlerHelper.createCaseIfTypeChanged(oldAccounts, newAccounts);
    }

    public static void afterUpdate(Map<Id, Account> oldAccounts, Map<Id, Account> newAccounts) {
        AccountTriggerHandlerHelper.call(newAccounts);
    }

    public static void beforeDelete(Map<Id, Account> oldAccounts) {
        AccountTriggerHandlerHelper.restrictAccountDeletion(oldAccounts);
    }

    public static void afterDelete(Map<Id, Account> oldAccounts) {
        /** after delete helper method execution **/
    }

    public static void afterUndelete(Map<Id, Account> newAccounts) {
        /** after undelete helper method execution **/
    }
}
