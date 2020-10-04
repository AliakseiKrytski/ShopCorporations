({
    clickSearchCountries : function(component, event, helper) {
        let searchBy = component.find("propSearchBy").get("v.value");
        let searchText = component.find("propSearchText").get("v.value");
        helper.searchCountries(component, searchBy, searchText);
    }
})
