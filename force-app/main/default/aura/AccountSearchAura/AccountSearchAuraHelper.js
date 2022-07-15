({
    // code in the helper is reusable by both
    // the controller.js and helper.js files
    handleSearch: function(component, searchTerm) {
        let action = component.get("c.searchAccounts");
        action.setParams({
            searchTerm: searchTerm,
        });
        action.setCallback(this, response => {
            let event = $A.get("e.c:AccountsLoaded");
            event.setParams({
                "accounts": response.getReturnValue(),
            });
            event.fire();
        });
        $A.enqueueAction(action);
    },
})