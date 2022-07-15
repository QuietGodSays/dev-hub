@IsTest
private class DataGeneration_Tests {

    @TestSetup
    private static void dataCreation() {
        Account account = TestFactory.getAccount('Muddy Waters Inc.', true);
        Contact contact = TestFactory.getContact(account.Id, 'Muddy', 'Waters', true);
        Opportunity opportunity = new Opportunity(Name = 'Long lost record', AccountId = account.Id,
                CloseDate = Date.today().addDays(14), StageName = 'Prospecting');
        insert opportunity;
    }

    @IsTest
    private static void testBruteForceAccountCreation() {
        List<Account> accounts = new List<Account>();

        Account account = new Account(Name = 'McTesterson LLC');
        insert account;

        Test.startTest();
        accounts = [SELECT Id FROM Account];
        Test.stopTest();

        System.assert(accounts.size() > 0, 'Was expecting to find at least one account');
    }

    @IsTest
    private static void testUseTestFactoryToCreateAccountsWithContacts() {
        List<Account> accounts;
        List<Contact> contacts;

        TestFactory.generateAccountWithContacts(5);

        Test.startTest();
        accounts = [SELECT Id FROM Account];
        contacts = [SELECT Id FROM Contact];
        Test.stopTest();

        System.assert(accounts.size() > 0, 'Was expecting to find at least one account');
        System.assertEquals(6, contacts.size(), 'Was expecting to find 6 contacts');
    }

    @IsTest
    private static void testAtTestSetupMethodRule() {
        List<Opportunity> opportunities = [SELECT Id FROM Opportunity];
        System.assertEquals(1, opportunities.size(), 'Expected test to find a single Opp');
    }
}