@RestResource(urlMapping = '/Records/Search/*')
global with sharing class RecordsSearchController {

    @HttpPost
    global static void searchRecords(String name) {
        //RestRequest request = RestContext.request;
        RestResponse response = RestContext.response;

        APIWrapper result = new APIWrapper();

        try {
            result.results = RecordService.searchRecord(name);
            result.code = 200;
            response.statusCode = 200;
        } catch(Exception error) {
            result.errorMessage = error.getMessage();
            result.code = 404;
            response.statusCode = 404;
        }
        response.responseBody = Blob.valueOf(JSON.serialize(result));
    }
}
