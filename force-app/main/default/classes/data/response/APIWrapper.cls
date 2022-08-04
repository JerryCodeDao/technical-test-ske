/**
 * API Wrapper class give the standard render api with:
 * - results: the Object listing will return resutls of data from services layer.
 * - errorMessage: return the error message handle error of system likely try catch exception.
 * - code: Http status code or SalesForce code to definition message in UI.
 * 
 */
global with sharing class APIWrapper {
    global APIWrapper() {

    }

    @AuraEnabled
    public List<Object> results;
    @AuraEnabled
    public String errorMessage;
    @AuraEnabled
    public Integer code;

    global APIWrapper withResults(List<Object> results) {
        this.results = results;
        return this;
    }

    global APIWrapper withCode(Integer code) {
        this.code = code;
        return this;
    }


    global APIWrapper withErrorMessage(String errorMessage) {
        this.errorMessage = errorMessage;
        return this;
    }
}
