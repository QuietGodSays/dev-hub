public class BearAlertTopicAssignmentTriggerHelper {
    public static void publishChatterPosts(List<TopicAssignment> topicAssignments) {
        // Get FeedItem posts only
        Set<Id> feedIds = new Set<Id>();

        for (TopicAssignment ta : topicAssignments) {
            if (ta.EntityId.getSobjectType().getDescribe().getName().equals(Consts.FEED_ITEM)) {
                feedIds.add(ta.EntityId);
            }
        }

        // Load FeedItem bodies
        Map<Id, FeedItem> feedItems = new Map<Id, FeedItem>([SELECT Body FROM FeedItem WHERE Id IN :feedIds]);

        // Create messages for each FeedItem that contains the BearAlert topic
        List<String> messages = new List<String>();
        for (TopicAssignment ta : [
            SELECT Id, EntityId, Topic.Name
            FROM TopicAssignment
            WHERE Id IN :topicAssignments AND Topic.Name = :Consts.BEAR_ALERT
        ]) {
            messages.add(feedItems.get(ta.EntityId).Body.stripHtmlTags().abbreviate(255));
        }

        // Publish messages as notifications
        List<Notification__e> notifications = new List<Notification__e>();

        for (String message : messages) {
            notifications.add(new Notification__e(Message__c = message));
        }

        List<Database.SaveResult> results = EventBus.publish(notifications);

        // Inspect publishing results
        for (Database.SaveResult result : results) {
            if (!result.isSuccess()) {
                for (Database.Error error : result.getErrors()) {
                    System.debug('Error returned: ' + error.getStatusCode() + ' - ' + error.getMessage());
                }
            }
        }
    }
}
