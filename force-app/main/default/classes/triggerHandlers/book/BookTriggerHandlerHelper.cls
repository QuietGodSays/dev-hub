public class BookTriggerHandlerHelper {
    public static void revenueInitCalculation(List<Book__c> newBooks) {
        for (Book__c book : newBooks) {
            book.Revenue__c = book.Amount_Sold__c * book.Price__c;
        }
    }

    public static void revenueRecalculationIfAmountSoldChanges(List<Book__c> newBooks, Map<Id, Book__c> oldBooks) {
        for (Book__c book : newBooks) {
            Book__c oldBook = oldBooks.get(book.Id);
            if (book.Amount_Sold__c > oldBook.Amount_Sold__c) {
                book.Revenue__c = oldBook.Revenue__c + (book.Amount_Sold__c - oldBook.Amount_Sold__c) * book.Price__c;
            }
        }
    }
}
