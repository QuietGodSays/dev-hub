public class Accounts extends fflib_SObjectDomain {
    public Accounts(List<Account> sObjectList) {
        super(sObjectList);
    }

    public class Constructor implements fflib_SObjectDomain.IConstructable {
        public fflib_SObjectDomain construct(List<SObject> sObjectList) {
            return new Accounts(sObjectList);
        }
    }

    public override void handleBeforeInsert() {
        onApplyDefaults();
    }

    public override void onApplyDefaults() {
        for (Account account : (List<Account>) Records) {
            if (account.Description == null) {
                account.Description = 'Domain classes rock!';
            }
        }
    }

    public override void onBeforeUpdate(Map<Id, SObject> existingRecords) {
        for (Account account : (List<Account>) Records) {
            account.AnnualRevenue = 'Domain classes rock!'.getLevenshteinDistance(account.Description);
        }
    }
}
