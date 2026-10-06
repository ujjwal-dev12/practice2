public with sharing class Opportunityprocessor implements Queueable{
    private Set<Id> opportunityIds;
    public Opportunityprocessor(Set<Id> opportunityIds){
        this.opportunityIds = opportunityIds;
    }
    public void execute(QueueableContext context) {
        List<Opportunity> opportunities = [SELECT Id,Description FROM Opportunity WHERE Id IN :opportunityIds];
        for(Opportunity opp : opportunities){
            opp.Description = 'Processed Async';
        }
        if(!opportunities.isEmpty()){
            update opportunities;
        }
    }
}
