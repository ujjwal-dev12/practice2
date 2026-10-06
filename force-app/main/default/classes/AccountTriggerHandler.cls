public class AccountTriggerHandler {


    // ==========================================
    // REQUIREMENT 1
    // Set High_Value__c based on Annual Revenue
    // ==========================================

    public void setHighValue(List<Account> newAccounts) {

        for (Account acc : newAccounts) {

            if (acc.AnnualRevenue != null &&
                acc.AnnualRevenue > 1000000) {

                acc.High_Value__c = true;

            } else {

                acc.High_Value__c = false;
            }
        }
    }



    // ==========================================
    // REQUIREMENT 2 + REQUIREMENT 3
    // Handle Account updates
    // ==========================================

    public void handleAfterUpdate(
        List<Account> newAccounts,
        Map<Id, Account> oldMap,
        Map<Id, Account> newMap
    ) {

        Set<Id> industryChangedAccountIds = new Set<Id>();
        Set<Id> phoneChangedAccountIds = new Set<Id>();


        // Find what changed
        for (Account acc : newAccounts) {

            Account oldAcc = oldMap.get(acc.Id);


            // Requirement 2
            if (acc.Industry != oldAcc.Industry) {

                industryChangedAccountIds.add(acc.Id);
            }


            // Requirement 3
            if (acc.Phone != oldAcc.Phone) {

                phoneChangedAccountIds.add(acc.Id);
            }
        }


        // Execute Requirement 2
        if (!industryChangedAccountIds.isEmpty()) {

            updateContactDescription(
                industryChangedAccountIds
            );
        }


        // Execute Requirement 3
        if (!phoneChangedAccountIds.isEmpty()) {

            updateContactPhone(
                phoneChangedAccountIds,
                newMap
            );
        }
    }



    // ==========================================
    // REQUIREMENT 2
    // Account Industry changed
    // Update Contact Description
    // ==========================================

    private void updateContactDescription(
        Set<Id> accountIds
    ) {

        List<Contact> contactsToUpdate = [
            SELECT Id, AccountId, Description
            FROM Contact
            WHERE AccountId IN :accountIds
        ];


        for (Contact con : contactsToUpdate) {

            con.Description =
                'Account Industry Changed';
        }


        if (!contactsToUpdate.isEmpty()) {

            update contactsToUpdate;
        }
    }



    // ==========================================
    // REQUIREMENT 3
    // Account Phone changed
    // Copy new phone to Contacts
    // ==========================================

    private void updateContactPhone(
        Set<Id> accountIds,
        Map<Id, Account> newMap
    ) {

        List<Contact> contactsToUpdate = [
            SELECT Id, AccountId, Phone
            FROM Contact
            WHERE AccountId IN :accountIds
        ];


        for (Contact con : contactsToUpdate) {

            Account acc = newMap.get(con.AccountId);

            con.Phone = acc.Phone;
        }


        if (!contactsToUpdate.isEmpty()) {

            update contactsToUpdate;
        }
    }
}