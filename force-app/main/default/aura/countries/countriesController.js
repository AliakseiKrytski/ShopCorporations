({
    handleClickSearch : function(component, event, helper) {    
        let searchBy = event.getParam("searchBy");
        let searchText =  event.getParam("searchText");   
        helper.searchCountries(component, searchBy, searchText);
    }
})
