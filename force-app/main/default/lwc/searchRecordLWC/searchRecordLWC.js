import { LightningElement, track, wire  } from 'lwc';
import searchRecords from "@salesforce/apex/AbstractController.searchRecords";
import increasementCounterRecord from "@salesforce/apex/AbstractController.increasementCounterRecord";


export default class SearchRecordLWC extends LightningElement {

    @track search_name = "";
    @track records = [];

    changeHandler(event) {
        this[event.target.name] = event.target.value;
    }

    // @wire(searchRecords)
    getRecords() {
        // if (data) {
        //     this.records = JSON.parse(response)["results"];
        // }
        
        searchRecords({ name : this.search_name}).then(response => {
            this.records = JSON.parse(response)["results"];
        }).catch(error => {
            console.error(error);
        });
    }

    handleIncreasementCounter(event) {
        const Id = event.target.value;
        const Type = event.target.name;

        increasementCounterRecord({ id : Id, type : Type}).then(response => {
            this.records = JSON.parse(response)["results"];
        }).catch(error => {
            console.error(error);
        });
    }

}