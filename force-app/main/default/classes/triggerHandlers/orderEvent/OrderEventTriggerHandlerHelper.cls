public with sharing class OrderEventTriggerHandlerHelper {
    public static void createTaskForShipped(List<Order_Event__e> events) {
        List<Task> tasks = new List<Task>();

        for (Order_Event__e event : events) {
            if (event.Has_Shipped__c == true) {
                Task shippedTask = new Task(
                    Priority = Consts.MEDIUM_PRIORITY,
                    OwnerId = event.CreatedById,
                    Subject = 'Follow up on shipped order ' + event.Order_Number__c
                );
                tasks.add(shippedTask);
            }
        }

        insert tasks;
    }
}
