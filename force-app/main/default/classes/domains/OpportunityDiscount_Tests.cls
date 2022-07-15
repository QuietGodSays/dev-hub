@IsTest
private class OpportunityDiscount_Tests {

    @IsTest
    private static void test_positive_low_priority() {
        AccountWrapper mockAccountWrapper = (AccountWrapper) Test.createStub(AccountWrapper.class, new AccountWrapperMock());
        OpportunityDiscount opportunityDiscount = new OpportunityDiscount(mockAccountWrapper);
        Decimal result;

        Test.startTest();
        result = opportunityDiscount.getTotalDiscount();
        Test.stopTest();

        System.assertEquals(.1, result, 'Expected to get .1');
    }

    @IsTest
    private static void test_positive_high_priority() {
        AccountWrapperMock.isHighPriorityReturn = true;
        AccountWrapper mockAccountWrapper = (AccountWrapper) Test.createStub(AccountWrapper.class,
                new AccountWrapperMock());
        OpportunityDiscount opportunityDiscount = new OpportunityDiscount(mockAccountWrapper);
        Decimal result;

        Test.startTest();
        result = opportunityDiscount.getTotalDiscount();
        Test.stopTest();

        System.assertEquals(.25, result, 'Expected to get .25');
    }
}