public with sharing class AccountTriggerHandlerHelper {
    public static void applyDescription(List<Account> newAccounts) {
        for (Account account : newAccounts) {
            account.Description = 'Description by default';
        }
    }

    public static void restrictAccountDeletion(Map<Id, Account> oldAccounts) {
        for (Account account : oldAccounts.values()) {
            account.addError('Account deletion is restricted by company policy!');
        }
    }

    public static void createCaseIfTypeChanged(Map<Id, Account> oldAccounts, Map<Id, Account> newAccounts) {
        List<Case> cases = new List<Case>();

        for (Account oldAccount : oldAccounts.values()) {
            if (oldAccount.Type != newAccounts.get(oldAccount.Id).Type) {
                cases.add(
                    new Case(
                        AccountId = oldAccount.Id,
                        Subject = 'Waiting for the customer\'s approval to change the type!'
                    )
                );
            }
        }

        insert cases;

        //AccountUpdateQueueable accountUpdateQueueable = new AccountUpdateQueueable(newAccounts.values());
        //System.enqueueJob(accountUpdateQueueable);
    }

    public static void call(Map<Id, Account> newAccounts) {
        if (AccountTriggerHandler.hasFired) {
            return;
        } else {
            AccountTriggerHandler.hasFired = true;
        }

        List<Account> accounts = [SELECT Id, AnnualRevenue FROM Account WHERE Id IN :newAccounts.values()];
        for (Account account : accounts) {
            account.AnnualRevenue = 1000;
        }

        update accounts;
    }

    // new comments here
}
