global with sharing class RecordService {
    public RecordService() {

    }

    /**
     * API service: search record by @name. Record include of Account and Contact sObjects
     * So filter(search) account by @name and contact by @name
     * 
     * @param name String
     * @return List<RecordModel>
     */
    global static List<RecordModel> searchRecord(String name) {
        List<RecordModel> records = new List<RecordModel>();

        List<Account> accounts = AccountService.searchAccountByName(name);
        List<Contact> contacts = ContactService.searchContactByName(name);
        for (Account account : accounts) {
            RecordModel record = new RecordModel();
            initByAccount(record, account);
            records.add(record);
        }

        for (Contact contact : contacts) {
            RecordModel record = new RecordModel();
            initByContact(record, contact);
            records.add(record);
        }

        return records;
    }

    /**
     * API service: increase counter. From the table of List<RecordModel>, when UI increase counter,
     * it need send @Id and @Type(Contact or Account) via request body to active this function.
     * Return the RecordModel with increasement the Counter field.
     * 
     * @param Id String, @param Type String
     * @return RecordModel
     */
    global static RecordModel increaseCounter(String Id, String Type) {
        RecordModel recordModel = new RecordModel();
        if (Type == 'Contact') {
            Contact contact = ContactService.getContactById(Id);
            if (contact.Counter__c == null) {
                contact.Counter__c = 0;
            }
            contact.Counter__c++;
            initByContact(recordModel, contact);

            update contact;
        }
        if (Type == 'Account') {
            Account account = AccountService.getAccountById(Id);
            if (account.Counter__c == null) {
                account.Counter__c = 0;
            }
            account.Counter__c++;
            initByAccount(recordModel, account);
            
            update account;
        }
        return recordModel;
    }

    private static void initByAccount(RecordModel record, Account account) {
        record.RecordName = account.Name;
        record.RecordType = 'Account';
        record.Counter = account.Counter__c;
        record.Id = account.Id;
    }

    private static void initByContact(RecordModel record, Contact contact) {
        record.RecordName = contact.Name;
        record.RecordType = 'Contact';
        record.Counter = contact.Counter__c;
        record.Id = contact.Id;
    }
}
