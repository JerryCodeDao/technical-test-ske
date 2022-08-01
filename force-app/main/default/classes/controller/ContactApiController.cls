@RestResource(urlMapping = '/Contact/v1/*')
global with sharing class ContactApiController extends AbstractController {
    global ContactApiController() {

    }

    @HttpGet
    global static void getContacts() {
        RestRequest request = RestContext.request;
        RestResponse response = RestContext.response;
        String name = request.requestURI.substring(request.requestURI.lastIndexOf('/') + 1);

        APIWrapper result = new APIWrapper();
        try {
            result
                .withResults(ContactService.searchContactByName(name))
                .withCode(200);

            response.statusCode = 200;
        }
        catch (Exception error) {
            response.statusCode = 500;
            result
                .withCode(500)
                .withErrorMessage(error.getMessage());
        }
        response.responseBody = Blob.valueOf(JSON.serialize(result));
    }

    @HttpPost
    global static void createContact(Contact contact) {
        RestResponse response = RestContext.response;
        APIWrapper result = new APIWrapper();

        try {
            List<Contact> results = new List<Contact>();
            results.add(ContactService.createContact(contact));

            result
                .withResults(results)
                .withCode(200);

            response.statusCode = 200;
        }
        catch (Exception error) {
            response.statusCode = 500;
            result
                .withCode(500)
                .withErrorMessage(error.getMessage());
        }
        response.responseBody = Blob.valueOf(JSON.serialize(result));
    }

    @HttpPatch
    global static void matchContactAccount(String accountId, String contactId) {

        RestResponse response = RestContext.response;
        APIWrapper result = new APIWrapper();

        try {
            List<Contact> results = new List<Contact>();
            results.add(ContactService.createContactWithAccount(contactId, accountId));

            result
                .withResults(results)
                .withCode(200);
            response.statusCode = 200;
        }
        catch (Exception error) {
            response.statusCode = 500;
            result
                .withCode(500)
                .withErrorMessage(error.getMessage());
        }
        response.responseBody = Blob.valueOf(JSON.serialize(result));
    }

    @HttpPut
    global static void deActiveContact(String contactId) {
        RestResponse response = RestContext.response;
        APIWrapper result = new APIWrapper();
        try {
            List<String> results = new List<String>();
            ContactService.softDeleteContact(contactId);
            results.add('Deleted successful with contact id: ' + contactId);
            result.withResults(results).withCode(201);
        } catch (Exception error) {
            result.withErrorMessage(error.getMessage()).withCode(201);
        }
        response.responseBody = Blob.valueOf(JSON.serialize(result));
    }
}
