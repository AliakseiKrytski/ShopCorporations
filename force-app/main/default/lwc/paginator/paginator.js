import { LightningElement, api, track } from 'lwc';

export default class Paginator extends LightningElement {
    pageElementCountValues = [
        { label: '2', value: 2 },
        { label: '4', value: 4 },
        { label: '6', value: 6 },
        { label: '10', value: 10 },
    ];
    
    @api total_count;
    
    currentPageNumber = 1;
    currentPageElementCount = this.pageElementCountValues[0].value;
    totalPageCount;
    disablePrevious = true;
    disableNext = false;

    handlePrevious() {
        if (1 < this.currentPageNumber) {
            this.currentPageNumber--;
            this.updatePageParams();
        }
    }

    handleNext() {
        if (this.currentPageNumber < this.totalPageCount) {
            this.currentPageNumber++;
            this.updatePageParams();
        }
    }

    handleFirst() {
        if (1 < this.currentPageNumber) {
            this.currentPageNumber = 1;
            this.updatePageParams();
        }
    }

    handleLast() {
        if (this.currentPageNumber < this.totalPageCount) {
            this.currentPageNumber = this.totalPageCount;
            this.updatePageParams();
        }
    }

    handlePageSizeChange(event) {
        this.currentPageElementCount = parseInt(event.target.value, 10);
        this.refreshPage();
        this.updatePageParams();
    }

    updateButtonsDisability() {
        this.disablePrevious = this.currentPageNumber <= 1;
        this.disableNext = this.currentPageNumber >= this.totalPageCount;
    }

    updatePageParams() {
        this.updateButtonsDisability();
        let pageParams = {
            pageNumber: this.currentPageNumber,
            maxCount: this.currentPageElementCount
        }
        this.dispatchEvent(new CustomEvent('updatepage', { detail: pageParams }));
    }

    @api
    refreshPage() {
        this.currentPageNumber = 1;
        this.totalPageCount = Math.ceil(this.total_count / this.currentPageElementCount);
        this.updateButtonsDisability();
    }

    connectedCallback() {
        this.refreshPage();
    }
}
