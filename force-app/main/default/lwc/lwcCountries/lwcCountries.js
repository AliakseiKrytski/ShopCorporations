import { LightningElement, track } from 'lwc';
import searchCountries from '@salesforce/apex/CountriesController.searchCountries';

export default class LwcCountries extends LightningElement {
    @track countries;
    searchError;

    handleSearch(event) {
        let { searchBy, searchText } = event.detail;
        searchCountries({searchBy, searchText})
            .then((result) => {
                this.countries = result;
                this.searchError = undefined;
            })
            .catch((error) => {
                this.searchError = JSON.stringify(error);
                this.countries = undefined;
            });
    }
}