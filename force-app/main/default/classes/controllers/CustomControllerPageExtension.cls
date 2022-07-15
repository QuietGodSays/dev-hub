public class CustomControllerPageExtension {
    public CustomControllerPageExtension(CustomControllerPageController controller) {
    }

    /*public CustomControllerPageExtension(ApexPages.StandardController controller) {

    }*/

    public String getMessage() {
        return 'This is message from extension';
    }
}
