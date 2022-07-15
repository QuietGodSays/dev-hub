@IsTest
private class CSV_Tests {

    @TestSetup
    private static void loadTestDataFromStaticResource() {
        List<SObject> accounts = Test.loadData(Account.SObjectType, 'accountData');
    }

    @IsTest
    private static void testLoadAccountsFromStaticResource() {
        List<Account> accounts = [SELECT Id FROM Account];
        System.assertEquals(3, accounts.size(), 'Expected 3 accounts');
    }
}