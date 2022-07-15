@IsTest
private class CaseManagerTest {
    @IsTest
    static void testGetCaseById() {
        Id recordId = createTestRecord();
        // Set up a test request
        RestRequest request = new RestRequest();
        request.requestURI = 'https://yourInstance.salesforce.com/services/apexrest/Cases/' + recordId;
        request.httpMethod = 'GET';
        RestContext.request = request;
        // Call the method to test
        Case thisCase = CaseManager.getCaseById();
        // Verify results
        System.assert(thisCase != null);
        System.assertEquals('Test record', thisCase.Subject);
    }

    @IsTest
    static void testDeleteCase() {
        Id recordId = createTestRecord();
        // Set up a test request
        RestRequest request = new RestRequest();
        request.requestURI = 'https://yourInstance.salesforce.com/services/apexrest/Cases/' + recordId;
        request.httpMethod = 'GET';
        RestContext.request = request;
        // Call the method to test
        CaseManager.deleteCase();
        // Verify record is deleted
        List<Case> cases = [SELECT Id FROM Case WHERE Id = :recordId];
        System.assert(cases.size() == 0);
    }

    @IsTest
    static void testUpdateCaseFields() {
        Id recordId = createTestRecord();
        RestRequest request = new RestRequest();
        request.requestURI = 'https://yourInstance.salesforce.com/services/apexrest/Cases/' + recordId;
        request.httpMethod = 'PATCH';
        request.addHeader('Content-Type', 'application/json');
        request.requestBody = Blob.valueOf('{"status": "Working"}');
        RestContext.request = request;
        // Update status of existing record to Working
        Id thisCaseId = CaseManager.updateCaseFields();
        // Verify record was updated
        System.assert(thisCaseId != null);
        Case thisCase = [SELECT Id, Status FROM Case WHERE Id = :thisCaseId];
        System.assert(thisCase != null);
        System.assertEquals(thisCase.Status, 'Working');
    }

    // Helper method
    static Id createTestRecord() {
        // Create test record
        Case caseTest = new Case(Subject = 'Test record', Status = 'New', Origin = 'Phone', Priority = 'Medium');
        insert caseTest;
        return caseTest.Id;
    }
}
