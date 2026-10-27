trigger OpportunityTrigger2 on Opportunity (after insert) {
    List <Task> tasksToInsert = new List<Task>();

    for (Opportunity opp : Trigger.new){
        if(opp.IsWon){
            tasksToInsert.add(new Task(
                Subject='Follow up on Won Opportunity'
                WhatId = opp.Id,
                OwnerId= opp.Ownerid
            ));
        }
    }

    if(!tasksToInsert.isEmpty()){
        insert tasksToInsert;
    }

}