global with sharing class AccountService {
    public AccountService() {

    }

    /**
     * API service: filter list account SObject by name, if name == null return all records else filter
     * 
     * @param name String
     * @return List<Account>
     */
    public static List<Account> getAccounts(String name) {
        List<Account> accounts = new List<Account>();
        // name == null => Find ALl else find by name
        if (name == null || name == '') {
            accounts = [SELECT Id, Name, AccountNumber, Counter__c, TotalContacts__c FROM Account];
        } else {
            accounts = searchAccountByName(name);
        }
        return accounts;
    }

    /**
     * API service: get account by id
     * 
     * @param id String
     * @return Account
     */
    public static Account getAccountById(String id) {
        Account result = [SELECT Id, Name, AccountNumber, Counter__c, TotalContacts__c FROM Account WHERE Id = :id Limit 1];
        return result;
    }

    /**
     * API service: filter(search) account by name
     * 
     * @param name String
     * @return List<Account>
     */
    public static List<Account> searchAccountByName(String name) {
        String likeName = '%' + name + '%';
        List<Account> results = [SELECT Id, Name, AccountNumber, Counter__c, TotalContacts__c FROM Account WHERE Name like :likeName];
        return results;
    }

    /**
     * API service: create account.
     * 
     * @param account Account
     * @return 
     */
    public static void createAccount(Account account) {
        insert account;
    }

}
