trigger TriggerLeadSource on Lead (after insert) {
    
    LeadSourceTriggerHandler handler = new LeadSourceTriggerHandler();
    
    if(Trigger.isInsert || Trigger.isUpdate){
        handler.onAfterInsert(Trigger.New);
    }
}