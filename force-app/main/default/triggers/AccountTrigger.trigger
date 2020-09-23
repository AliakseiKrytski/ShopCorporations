trigger AccountTrigger on Account (after delete, after insert, after undelete, after update, before delete, before insert, before update) {
    private AccountTriggerHandler handler = new AccountTriggerHandler(true);

    /* Before Insert */
    if(Trigger.isInsert && Trigger.isBefore){
        handler.onBeforeInsert(Trigger.new);
    }
    /* After Insert */
    else if(Trigger.isInsert && Trigger.isAfter){
        handler.onAfterInsert(Trigger.new);
    }
    /* Before Update */
    else if(Trigger.isUpdate && Trigger.isBefore){
        handler.onBeforeUpdate(Trigger.old, Trigger.new, Trigger.newMap);
    }
    /* After Update */
    else if(Trigger.isUpdate && Trigger.isAfter){
        if (RecursionChecker.runOnce()) {
            handler.onAfterUpdate(Trigger.old, Trigger.new, Trigger.newMap);    
        }
    }
    /* Before Delete */
    else if(Trigger.isDelete && Trigger.isBefore){
        handler.onBeforeDelete(Trigger.old, Trigger.oldMap);
    }
    /* After Delete */
    else if(Trigger.isDelete && Trigger.isAfter){
        handler.onAfterDelete(Trigger.old, Trigger.oldMap);
    }

    /* After Undelete */
    else if(Trigger.isUndelete){
        handler.onUndelete(Trigger.new);
    }

}