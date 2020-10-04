({
    getContactsByAccountId : function(component, accountId) {
        let action = component.get("c.getContactsByAccountId");
        action.setParams({
            "accountId": accountId
        });
        action.setCallback(this, function(response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                console.log("Contacts for " + accountId + ": " + JSON.stringify(response.getReturnValue()));
                component.set("v.contacts", response.getReturnValue());
            } else {
                console.log("Load account related contacts request failed with state: " + state);
            }
        });
        $A.enqueueAction(action);
    }
})
