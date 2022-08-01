@RestResource(urlMapping = '/Testing/*')
global with sharing class TestingApiController {
    public TestingApiController() {

    }

    @HttpGet
    global static Account testAccount() {
        RestRequest request = RestContext.request;
        // grab the caseId from the end of the URL
        String caseId = request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);
        Account result =  [SELECT Name, AccountNumber FROM Account WHERE AccountNumber = :caseId];
        return result;
    }
}