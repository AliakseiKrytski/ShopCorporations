({
    searchCountries : function(component, searchBy, searchText) {
        let action = component.get("c.searchCountries");
        action.setParams({
            "searchBy": searchBy,
            "searchText": searchText
        });
        action.setCallback(this, function(response){
            let state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.countries", response.getReturnValue());
            } else {
                console.log("Search countries request " + JSON.stringify(action.getParams()) + " failed with state: " + state);
            }
        });
        $A.enqueueAction(action);
    }
})
