public with sharing class OpportunityTriggerHandler {
    public OpportunityTriggerHandler() {
    }

    public void onBeforeInsert(List<Opportunity> newOpportunities) {
    }

    public void onAfterInsert(List<Opportunity> newOpportunities, Map<Id, Opportunity> newMapOpportunities) {
        OpportunityTriggerHandlerHelper.calculationAmountOnAccount(newOpportunities);
    }

    public void onBeforeUpdate(
        List<Opportunity> newOpportunities,
        Map<Id, Opportunity> newMapOpportunities,
        List<Opportunity> oldOpportunities,
        Map<Id, Opportunity> oldMapOpportunities
    ) {
    }

    public void onAfterUpdate(
        List<Opportunity> newOpportunities,
        Map<Id, Opportunity> newMapOpportunities,
        List<Opportunity> oldOpportunities,
        Map<Id, Opportunity> oldMapOpportunities
    ) {
        OpportunityTriggerHandlerHelper.calculationAmountOnAccount(newOpportunities);
    }

    public void onBeforeDelete(List<Opportunity> oldOpportunities, Map<Id, Opportunity> oldMapOpportunities) {
    }

    public void onAfterDelete(List<Opportunity> oldOpportunities, Map<Id, Opportunity> oldMapOpportunities) {
        OpportunityTriggerHandlerHelper.calculationAmountOnAccount(oldOpportunities);
    }

    public void onAfterUndelete(List<Opportunity> newOpportunities, Map<Id, Opportunity> newMapOpportunities) {
        OpportunityTriggerHandlerHelper.calculationAmountOnAccount(newOpportunities);
    }
}
