@RestResource(UrlMapping='/apexSecurityRest')
global with sharing class ApexSecurityRest {
    @HttpGet
    global static Contact doGet() {
        Id recordId = RestContext.request.params.get('id');
        if (recordId == null) {
            throw new FunctionalException('Id parameter is required');
        }

        Contact result;

        List<Contact> results = [SELECT Id, Name, Title, Top_Secret__c, Account.Name FROM Contact WHERE Id = :recordId];

        if (!results.isEmpty()) {
            SObjectAccessDecision securityDecision = Security.stripInaccessible(AccessType.READABLE, results);

            if (
                !securityDecision.getRecords().isEmpty() &&
                securityDecision.getRecords().get(0).isSet(Contact.Description.getDescribe().getSobjectField())
            ) {
                result = (Contact) securityDecision.getRecords().get(0);
                result.Description = result.Account?.Name;
            }
        }

        return result;
    }

    public class FunctionalException extends Exception {
    }

    public class SecurityException extends Exception {
    }
}
