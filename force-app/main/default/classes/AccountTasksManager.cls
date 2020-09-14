public without sharing class AccountTasksManager {
    private static final Id TASKS_OWNER_ID = [SELECT Id FROM User WHERE Name = 'Sales Admin' LIMIT 1].Id;
    private static final Integer ACCOUNT_TASKS_MAX_NUMBER = 3;


    @InvocableMethod(
        label='Manages accounts tasts' 
        description='Reassigns tasks to Sales Admin if account have more than 3 tasks else creates new negotiation task for affected account'
    )
    public static void manageAccountsBatchTasks(List<ManageAccountTasksRequest> requests) {
        List<Task> accountTasks = new List<Task>();
        List<Task> tasksToInsert = new List<Task>();
        List<Task> tasksToUpdate = new List<Task>();

        for (ManageAccountTasksRequest request : requests) {
            if (request != null) {
                accountTasks = [SELECT OwnerId FROM Task WHERE Task.WhatId = :request.affectedAccountId];
            
                if (accountTasks.size() <= ACCOUNT_TASKS_MAX_NUMBER) {
                    String taskSubject = 'Negotiations with ' + request.affectedAccountName;
                    tasksToInsert.add(new Task(Subject=taskSubject, WhatId=request.affectedAccountId));
                } else {
                    for (Task task : accountTasks) {
                        task.OwnerId = TASKS_OWNER_ID;
                    }
                    tasksToUpdate.addAll(accountTasks);
                }
            }
        }
        insert tasksToInsert;
        update tasksToUpdate;
    }


    public without sharing class ManageAccountTasksRequest {
        @InvocableVariable(label='Id of the affected account' required=true)
        public Id affectedAccountId;

        @InvocableVariable(label='Name of the affected account' required=true)
        public String affectedAccountName;
    }  
}