public class AccountUpdateQueueable implements Queueable {
    private List<Account> accounts;

    public AccountUpdateQueueable(List<Account> accounts) {
        this.accounts = accounts;
    }

    public void execute(QueueableContext context) {
        for (Account account : this.accounts) {
            account.AnnualRevenue = 1000;
        }

        update this.accounts;
    }
}
