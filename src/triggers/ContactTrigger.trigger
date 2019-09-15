trigger ContactTrigger on Contact (before insert) {
    
    ContactTriggerHandler handler = new ContactTriggerHandler();
    
    if(Trigger.isInsert){
        handler.onAfterInsert(Trigger.New);
    }

}