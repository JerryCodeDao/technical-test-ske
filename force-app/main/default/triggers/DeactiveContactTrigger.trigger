trigger DeactiveContactTrigger on Contact (after update) {
    List<Account> bulkUpdateAccount = new List<Account>();
    for (Contact contact : Trigger.new) {
        if (contact.Active__c == false && contact.AccountId != null) {
            String accountId = contact.AccountId;
            Account account = AccountService.getAccountById(accountid);
            if (account != null) {
                if (account.TotalContacts__c == null) {
                    account.TotalContacts__c = 0;
                }
                account.TotalContacts__c--;
                if (account.TotalContacts__c < 0) {
                    account.TotalContacts__c = 0;
                }
                bulkUpdateAccount.add(account);
            }
        }
    }

    update bulkUpdateAccount;
}