trigger AccountTrigger2 on Account (after update) {acc

    Set<Id> changedAccountIds = new Set<Id>();

    for(Accounts acc : Trigger.new){
         Account oldAcc = Trigger.oldMap.get(acc.Id);

        if(acc.Industry != oldAcc.Industry){
            changedAccounts.add(acc.Id);
        }
    }

    List<Contact> contactsToUpdate = [
        SELECT Id,AccountId,Description FROM Contact WHERE AccountId IN : changedAccountIds
    ];

    for(Contact con : contactsToUpdate){
        Account acc = Trigger.newMap.get(con.AccountId);
        con.Description = 'Account Industry Changed';
    }

    if(!contactsToUpdate.isEmpty()){
        update contactsToUpdate;
    }
}