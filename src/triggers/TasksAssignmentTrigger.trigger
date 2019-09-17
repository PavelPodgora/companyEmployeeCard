trigger TasksAssignmentTrigger on Task (before insert, before update) {
    TaskAssignmentClass.reassignRecords2NewUsers(Trigger.new);
}