public without sharing class AccountTasksManager {
    private static final Id TASKS_OWNER_ID = [SELECT Id FROM User WHERE Name = 'Sales Admin' LIMIT 1].Id;
    private static final Integer ACCOUNT_TASKS_MAX_NUMBER = 3;


    @InvocableMethod(
        label='Manages accounts tasts' 
        description='Reassigns tasks to Sales Admin if account have more than 3 tasks else creates new negotiation task for affected account'
    )
    public static void manageAccountsBatchTasks(List<ManageAccountTasksRequest> requests) {
        for (ManageAccountTasksRequest request : requests) {
            manageAccountTasks(request);
        }
    }

    public static void manageAccountTasks(ManageAccountTasksRequest request) {
        List<Task> accountTasks = [SELECT OwnerId FROM Task WHERE Task.WhatId = :request.affectedAccountId];
        if (accountTasks.size() <= ACCOUNT_TASKS_MAX_NUMBER) {
            assignNewNegotiationTaskToAccount(request);
        } else {
            assignOwnerToTasks(accountTasks);
        } 
    }

    private static void assignNewNegotiationTaskToAccount(ManageAccountTasksRequest request) {
        String taskSubject = 'Negotiations with ' + request.affectedAccountName;
        Task negotiationsTask = new Task(Subject=taskSubject, WhatId=request.affectedAccountId);
        insert negotiationsTask;
    }

    private static void assignOwnerToTasks(List<Task> tasks) {
        for (Task task : tasks) {
            task.OwnerId = TASKS_OWNER_ID;
        }
        update tasks;
    }


    public without sharing class ManageAccountTasksRequest {
        @InvocableVariable(label='Id of the affected account' required=true)
        public Id affectedAccountId;

        @InvocableVariable(label='Name of the affected account' required=true)
        public String affectedAccountName;
    }  
}