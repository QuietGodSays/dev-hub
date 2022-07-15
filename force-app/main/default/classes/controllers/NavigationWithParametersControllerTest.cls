@IsTest
private class NavigationWithParametersControllerTest {
    @TestSetup
    private static void setup() {
        insert new Account(Name = 'Test Name');
    }

    @IsTest
    private static void getRandomAccount() {
        Account account;

        Test.startTest();
        account = NavigationWithParametersController.getRandomAccount();
        Test.stopTest();

        System.assert(account != null);
    }
}
