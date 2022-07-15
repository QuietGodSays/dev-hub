public with sharing class OrderEventTriggerHandler {
    public static void onAfterInsert(List<Order_Event__e> events) {
        OrderEventTriggerHandlerHelper.createTaskForShipped(events);
    }
}
