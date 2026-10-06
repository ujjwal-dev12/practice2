public with sharing class ContactProcessor implements Queueable{

    private Set<Id> contactIds;

    public ContactProcessor (Set<Id> contactIds){
        this.contactIds = contactIds;
    }

    public void execute(QueueableContext context) {
      List<Contact> contacts = [
        SELECT Id,Description FROM Contact WHERE Id IN : contactIds
      ];

      for(Contact con : contacts){
        con.Description = 'Processed';
      }
      update contacts;
    }
}
