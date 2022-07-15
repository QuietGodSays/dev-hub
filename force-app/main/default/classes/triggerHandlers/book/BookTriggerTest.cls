@isTest
private class BookTriggerTest {
    @TestSetup
    static void setup() {
        Publishing_House__c house = new Publishing_House__c(
            Name = 'PubHouse',
            Foundation_Date__c = Date.parse('8/10/2012'),
            Address__c = 'Belarus, Minsk, Rokosovskogo st. 23'
        );
        insert house;

        List<Book__c> books = new List<Book__c>{
            new Book__c(
                Name = 'Title1',
                Amount_Sold__c = 0,
                Price__c = 1,
                Rating__c = '1',
                Publishing_House__c = house.Id
            ),
            new Book__c(
                Name = 'Title2',
                Amount_Sold__c = 1,
                Price__c = 2,
                Rating__c = '2',
                Publishing_House__c = house.Id
            ),
            new Book__c(
                Name = 'Title3',
                Amount_Sold__c = 5,
                Price__c = 8,
                Rating__c = '3',
                Publishing_House__c = house.Id
            )
        };
        insert books;
    }

    @isTest
    static void testBeforeUpdateSingleAction() {
        Book__c book = [SELECT Name, Amount_Sold__c, Price__c, Revenue__c FROM Book__c WHERE Name = 'Title1'];
        book.Amount_Sold__c = 10;

        Test.startTest();
        update book;
        Test.stopTest();

        book = [SELECT Name, Amount_Sold__c, Price__c, Revenue__c FROM Book__c WHERE Name = 'Title1'];
        System.assertEquals(10, book.Revenue__c);
    }

    @isTest
    static void testBeforeUpdateBulkAction() {
        List<Book__c> books = [SELECT Name, Amount_Sold__c, Price__c, Revenue__c FROM Book__c];
        for (Book__c book : books) {
            book.Amount_Sold__c += 1;
            book.Price__c += 1;
        }

        Test.startTest();
        update books;
        Test.stopTest();

        books = [SELECT Name, Amount_Sold__c, Price__c, Revenue__c FROM Book__c];
        List<Decimal> revenues = new List<Decimal>{ 2, 5, 49 };
        for (Integer i = 0; i < books.size(); i++) {
            System.assertEquals(revenues.get(i), books.get(i).Revenue__c);
        }
    }

    @isTest
    static void testBeforeUpdateNothingChanges() {
        Book__c book = [SELECT Name, Amount_Sold__c, Price__c, Revenue__c FROM Book__c WHERE Name = 'Title3'];
        System.debug(book.Revenue__c);
        book.Amount_Sold__c = 2;

        Test.startTest();
        update book;
        Test.stopTest();

        book = [SELECT Name, Amount_Sold__c, Price__c, Revenue__c FROM Book__c WHERE Name = 'Title3'];
        System.assertEquals(40, book.Revenue__c);
    }
}
