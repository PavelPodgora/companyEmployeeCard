public class TaskAssignmentClass implements AssignmentClass {


    public static List<Task> reassignRecords2NewUsers(List<Task> newTasks){

        List<Id> tasks = new List<Id>();
        List<Id> tasksId = new List<Id>();
        List<String> san = new List<String>();
        List<Id> ownerId = new List<Id>();
        Map<Id, String> mapSAN = new Map<Id, String>();
        Map<String,Id> mapSANOwnerId = new Map<String,Id>();
        List<Task> maintasks = new List<Task>();
        String kindOfSobject = 'Account';

        // for(Task t: newTasks){
        //     tasksId.add(t.Id);
        // }
    
        // List<Task> maintasks = [SELECT Id, WhatId,OwnerId FROM Task WHERE Id IN :tasksId AND WhatId != NULL];

        if (!Trigger.isExecuting){
            for(Task t: newTasks){
                tasksId.add(t.Id);
            }
            maintasks = [SELECT Id, WhatId,OwnerId FROM Task WHERE Id IN :tasksId AND WhatId != NULL];
        } else {
				maintasks.addAll(newTasks);                
        }

        for(Task t: maintasks){
            if(SchemaGlobalDescribe.findObjectNameFromRecordIdPrefix(t.WhatId) == kindOfSobject){
				tasks.add(t.whatId);
            }
            else{
                return newTasks;
            }
        }

        List<Account> accountSAN = [SELECT Id, Sales_Associate_Number__c FROM Account WHERE Id IN :tasks AND Sales_Associate_Number__c != NULL];
        
        for(Account a: accountSAN){
            san.add(a.Sales_Associate_Number__c);
        }

        List<User> userSAN = [SELECT Id,Sales_Associate_Number__c FROM User WHERE Sales_Associate_Number__c IN :san AND Sales_Associate_Number__c != null];

        for(Account a: accountSAN){
            mapSAN.put(a.Id, a.Sales_Associate_Number__c);  
        }

        for (User usId: userSAN) {
            mapSANOwnerId.put(UsId.Sales_Associate_Number__c, UsId.Id);
        }


        for(Task t: maintasks){
            String commonSAN = mapSAN.get(t.whatId);
            Id usId = mapSANOwnerId.get(commonSAN);
            t.ownerId = usId;
        }


        if (!Trigger.isExecuting) {
            update maintasks;
        }
         
        return maintasks;
     }

}