@IsTest
private class PositivePermission_tests {

    @TestSetup
    private static void testSetup() {
        Account account = TestFactory.getAccount('No view For You!', true);
        Private_Object__c privateObject = new Private_Object__c(Account__c = account.Id, notes__c = 'foo');
        insert privateObject;
    }

    @IsTest
    private static void userHavePermissionsTest() {
        User user = new User(ProfileId = [SELECT Id FROM Profile WHERE Name = :'Custom User'].Id, LastName = 'last',
                Email = 'Cpt.Awesome@awesomesauce.com', Alias = 'alias', TimeZoneSidKey = 'America/Los_Angeles',
                Username = 'Cpt.Awesome.' + Datetime.now().getTime() + '@awesomesauce.com', EmailEncodingKey = 'UTF-8',
                LanguageLocaleKey = 'en_US', LocaleSidKey = 'en_US');

        System.runAs(user) {
            List<Private_Object__c> privateObjects;

            Test.startTest();
            privateObjects = [SELECT Id, Account__c, notes__c FROM Private_Object__c];
            Test.stopTest();

            System.assert(privateObjects.size() > 0, 'A user should have the permissions to see the records.');
        }
    }
}