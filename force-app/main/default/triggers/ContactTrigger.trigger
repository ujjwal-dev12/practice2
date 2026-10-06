trigger ContactTrigger on Contact (after insert) {

    Set<Id> accountIds = new Set<Id>();

    for(Contact c: Trigger.new){
        if(c.AccountId != null){
            accountIds.add(c.AccountId);
        }
    }

    List<Account> accountsToUpdate = 
    [SELECT Id,Description FROM Account WHERE Id IN : accountIds];

    for(Account acc: accountsToUpdate){
        acc.Description = 'Contact Added';
    }

    if(!accountsToUpdate.isEmpty()){
        update accountsToUpdate;
    }

}