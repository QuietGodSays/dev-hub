@IsTest
private class Calculator_Tests {

    @IsTest
    private static void additionTest() {
        Test.startTest();
        Integer result = Calculator.addition(1, 2);
        Test.stopTest();

        System.assertEquals(3, result);
    }

    @IsTest
    private static void subtractionTest() {
        Test.startTest();
        Integer result = Calculator.subtraction(3, 2);
        Test.stopTest();

        System.assertEquals(1, result);
    }

    @IsTest
    private static void multiplyPositiveTest() {
        Test.startTest();
        Integer result = Calculator.multiply(2, 3);
        Test.stopTest();

        System.assertEquals(6, result);
    }

    @IsTest
    private static void multiplyNegativeTest() {
        Boolean isException = false;

        Test.startTest();
        try {
            Calculator.multiply(0, 3);
        } catch (Calculator.CalculatorException ex) {
            if (ex.getMessage().equalsIgnoreCase('It doesn\'t make sense to multiply by zero')) {
                isException = true;
            }
        }
        Test.stopTest();

        System.assert(isException);
    }

    @IsTest
    private static void dividePositiveTest() {
        Test.startTest();
        Decimal result = Calculator.divide(6, 3);
        Test.stopTest();

        System.assertEquals(2, result);
    }

    @IsTest
    private static void divideNegativeZeroDenominatorTest() {
        Boolean isException = false;

        Test.startTest();
        try {
            Calculator.divide(6, 0);
        } catch (Calculator.CalculatorException ex) {
            if (ex.getMessage().equalsIgnoreCase('You still can\'t divide by zero')) {
                isException = true;
            }
        }
        Test.stopTest();

        System.assert(isException);
    }

    @IsTest
    private static void divideNegativeResultTest() {
        Boolean isException = false;

        Test.startTest();
        try {
            Calculator.divide(6, -3);
        } catch (Calculator.CalculatorException ex) {
            if (ex.getMessage().startsWithIgnoreCase('Division returned a negative value.')) {
                isException = true;
            }
        }
        Test.stopTest();

        System.assert(isException);
    }
}