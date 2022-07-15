@RestResource(urlMapping='/Accounts/*/contacts')
global with sharing class AccountManager {
    @HttpGet
    global static Account getAccount() {
        RestRequest request = RestContext.request;
        // grab the accountId from the end of the URL
        String tempId = request.requestURI.substringBeforeLast('/');
        String accountId = tempId.substring(tempId.lastIndexOf('/') + 1);
        Account account = [SELECT Id, Name, (SELECT Id, Name FROM Contacts) FROM Account WHERE Id = :accountId];
        return account;
    }
}
