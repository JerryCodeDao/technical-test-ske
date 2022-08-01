/**
 * BatchUpdateContactsTrigger
 * 
 * before List<Contact> is updated, check the id of Contact(SObject) does exist in database or else ? if not add the Error to contact.
 * 
 */
trigger BatchUpdateContactsTrigger on Contact (before update) {

    List<Contact> contacts = Trigger.new;

    if (Trigger.isUpdate) {
        for (Contact contact : contacts) {
            String contactId = contact.Id;
            if (!ContactService.exist(contactId)) {
                contact.addError('The ID: ' + contactId + ' does not exist in Database.');
            }
        }
    }
}