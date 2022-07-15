@IsTest
private class PlatformEventHandlerIntegrationTest {
    @IsTest
    private static void cloudNewsPublisherTest() {
        Test.startTest();
        // Call method to publish events
        PlatformEventHandler.cloudNewsPublisher();
        Test.stopTest();

        // Perform validation here
        // Verify that the publish was successful
        List<Case> cases = [SELECT Id FROM Case];

        System.assert(cases != null);
        System.assertEquals(2, cases.size());
    }
}
