public class CustomControllerPageController {
    public Account account { get; private set; }

    public CustomControllerPageController() {
        account = new Account();
    }

    public PageReference save() {
        try {
            insert account;
        } catch (System.DmlException e) {
            ApexPages.addMessages(e);
            return null;
        }
        //  After successful Save, navigate to the default view page
        PageReference redirectSuccess = new ApexPages.StandardController(account).view();
        return (redirectSuccess);
    }
}
