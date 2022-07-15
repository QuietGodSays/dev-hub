@RestResource(UrlMapping='/Cases/*')
global with sharing class CaseManager {
    @HttpGet
    global static Case getCaseById() {
        RestRequest request = RestContext.request;
        // grab the caseId from the end of the URL
        String caseId = request.requestURI.substring(request.requestURI.lastIndexOf('/') + 1);
        Case result = [SELECT CaseNumber, Subject, Status, Origin, Priority, Description FROM Case WHERE Id = :caseId];
        return result;
    }

    @HttpPost
    global static Id createCase() {
        String body = RestContext.request.requestBody.toString();
        if (body != null) {
            Case c = (Case) JSON.deserialize(body, Case.class);
            c.Origin = 'Web';
            insert c;
            return c.Id;
        } else {
            return null;
        }
    }

    @HttpDelete
    global static void deleteCase() {
        RestRequest request = RestContext.request;
        String caseId = request.requestURI.substring(request.requestURI.lastIndexOf('/') + 1);
        Case thisCase = [SELECT Id FROM Case WHERE Id = :caseId];
        delete thisCase;
    }

    @HttpPatch
    global static Id updateCaseFields() {
        RestRequest request = RestContext.request;
        String caseId = request.requestURI.substring(request.requestURI.lastIndexOf('/') + 1);
        Case thisCase = [SELECT Id FROM Case WHERE Id = :caseId];
        // Deserialize the JSON string into name-value pairs
        Map<String, Object> params = (Map<String, Object>) JSON.deserializeUntyped(request.requestBody.toString());
        // Iterate through each parameter field and value
        for (String fieldName : params.keySet()) {
            // Set the field and value on the Case sObject
            thisCase.put(fieldName, params.get(fieldName));
        }
        update thisCase;
        return thisCase.Id;
    }
}
