@IsTest
private class AccountWrapper_Tests {

    @TestSetup
    private static void loadTestData() {
        List<Account> accounts = (List<Account>) Test.loadData(Account.SObjectType, 'accountData');
        List<Opportunity> opportunities = new List<Opportunity>();

        for (Account account : accounts) {
            opportunities.addAll(TestFactory.generateOpportunitiesForAccount(account.Id, 1000.00, 5));
        }

        insert opportunities;
    }

    @IsTest
    private static void testPositiveRoundedAveragePrice() {
        List<AccountWrapper> accounts = new List<AccountWrapper>();

        for (Account account : [SELECT Id, Name FROM Account]) {
            accounts.add(new AccountWrapper(account));
        }

        //Sanity check asserting that we have opportunities before executing our tested method
        List<Opportunity> sanityCheckListOfOpportunities = [SELECT Id FROM Opportunity];
        System.assert(sanityCheckListOfOpportunities.size() > 0, 'You need an opportunity to continue');

        Test.startTest();
        for (AccountWrapper accountWrapper : accounts) {
            System.assertEquals(accountWrapper.getRoundedAvgPriceOfOpps(), 1000.00, 'Expected to get 1000.00');
        }
        Test.stopTest();
    }

    @IsTest
    private static void isHighPriorityTest() {
        List<AccountWrapper> accounts = new List<AccountWrapper>();
        List<Opportunity> opportunities = new List<Opportunity>();

        for (Account account : [SELECT Id, Name FROM Account]) {
            opportunities.addAll(TestFactory.generateOpportunitiesForAccount(account.Id, 1000000.00, 5));
            accounts.add(new AccountWrapper(account));
        }
        insert opportunities;

        Test.startTest();
        for (AccountWrapper accountWrapper : accounts) {
            System.assert(accountWrapper.isHighPriority(), 'Expected to get \'true\'');
        }
        Test.stopTest();
    }

    @IsTest
    private static void testNegativeAccountWrapperRoundedOpportunities() {
        List<Account> accounts = [SELECT Id FROM Account];
        List<Opportunity> opportunities = [SELECT Id, Amount FROM Opportunity WHERE AccountId IN :accounts];
        List<AccountWrapper> accountWrappers = new List<AccountWrapper>();

        for (Opportunity opportunity : opportunities) {
            opportunity.Amount = 0;
        }
        update opportunities;

        for (Account account : accounts) {
            accountWrappers.add(new AccountWrapper(account));
        }

        Test.startTest();
        List<Boolean> exceptions = new List<Boolean>();

        for (AccountWrapper accountWrapper : accountWrappers) {
            try {
                accountWrapper.getRoundedAvgPriceOfOpps();
            } catch(AccountWrapper.AWException awe) {
                if (awe.getMessage().equalsIgnoreCase('No won Opportunities')) {
                    exceptions.add(true);
                }
            }
        }
        Test.stopTest();

        System.assertNotEquals(null, exceptions, 'Expected at least one exception to have occured');

        for (Boolean bool : exceptions) {
            System.assert(bool, 'Account should have thrown an exception');
        }
    }
}