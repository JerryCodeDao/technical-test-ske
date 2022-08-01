trigger ContactTrigger on Contact (after insert) {
    List<Account> bulkUpdateAccount = new List<Account>();
    for (Contact contact : Trigger.new) {
        String accountId = contact.AccountId;

        Account account = AccountService.getAccountById(accountId);
        if (account != null) {
            if (account.TotalContacts__c == null) {
                account.TotalContacts__c = 0;
            }
            account.TotalContacts__c++;
            bulkUpdateAccount.add(account);
        }
    }
    update bulkUpdateAccount;
}