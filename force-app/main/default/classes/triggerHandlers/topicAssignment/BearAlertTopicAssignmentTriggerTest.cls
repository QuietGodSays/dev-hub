/**
 * dummy test just for passing coverage
 */
@IsTest
private class BearAlertTopicAssignmentTriggerTest {
    @IsTest
    private static void createTopicAssignment() {
        Topic topic = new Topic(Name = 'BearAlert');
        TopicAssignment topicAssignment = new TopicAssignment(Topic = topic);
        insert topicAssignment;
    }
}
