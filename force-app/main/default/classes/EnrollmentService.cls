public class EnrollmentService {
  public static Trail_Enrollment__c createEnrollment(Id participantId, Id trailId){
    if(
        participantId == null || trailId == null
    ){
        throw new AuraHandledException ('Both fields are required ');
    }

    Trail_Enrollment__c enrollment = new Trail_Enrollment__c();

    enrollment.Participant__c = participantId;
    enrollment.Clinical_Trail__c = trailId;

    insert enrollment;
    return enrollment;

  }
}