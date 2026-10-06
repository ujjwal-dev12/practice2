trigger OpportunityTrigger on Opportunity (before update) {
    for (Opportunity opp : Trigger.new) {
        Opportunity oldOpp = Trigger.oldMap.get(opp.Id);

        if(
            opp.StageName == 'Closed Won' && oldOpp.StageName != 'Closed Won'
        ){
            opp.Description = 'Deal Completed';
        }

    }

}