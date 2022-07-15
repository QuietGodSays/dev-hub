public class BearAlertTopicAssignmentTriggerHandler {
    public static void onAfterInsert(List<TopicAssignment> topicAssignments) {
        BearAlertTopicAssignmentTriggerHelper.publishChatterPosts(topicAssignments);
    }
}
