global with sharing class ContactService {
    public ContactService() {

    }

    /**
     * API service create contact
     * 
     * @param contact Contact
     * @return Contact
     */
    public static Contact createContact(Contact contact) {
        insert contact;

        return contact;
    }

    public static void createContactWithoutAccount(String name) {
        Contact contact = new Contact();
        insert contact;
    }

    /**
     * 
     * API service create contact with account
     * 
     * @param contactId String, @param accountId String
     * @return Contact
     */
    public static Contact createContactWithAccount(String contactId, String accountId) {
        Account account = AccountService.getAccountById(accountId);
        Contact contact = getContactById(contactId);

        contact.Account = account;
        contact.AccountID = account.Id;
        contact.Counter__c = 0;
        contact.Active__c = true;

        upsert contact;

        return contact;
    }

    /**
     * Filter records in database by name
     * if name == null return all data, else filter by name;
     * 
     * @param name String
     * @return List<Contact>
     */
    public static List<Contact> searchContactByName(String name) {
        if (name == null || name == '') {
            return [SELECT Id, Account.Name, Name, AccountID, Counter__c, Active__c FROM Contact]; 
        }
        String likeName = '%' + name + '%';
        List<Contact> results = [SELECT Id, Account.Name, Name, AccountID, Counter__c, Active__c FROM Contact WHERE Name like :likeName];
        return results;
    }


    /**
     * Get record in database by Id;
     * @param id String
     * @return Contact
     */
    public static Contact getContactById(String id) {
        Contact result = [SELECT Id, Account.Name, AccountID, Counter__c, Active__c FROM Contact WHERE Id = :id Limit 1];
        return result;
    }

    /**
     * Check record exist in database by Id;
     * @param id String
     * @return Boolean
     */
    public static Boolean exist(String id) {
        Contact result = [SELECT Id FROM Contact WHERE Id = :id];
        return result != null;
    }

    /**
     * Batch update contact, Input is BatchRequest contain
     * @param batchRequest BatchRequest
     * @return Integer
     */
    public static Integer batchUpdateContact(BatchRequest batchRequest) {
        List<String> queryIds = batchRequest.getQuery();
        List<Contact> contacts = [SELECT Id FROM Contact where Id in :queryIds];
        
        for (Contact contact : contacts) {
            updateDescriptionAndEmail((Contact) batchRequest.getSetter(), contact);
        }
        
        update contacts;
        return contacts.size();
    }

    private static void updateDescriptionAndEmail(Contact source, Contact target) {
        target.Email = source.Email;
        target.Description = source.Description;
    }

    /**
     * Soft delete contact will set the field Active__c value false and update records. Its should decrease field TotalContacts of Account one unit.
     * 
     */
    public static void softDeleteContact(String contactId) {
        Contact contact = getContactById(contactId);
        contact.Active__c = false;
        update contact;
    }
}
