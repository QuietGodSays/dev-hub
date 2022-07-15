public class OpportunityTriggerHandlerHelper {
    public static void calculationAmountOnAccount(List<Opportunity> opportunities) {
        List<Id> accountsId = new List<Id>();
        /*for (Opportunity opp : opportunities) {
            if (opp.Amount != null && opp.AccountId != null
                    && !accountsId.contains(opp.AccountId)) {
                accountsId.add(opp.AccountId);
            }
        }*/

        for (Opportunity opp : opportunities) {
            if (
                opp.Amount != null &&
                opp.AccountId != null &&
                !accountsId.contains(opp.AccountId) &&
                opp.StageName.equals('Closed Won')
            ) {
                accountsId.add(opp.AccountId);
            }
        }

        List<Account> accounts = [
            SELECT
                Id,
                Total_Amount__c,
                Name,
                (SELECT Id, Amount, StageName FROM Opportunities WHERE StageName = 'Closed Won')
            FROM Account
            WHERE Id IN :accountsId
        ];

        List<Account> updatedAccounts = new List<Account>();
        for (Account acc : accounts) {
            Decimal totalAmount = 0.00;
            for (Opportunity opp : acc.Opportunities) {
                if (opp.StageName.equals('Closed Won')) {
                    totalAmount += opp.Amount;
                }
            }
            acc.Total_Amount__c = totalAmount;
            updatedAccounts.add(acc);
        }

        if (updatedAccounts.size() > 0) {
            update updatedAccounts;
        }
    }
}
