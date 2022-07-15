public class ContactsListController {
    private String sortOrder = 'LastName';

    public List<Contact> getContacts() {
        List<Contact> contacts = Database.query(
            'SELECT Id, FirstName, LastName, Title, Email' +
            ' FROM Contact' +
            ' ORDER BY ' +
            sortOrder +
            ' ASC' +
            ' LIMIT 10'
        );
        return contacts;
    }

    public void sortByLastName() {
        this.sortOrder = 'LastName';
    }

    public void sortByFirstName() {
        this.sortOrder = 'FirstName';
    }
}
