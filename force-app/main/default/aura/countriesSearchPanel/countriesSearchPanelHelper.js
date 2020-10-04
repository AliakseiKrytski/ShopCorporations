({
    searchCountries : function(component, searchBy, searchText) {
        let searchEvent = component.getEvent("startSearchCountries");
        searchEvent.setParams({ 
            "searchBy": searchBy,
            "searchText": searchText
        });
        searchEvent.fire();
    }
})
