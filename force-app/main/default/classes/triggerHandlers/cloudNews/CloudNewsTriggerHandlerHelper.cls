public class CloudNewsTriggerHandlerHelper {
    public static void createCaseForUrgent(List<Cloud_News__e> events) {
        // List to hold all cases to be created.
        List<Case> cases = new List<Case>();

        // Get queue Id for case owner
        Group queue = [
            SELECT Id
            FROM Group
            WHERE DeveloperName = :Consts.REGIONAL_DISPATCH_QUEUE AND Type = :Consts.QUEUE
        ];

        // Iterate through each notification
        for (Cloud_News__e event : events) {
            if (event.Urgent__c == true) {
                // Create Case to dispatch new team
                Case urgentCase = new Case();
                urgentCase.Priority = Consts.HIGH_PRIORITY;
                urgentCase.Subject = 'News team dispatch to ' + event.Location__c;
                urgentCase.Description = event.News_Content__c;
                urgentCase.OwnerId = queue.Id;
                cases.add(urgentCase);
            }
        }

        // Insert all cases corresponding to events received
        insert cases;
    }
}
