import { LightningElement, api } from 'lwc';

export default class LwcCountriesTable extends LightningElement {
    columns = [
        {label: 'Country name', fieldName: 'name', type: 'text'},
        {label: 'Capital city', fieldName: 'capital', type: 'text'},
        {label: 'Country population', fieldName: 'population', type: 'number'},
        {label: 'Currency codes', fieldName: 'currencyCodes', type: 'text'},
        {label: 'Subregion', fieldName: 'subregion', type: 'text'},
        {label: 'Flag', fieldName: 'flag', type: 'url'},
    ];
    offset = 0;
    maxCount = 2;
    _countries;
    countriesCount = 0;
    countriesSlice;
    paginatorElement;
    
    @api
    get countries() {
        return this._countries;
    }
    set countries(value) {
        if (value) {
            this._countries = value;
        } else {
            this._countries = [];
        }
        this.countriesCount = this._countries.length;
        this.refreshPaginator();
        this.updateCountriesSlice();
    }
    
    updatePageContent(event) {
        let { pageNumber, maxCount } = event.detail;
        this.offset = (pageNumber - 1) * maxCount;
        this.maxCount = maxCount;
        this.updateCountriesSlice();
    }

    updateCountriesSlice() {
        if (this._countries) {
            const start = this.offset;
            const end = Math.min(start + this.maxCount, this._countries.length);
            this.countriesSlice = this._countries.slice(start, end);
        }
    }

    renderedCallback() {
        this.paginatorElement = this.template.querySelector('c-paginator');
    }

    refreshPaginator() {
        if (this.paginatorElement) {
            this.paginatorElement.refreshPage();
        } else {
            console.log('c-paginator selector is not found');
        }
    }
}