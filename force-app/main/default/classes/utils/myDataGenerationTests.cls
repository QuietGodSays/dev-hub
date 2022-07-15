@IsTest
private class myDataGenerationTests {

    @TestSetup
    private static void setup() {
        Test.loadData(Account.SObjectType, 'Mock_Data');
    }

    @IsTest
    private static void accountLoadingFromCsvTest() {
        List<Account> accounts = [SELECT Id FROM Account];
        System.assertEquals(15, accounts.size(), 'Was expecting to find 15 accounts');
    }
}