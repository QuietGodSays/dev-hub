public class AccountsSelector extends fflib_SObjectSelector {
    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField>{ Account.Name, Account.Description, Account.AnnualRevenue };
    }

    public Schema.SObjectType getSObjectType() {
        return Account.SObjectType;
    }

    public List<Account> selectById(Set<Id> accountIds) {
        return (List<Account>) selectSObjectsById(accountIds);
    }
}
