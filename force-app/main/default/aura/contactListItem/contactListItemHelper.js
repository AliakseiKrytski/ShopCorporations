({
    navigateToContact : function(component, contactId) {
        let navEvt = $A.get("e.force:navigateToSObject");
        navEvt.setParams({
            "recordId": contactId,
            "scope": "Contact"
        });
        navEvt.fire();
    }
})
