trigger AccountTrigger4 on Account (before delete) {
    Set<Id> accountIds = Trigger.oldMap.keySet();

    Set<Id> blockedAccountIds = new Set<Id>();

    for(Opportunity opp : [ 
        SELECT AccountId FROM Opportunity WHERE AccountId IN :accountIds AND IsClosed = false
    ]){
       blockedAccountIds.add(opp.AccountId);
    }

    for(Account acc : trigger.old){
        if (blockedAccountIds.contians(acc.Id)){
            acc.addError('Cannot delete account')
        }
    }

}