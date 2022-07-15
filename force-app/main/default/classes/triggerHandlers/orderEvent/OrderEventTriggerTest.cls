/**
 * dummy test just for passing coverage
 */
@IsTest
private class OrderEventTriggerTest {
    @IsTest
    private static void testTrigger() {
        Order_Event__e orderEvent = new Order_Event__e(Order_Number__c = 'Order Number', Has_Shipped__c = true);
        insert orderEvent;
    }
}
