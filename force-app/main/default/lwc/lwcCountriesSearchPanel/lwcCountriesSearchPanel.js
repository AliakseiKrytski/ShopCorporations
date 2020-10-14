import { LightningElement } from 'lwc';

export default class LwcCountriesSearchPanel extends LightningElement {
    searchByOptions = [
        { label: 'Capital City', value: 'capital' },
        { label: 'Name', value: 'name' },
        { label: 'Currency', value: 'currency' },
    ];
    
    searchBy = 'name';
    searchText = '';

    handleSearchByChange(event) {
        this.searchBy = event.target.value; 
    }

    handleSearchTextChange(event) {
        this.searchText = event.target.value; 
    }

    handleSearch() {
        let eventDetail = {
            searchBy: this.searchBy,
            searchText: this.searchText
        }
        this.dispatchEvent(new CustomEvent('search', { detail: eventDetail }));
    }
}