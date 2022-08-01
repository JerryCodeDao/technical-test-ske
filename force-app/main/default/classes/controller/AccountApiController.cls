
@RestResource(urlMapping = '/Account/v1/*')
global with sharing class AccountApiController {
    public AccountApiController() {

    }

    @HttpGet
    global static List<Account> getAccounts() {
        RestRequest request = RestContext.request;
        // grab the caseId from the end of the URL
        String name = request.requestURI.substring(request.requestURI.lastIndexOf('/') + 1);
        List<Account> result = AccountService.getAccounts(name);
        return result;
    }

    
}
