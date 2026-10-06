public with sharing class AccountQueable implements Queueable{

private Set<Id> accountIds;

public AccountQueable(Set<Id> accountIds){
    this.accountIds=accountIds;
}

public void execute (QueueableContext context){
    List<Account> accounts = [
        SELECT Id,Description FROM Account WHERE Id IN : accountIds
    ];

  
    for(Account acc : accounts ){

        acc.Description = 'Processed By queable';
    }

    if(!accounts.isEmpty()) {
        update accounts;
    }
}
}



Set<Ids> accountIds = new Set<Id>{567aw};
System.enqueueJob(
   new AccountQueable(accountIds);
)
