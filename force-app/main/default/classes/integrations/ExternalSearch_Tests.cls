@IsTest
private class ExternalSearch_Tests {

    @IsTest
    private static void test_method_one() {
        HTTPMockFactory mock = new HTTPMockFactory(200, 'OK', 'I found it!', new Map<String, String>());
        Test.setMock(HttpCalloutMock.class, mock);
        String result;

        Test.startTest();
        result = ExternalSearch.googleIt('epic search');
        Test.stopTest();

        System.assertEquals('I found it!', result);
    }

    @IsTest
    private static void googleItNegativeTest() {
        HTTPMockFactory mock = new HTTPMockFactory(500, 'Internal Server Error',
                'Internal Server Error', new Map<String, String>());
        Test.setMock(HttpCalloutMock.class, mock);
        Boolean result = false;

        Test.startTest();
        try {
            ExternalSearch.googleIt('Test query');
        } catch (ExternalSearch.ExternalSearchException ex) {
            if (ex.getMessage().equalsIgnoreCase('Did not recieve a 200 status code: 500')) {
                result = true;
            }
        }
        Test.stopTest();

        System.assert(result, 'Expected to get an error!');
    }
}