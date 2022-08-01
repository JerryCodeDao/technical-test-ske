@RestResource(urlMapping = '/Records/v1/query/*')
global with sharing class RecordsGraphQLController {
    public RecordsGraphQLController() {

    }

    @HttpPost
    global static void graphPostBody(String Id, String RecordType) {
        RestResponse response = RestContext.response;
        try {
            response.statusCode = 200;
            response.responseBody = Blob.valueOf(Json.serialize(RecordService.increaseCounter(Id, RecordType)));
        } catch (Exception error) {
            response.statusCode = 500;
            response.responseBody = Blob.valueOf(Json.serialize(error.getMessage()));
        }
    }

    /**
     * Request body will have type :
     * {
     *     "query" : ['id', 'id2'], -- List String Id will update
     *     "setter" : {} -- Object or Map<String, Object> with 
     * }
     *  
     */
    @HttpPatch
    global static Integer graphUpdate(BatchUpdateContactRequestdata requestData) {
        Integer resultCount = ContactService.batchUpdateContact(requestData);
        return resultCount;
    }
}
