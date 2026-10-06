public with sharing class ChecklistController {

    public class QuestionWrapper{
        @AuraEnabled
        public Id questionId;

        @AuraEnabled
        public String questiontext;

        @AuraEnabled
        public String questionType;

        @AuraEnabled
        public Boolean required;

        @AuraEnabled
        public Integer displayOrder;
    }

    @AuraEnabled(cachebale=true)
    public static List<QuestionWrapper> getQuestions(Id workOrderId){
        WorkOrder wo = [SELECT Id,WorkTypeId FROM WorkOrder WHERE Id= :workOrderId];

        Derivative_Table__c config = [SELECT Checklist_Category__c FROM Derivative_Table__c WHERE Work_Type__c = :wo.WorkTypeId LIMIT 1];

        List<Checklist_Map__c> questions = [SELECT Id,Question_Text__c,Question_Type__c,Required__c,Display_Order__c FROM Checklist_Map__c
        WHERE Checklist_Category__c = :config.Checklist_Category__c ORDER BY Display_Order__C];

        List<QuestionWrapper> results = new List<QuestionWrapper>();

        for(Checklist_Map__c q:questions){
            QuestionWrapper wrapper = new QuestionWrapper();

            wrapper.questionId = q.Id;
            wrapper.questonText = q.Question_Text__c;
            wrapper.questionType = q.Question_Type__c;
            wrapper.required= q.Required__c;
            wrapper.displayorder= Integer.valueOf(q.Display_Order__c);
            results.add(wrapper);
        }
        return results;
    }
}