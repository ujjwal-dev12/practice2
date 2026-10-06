trigger AccountTrigger3 on Account (after update) {

    Set<Id> accountIds = new Set<Id>();

    For(Account acc : Trigger.new){
        Account oldAcc = Trigger.oldMap.get(acc.Id);
        if(acc.Phone != oldAcc.Phone){
            accountIds.add(acc.Id);
        }
    }

    List<Contact> contactsToUpdate = [SELECT Id,Phone,AccountId FROM Contact WHERE AccountId IN:accountIds];

    for(Contact con : contactsToUpdate){
        con.Phone = Trigger.newMap.get(con.AccountId).Phone;
    }

    if(!contactsToUpdate.isEmpty()){
        contactsToUpdate
    }

}