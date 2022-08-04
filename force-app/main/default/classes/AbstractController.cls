public with sharing class AbstractController {

    @AuraEnabled(cacheable = false)
    public static String searchRecords(String name){
        // final String calloutApis = 'https://ruby-enterprise-12442-dev-ed.lightning.force.com/services/apexrest/Records/Search';
        // Http http = new Http();
        // HttpRequest req = new HttpRequest();
        // req.setEndpoint(calloutApis);
        // req.setMethod('POST');
        // req.setBody(jsonBody);
        // HttpResponse resp = http.send(req);
        APIWrapper results = new APIWrapper().withResults(RecordService.searchRecord(name));
        String resp = JSON.serialize(results);
        return resp;
    }

    @AuraEnabled(cacheable = false)
    public static String increasementCounterRecord(String id, String type) {
        RecordModel record = RecordService.increaseCounter(id, type);
        return searchRecords(record.RecordName);
    }

}