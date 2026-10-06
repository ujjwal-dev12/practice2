trigger AccountTrigger on Account (
    before insert,
    before update,
    after update
) {

    AccountTriggerHandler handler = new AccountTriggerHandler();

    // Requirement 1
    // Set High_Value__c based on AnnualRevenue
    if (Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)) {

        handler.setHighValue(Trigger.new);
    }


    // Requirement 2 + Requirement 3
    // Industry change + Phone change
    if (Trigger.isAfter && Trigger.isUpdate) {

        handler.handleAfterUpdate(
            Trigger.new,
            Trigger.oldMap,
            Trigger.newMap
        );
    }
}