public with sharing class CaseService {
    public static void closeCases(Set<Id> caseIds, String closeReason) {
        List<Case> cases = [SELECT Id, Status, Reason FROM Case WHERE Id IN :caseIds];

        for (Case aCase : cases) {
            aCase.Status = 'Closed';
            aCase.Reason = closeReason;
        }

        update cases;
    }
}
