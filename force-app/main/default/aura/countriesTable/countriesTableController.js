({
    doInit : function(component, event, helper) {
        const tableColumns = [
            {label: 'Country name', fieldName: 'name', type: 'text'},
            {label: 'Capital city', fieldName: 'capital', type: 'text'},
            {label: 'Country population', fieldName: 'population', type: 'number'},
            {label: 'Currency codes', fieldName: 'currencyCodes', type: 'text'},
            {label: 'Subregion', fieldName: 'subregion', type: 'text'},
            {label: 'Flag', fieldName: 'flag', type: 'url'},
        ];
        
        component.set("v.tableColumns", tableColumns);
        component.set("v.countries", []);
    }
})
