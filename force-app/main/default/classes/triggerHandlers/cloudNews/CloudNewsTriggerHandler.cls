public class CloudNewsTriggerHandler {
    public static void onAfterInsert(List<Cloud_News__e> events) {
        CloudNewsTriggerHandlerHelper.createCaseForUrgent(events);
    }
}
