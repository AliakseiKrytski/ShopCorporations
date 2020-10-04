({
    doInit : function(component, event, helper) {
        let recordId = component.get("v.recordId");
        if (recordId) {
            helper.getContactsByAccountId(component, recordId);
        } else {
            console.log("Account record ID is null");
        }
    }
})
