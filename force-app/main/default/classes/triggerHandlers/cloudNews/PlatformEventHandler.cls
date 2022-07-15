global class PlatformEventHandler {
    global static void cloudNewsPublisher() {
        // List to hold event objects to be published.
        List<Cloud_News__e> cloudNewsEvents = new List<Cloud_News__e>();

        // Create event objects.
        Cloud_News__e cloudNewsEvent1 = new Cloud_News__e(
            Location__c = 'Mountain City',
            Urgent__c = true,
            News_Content__c = 'Lake Road is closed due to mudslides.'
        );
        Cloud_News__e cloudNewsEvent2 = new Cloud_News__e(
            Location__c = 'Mountain City',
            Urgent__c = false,
            News_Content__c = 'Small incident on Goat Lane causing traffic.'
        );

        // Add event objects to the list.
        cloudNewsEvents.add(cloudNewsEvent1);
        cloudNewsEvents.add(cloudNewsEvent2);

        // Call method to publish events.
        List<Database.SaveResult> saveResults = EventBus.publish(cloudNewsEvents);

        // Inspect publishing result for each event
        for (Database.SaveResult saveResult : saveResults) {
            if (saveResult.isSuccess()) {
                System.debug('Successfully published event.');
            } else {
                for (Database.Error error : saveResult.getErrors()) {
                    System.debug('Error returned: ' + error.getStatusCode() + ' - ' + error.getMessage());
                }
            }
        }
    }
}
