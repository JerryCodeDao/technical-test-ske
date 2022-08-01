global with sharing class BatchUpdateContactRequestdata extends BatchRequest {

    global List<String> query;
    global Contact setter;

    global BatchUpdateContactRequestdata() {}

    global override List<String> getQuery() {
        return this.query;
    }

    global override SObject getSetter() {
        return this.setter;
    }
}
