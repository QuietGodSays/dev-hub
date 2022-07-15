@isTest
private class OpportunityTriggerHandlerHelperTest {
    @TestSetup
    static void setup() {
        List<Account> accounts = new List<Account>{
            new Account(Name = 'Test Account 1'),
            new Account(Name = 'Test Account 2'),
            new Account(Name = 'Test Account 3')
        };

        insert accounts;

        List<Opportunity> opportunities = new List<Opportunity>{
            new Opportunity(
                Name = 'Test Opp 1',
                StageName = 'Prospecting',
                CloseDate = System.today().addDays(10),
                AccountId = accounts.get(0).Id,
                Amount = 10000.00
            ),
            new Opportunity(
                Name = 'Test Opp 2',
                StageName = 'Closed Won',
                CloseDate = System.today().addDays(12),
                AccountId = accounts.get(0).Id,
                Amount = 20000.00
            ),
            new Opportunity(
                Name = 'Test Opp 3',
                StageName = 'Closed Won',
                CloseDate = System.today().addDays(15),
                AccountId = accounts.get(0).Id,
                Amount = 30000.00
            ),
            new Opportunity(
                Name = 'Test Opp 4',
                StageName = 'Closed Won',
                CloseDate = System.today().addDays(20),
                AccountId = accounts.get(0).Id,
                Amount = 80000.00
            ),
            new Opportunity(
                Name = 'Test Opp 5',
                StageName = 'Closed Won',
                CloseDate = System.today().addDays(18),
                AccountId = accounts.get(1).Id,
                Amount = 40000.00
            ),
            new Opportunity(
                Name = 'Test Opp 6',
                StageName = 'Prospecting',
                CloseDate = System.today().addDays(18),
                AccountId = accounts.get(1).Id,
                Amount = 40000.00
            ),
            new Opportunity(
                Name = 'Test Opp 7',
                StageName = 'Closed Won',
                CloseDate = System.today().addDays(20),
                AccountId = accounts.get(1).Id,
                Amount = 70000.00
            ),
            new Opportunity(
                Name = 'Test Opp 8',
                StageName = 'Closed Won',
                CloseDate = System.today().addDays(20),
                AccountId = accounts.get(2).Id,
                Amount = 50000.00
            ),
            new Opportunity(
                Name = 'Test Opp 9',
                StageName = 'Closed Won',
                CloseDate = System.today().addDays(20),
                AccountId = accounts.get(2).Id,
                Amount = 60000.00
            ),
            new Opportunity(
                Name = 'Test Opp 10',
                StageName = 'Prospecting',
                CloseDate = System.today().addDays(20),
                AccountId = accounts.get(2).Id,
                Amount = 100000.00
            )
        };

        insert opportunities;
    }

    @isTest
    static void testCalculationAmountOnAccountSingleInsert() {
        List<Account> accounts = [SELECT Id, Name, Total_Amount__c FROM Account WHERE Name = 'Test Account 1'];

        Test.startTest();
        if (accounts.size() > 0) {
            Opportunity opp = new Opportunity(
                Name = 'Test Opp 11',
                StageName = 'Closed Won',
                CloseDate = System.today().addDays(22),
                AccountId = accounts.get(0).Id,
                Amount = 60000.00
            );
            insert opp;
        }
        Test.stopTest();

        accounts = [SELECT Id, Name, Total_Amount__c FROM Account WHERE Name = 'Test Account 1'];

        if (accounts.size() > 0) {
            System.assertEquals(accounts.get(0).Total_Amount__c, 190000.00);
        }
    }

    @isTest
    static void testCalculationAmountOnAccountBulkInsert() {
        List<Account> accounts = [SELECT Id, Name, Total_Amount__c FROM Account];

        Test.startTest();
        if (accounts.size() > 0) {
            List<Opportunity> opportunities = new List<Opportunity>();
            for (Integer i = 0; i < 3; i++) {
                opportunities.add(
                    new Opportunity(
                        Name = 'New Test Opp ' + i,
                        StageName = 'Closed Won',
                        CloseDate = System.today().addDays(22),
                        AccountId = accounts.get(i).Id,
                        Amount = 50000.00
                    )
                );
            }
            insert opportunities;
        }
        Test.stopTest();

        accounts = [SELECT Id, Name, Total_Amount__c FROM Account];

        if (accounts.size() > 0) {
            System.assertEquals(accounts.get(0).Total_Amount__c, 180000.00);
            System.assertEquals(accounts.get(1).Total_Amount__c, 160000.00);
            System.assertEquals(accounts.get(2).Total_Amount__c, 160000.00);
        }
    }

    @isTest
    static void testCalculationAmountOnAccountSingleUpdate() {
        List<Opportunity> opportunities = [
            SELECT Id, Name, Amount, StageName
            FROM Opportunity
            WHERE Name = 'Test Opp 1'
        ];

        Test.startTest();
        if (opportunities.size() > 0) {
            opportunities.get(0).StageName = 'Closed Won';
            update opportunities.get(0);
        }
        Test.stopTest();

        List<Account> accounts = [SELECT Id, Name, Total_Amount__c FROM Account WHERE Name = 'Test Account 1'];

        if (accounts.size() > 0) {
            System.assertEquals(accounts.get(0).Total_Amount__c, 140000.00);
        }
    }

    @isTest
    static void testCalculationAmountOnAccountBulkUpdate() {
        List<Opportunity> opportunities = [SELECT Id, Name, Amount, StageName FROM Opportunity];

        Test.startTest();
        if (opportunities.size() > 0) {
            for (Opportunity opp : opportunities) {
                opp.Amount = 100000.00;
            }
            update opportunities;
        }
        Test.stopTest();

        List<Account> accounts = [SELECT Id, Name, Total_Amount__c FROM Account];

        if (accounts.size() > 0) {
            System.assertEquals(accounts.get(0).Total_Amount__c, 300000.00);
            System.assertEquals(accounts.get(1).Total_Amount__c, 200000.00);
            System.assertEquals(accounts.get(2).Total_Amount__c, 200000.00);
        }
    }

    @isTest
    static void testCalculationAmountOnAccountSingleDelete() {
        List<Opportunity> opportunities = [
            SELECT Id, Name, Amount, StageName
            FROM Opportunity
            WHERE Name = 'Test Opp 2'
        ];

        Test.startTest();
        if (opportunities.size() > 0) {
            delete opportunities.get(0);
        }
        Test.stopTest();

        List<Account> accounts = [SELECT Id, Name, Total_Amount__c FROM Account WHERE Name = 'Test Account 1'];

        if (accounts.size() > 0) {
            System.assertEquals(accounts.get(0).Total_Amount__c, 110000.00);
        }
    }

    @isTest
    static void testCalculationAmountOnAccountBulkDelete() {
        List<Opportunity> opportunities = [SELECT Id, Name, Amount, StageName FROM Opportunity];

        Test.startTest();
        if (opportunities.size() > 0) {
            delete opportunities;
        }
        Test.stopTest();

        List<Account> accounts = [SELECT Id, Name, Total_Amount__c FROM Account];

        if (accounts.size() > 0) {
            System.assertEquals(accounts.get(0).Total_Amount__c, 0.00);
            System.assertEquals(accounts.get(1).Total_Amount__c, 0.00);
            System.assertEquals(accounts.get(2).Total_Amount__c, 0.00);
        }
    }
}
