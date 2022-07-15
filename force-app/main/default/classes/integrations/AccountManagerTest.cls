@IsTest
public class AccountManagerTest {
    @TestSetup
    private static void setup() {
        Account account = new Account(Name = 'Test Account');
        insert account;

        Contact contact = new Contact(FirstName = 'Test', LastName = 'Contact', AccountId = account.Id);
        insert contact;
    }

    @IsTest
    private static void testGetAccount() {
        Id recordId = [SELECT Id FROM Account LIMIT 1].Id;
        // Set up a test request
        RestRequest request = new RestRequest();
        request.requestUri = 'https://yourInstance.salesforce.com/services/apexrest/Accounts/' + recordId + '/contacts';
        request.httpMethod = 'GET';
        RestContext.request = request;
        // Call the method to test
        Account account = AccountManager.getAccount();
        // Verify results
        System.assert(account != null);
        System.assertEquals('Test Account', account.Name);
    }
}
