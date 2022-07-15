trigger AccountTrigger on Account(
    before insert,
    before update,
    before delete,
    after insert,
    after update,
    after delete,
    after undelete
) {
    /*if (Trigger.isInsert && Trigger.isBefore) {
        AccountTriggerHandler.beforeInsert(Trigger.new);
    } else if (Trigger.isInsert && Trigger.isAfter) {
        AccountTriggerHandler.afterInsert(Trigger.newMap);
    } else if (Trigger.isUpdate && Trigger.isBefore) {
        AccountTriggerHandler.beforeUpdate(Trigger.oldMap, Trigger.newMap);
    } else if (Trigger.isUpdate && Trigger.isAfter) {
        AccountTriggerHandler.afterUpdate(Trigger.oldMap, Trigger.newMap);
    } else if (Trigger.isDelete && Trigger.isBefore) {
        AccountTriggerHandler.beforeDelete(Trigger.oldMap);
    } else if (Trigger.isDelete && Trigger.isAfter) {
        AccountTriggerHandler.afterDelete(Trigger.oldMap);
    } else if (Trigger.isUndelete && Trigger.isAfter) {
        AccountTriggerHandler.afterUndelete(Trigger.newMap);
    }*/
}
