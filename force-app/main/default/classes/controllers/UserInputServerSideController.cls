public class UserInputServerSideController {
    @AuraEnabled
    public static List<Account> getAccounts(Integer numberOfAccounts) {
        List<Account> accounts = [SELECT Id, Name, Phone, Industry FROM Account LIMIT :numberOfAccounts];

        return accounts;
    }
}
