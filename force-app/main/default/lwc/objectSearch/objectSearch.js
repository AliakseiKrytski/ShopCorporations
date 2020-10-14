import { LightningElement } from 'lwc';
import getSObjectList from '@salesforce/apex/SObjectSearchController.getSObjectList';

const DELAY = 350;

export default class ObjectSearch extends LightningElement {
    objectNameOptions = [
        { label: 'Contact', value: 'Contact' },
        { label: 'Account', value: 'Account' },
        { label: 'Lead', value: 'Lead' },
        { label: 'Opportunity', value: 'Opportunity' },
    ];
    columns = [
        {label: 'Id', fieldName: 'Id', type: 'text'},
        {label: 'Name', fieldName: 'Name', type: 'text'},
    ]

    objects;
    error;
    searchText = '';
    objectName = this.objectNameOptions[0].value;

    handleObjectNameChange(event) {
        this.objectName = event.target.value;
        this.refreshObjects();
    }

    handleSearchTextChange(event) {
        this.searchText = event.target.value;
        if (this.searchText) {
            this.refreshObjects();
        }
    }

    refreshObjects() {
        window.clearTimeout(this.delayTimeout);
        this.delayTimeout = setTimeout(() => {
            getSObjectList({sObjectName: this.objectName, searchKey: this.searchText})
            .then((result) => {
                this.objects = result;
                this.error = undefined;
            })
            .catch((error) => {
                this.error = JSON.stringify(error);
                this.objects = undefined;
            });
        }, DELAY);
    }
}