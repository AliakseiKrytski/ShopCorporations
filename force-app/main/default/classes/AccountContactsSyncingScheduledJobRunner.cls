public class AccountContactsSyncingScheduledJobRunner {
    private static final String DEFAULT_CRON_EXPRESSION = '0 0 * * * ?';
    
    
    public static String runSyncing(String jobName, String cronExpression) {
        return system.schedule(jobName, cronExpression, new SchedulableAccountContactsSyncing());
    }
    
    public static String runSyncing(String jobName) {
        return runSyncing(jobName, DEFAULT_CRON_EXPRESSION);
    }

    
    public class SchedulableAccountContactsSyncing implements Schedulable {
        public void execute(SchedulableContext sc) {
            Database.executeBatch(new AccountContactsQueryLocatorProcessor());
            Database.executeBatch(new AccountContactsIterableProcessor());
            System.debug('Contacts syncing batches was launched');
        }
	}
}