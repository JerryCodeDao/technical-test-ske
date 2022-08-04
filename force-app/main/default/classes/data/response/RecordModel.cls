global with sharing class RecordModel {

    @AuraEnabled
    global String RecordName;
    @AuraEnabled
    global String RecordType;
    @AuraEnabled
    global String Id;
    @AuraEnabled
    global Double Counter;
    @AuraEnabled
    global String ReferenceLink;

    public RecordModel() {

    }
}
