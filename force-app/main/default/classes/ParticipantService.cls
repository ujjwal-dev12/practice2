public  class ParticipantService {

    public static Account createParticipant(String participantName) {
        if(String.isBlank(participantName)){
          throw new AuraHandledException('Participant name is required');
        }
     Account participant = new Account(Name = participantName);
     insert participant;
     return participant;
}
}