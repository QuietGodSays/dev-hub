public class BookTriggerHandler extends TriggerHandler {
    public BookTriggerHandler() {
    }

    public override void beforeInsert() {
        BookTriggerHandlerHelper.revenueInitCalculation((List<Book__c>) Trigger.new);
    }

    public override void afterInsert() {
    }

    public override void beforeUpdate() {
        BookTriggerHandlerHelper.revenueRecalculationIfAmountSoldChanges(
            (List<Book__c>) Trigger.new,
            (Map<Id, Book__c>) Trigger.oldMap
        );
    }

    public override void afterUpdate() {
    }
}
