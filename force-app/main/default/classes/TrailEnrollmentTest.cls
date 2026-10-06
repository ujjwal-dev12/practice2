/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an org are executed whenever Apex code is deployed
 * to a production org to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production org. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the org size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class TrailEnrollmentTest {

    @isTest
    static void testTrailEnrollmentSuccess() {
        Account participant = new account (Name = 'Test');
        insert participant;

        Clinical_Trail__C trail = new Clinical_Trail__c(Clinical_Trail_Name__c = 'Test Trail');
        insert trail;

        Test.startTest();

        Trail_Enrollment__c result= EnrollmentService.createEnrollment(participant.Id,trail.Id);

        Test.stopTest();

        Trail_Enrollment__c savedEnrollment = [SELECT Id,Participant__c,Clinical_Trail__c 
        FROM Trail_Enrollment__c WHERE Id= :result.id];

        System.assertNotEquals(null, savedEnrollment.Id);

        System.assertEquals(participant.Id, savedEnrollment.Participant__c);
        System.assertEquals(trail.Id, savedEnrollment.Clinical_Trail__c);
    }

@isTest
static void testTrailEnrollmentWithoutParticipant(){
    Clinical_Trail__c trail = new Clinical_Trail__c(
        Clinical_Trail_Name__c = 'Test trail'
    );
    insert trail;

    Boolean exceptionThrown = false;

    Test.startTest();
    try {
        EnrollmentService.createEnrollment(null,trail);
        
    } catch (AuraHandledException e) {
        exceptionThrown = true;
    }

    Test.stopTest();

    System.assertEquals(true,exceptionThrown);
}

@isTest
static void testTrailEnrollmentWithoutTrial(){

    Account participant = new Account(
        Name = 'Test Participant'
    );
    insert participant;
   
    Boolean exceptionThrown = false;

    Test.startTest();
    try {
        EnrollmentService.createEnrollment(participant.Id,null);
        
    } catch (AuraHandledException e) {
        exceptionThrown = true;
    }

    Test.stopTest();

    System.assertEquals(true,exceptionThrown);
}

}
