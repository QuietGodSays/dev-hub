@IsTest
public class TestFactory {

    public static Account getAccount(String name, Boolean doInsert) {
        Account account = new Account(Name = name);

        if (doInsert) {
            insert account;
        }

        return account;
    }

    public static Contact getContact(Id accountId, String firstName, String lastName, Boolean doInsert) {
        Contact contact = new Contact(FirstName = firstName, LastName = lastName, AccountId = accountId);

        if (doInsert) {
            insert contact;
        }

        return contact;
    }

    public static void generateAccountWithContacts(Integer numContacts) {
        Account account = getAccount('Default Account ltd', true);
        List<Contact> contacts = new List<Contact>();

        for (Integer i = 0; i < numContacts; i++) {
            String contactName = 'Contact';
            contacts.add(getContact(account.Id, contactName, String.valueOf(i), false));
        }

        insert contacts;
    }

    public static List<Opportunity> generateOpportunitiesForAccount(Id accountId, Decimal amount,
            Integer numOpportunities) {
        List<Opportunity> opportunities = new List<Opportunity>();

        for (Integer i = 0; i < numOpportunities; i++) {
            opportunities.add(new Opportunity(Name = 'Account ' + i, AccountId = accountId, Amount = amount,
                    CloseDate = Date.today().addDays(5), StageName = 'Prospecting'));
        }

        return opportunities;
    }

    public static User generateUser(String profileName) {
        UserRole userRole = new UserRole(DeveloperName = 'TestingTeam', Name = 'Testing Team');
        insert userRole;

        User user = new User(ProfileId = [SELECT Id FROM Profile WHERE Name = :profileName].Id, LastName = 'Last',
                Email = 'Cpt.Awesome@awesomesauce.com', Username = 'Cpt.Awesome@awesomesauce.com',
                CompanyName = 'Testing Co', Title = 'Captian', Alias = 'alias', TimeZoneSidKey = 'America/Los_Angeles',
                EmailEncodingKey = 'UTF-8', LanguageLocaleKey = 'en_US', UserRoleId = userRole.Id);
        insert user;

        return user;
    }
}