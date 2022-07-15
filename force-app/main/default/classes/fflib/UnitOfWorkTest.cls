@IsTest
private class UnitOfWorkTest {
    private static Integer ACCOUNTS_SIZE = 100;
    private static Integer CONTACTS_NOTES_SIZE = 500;

    @IsTest
    private static void challengeComplete() {
        fflib_SObjectUnitOfWork unitOfWork = new fflib_SObjectUnitOfWork(
            new List<Schema.SObjectType>{ Account.SObjectType, Contact.SObjectType, Note.SObjectType }
        );

        for (Integer i = 0; i < CONTACTS_NOTES_SIZE; i++) {
            if (i < ACCOUNTS_SIZE) {
                Account account = new Account(Name = 'Test ' + i);
                unitOfWork.registerNew(account);
            }

            Contact contact = new Contact(FirstName = 'Test ', LastName = i.format());
            unitOfWork.registerNew(contact);

            Note aNote = new Note(Title = 'Test ' + i);
            unitOfWork.registerNew(aNote, Note.ParentId, contact);
        }

        unitOfWork.commitWork();

        System.assertEquals(100, [SELECT Id FROM Account].size());
        System.assertEquals(500, [SELECT Id FROM Contact].size());
        System.assertEquals(500, [SELECT Id FROM Note].size());
    }
}
