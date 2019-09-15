public class ContactTriggerHandler {
    
    public ContactTriggerHandler() {

    }
    
    public void onAfterInsert(List<Contact> triggerNewList){
        //Map<Id,Decimal> mapIdAccountCountStatus1 = new Map<Id,Decimal>();
        //Map<Id,Decimal> mapIdAccountCountStatus2 = new Map<Id,Decimal>();
        //Map<Id,id> mapIdConAcc = new map<Id,id>();
        Decimal count = 0;
        Set<Id> contactsId = new Set<Id>();
        
        for(Contact c: triggerNewList){
            contactsId.add(c.id);
        }
        
        system.debug('contactsId----' +contactsId);       
        List<Account> listAccountsStatus1 = [SELECT id,Count_Contact_with_Status1__c,(SELECT id,Status__c FROM Contacts  
                                                                                      WHERE Status__c = 1)FROM Account];
        List<Account> listAccountsStatus2 = [SELECT id,Count_Contact_with_Status2__c,(SELECT id,Status__c FROM Contacts 
                                                                                      WHERE Status__c = 2 AND id IN:contactsId) FROM Account];
        system.debug('listAccountsStatus1----' +listAccountsStatus1);
        system.debug('listAccountsStatus2----' +listAccountsStatus2);
        
        for(Account a: listAccountsStatus1){
            if(!a.Contacts.isEmpty()){
                count = a.Contacts.size();
             	a.Count_Contact_with_Status1__c += count; 
            }
            count = 0;
        }
        
        count = 0;
        
        for(Account a: listAccountsStatus2){
            if(!a.Contacts.isEmpty()){
                count = a.Contacts.size();
             	a.Count_Contact_with_Status2__c += count;   
            }
            count = 0;
        }
        
        update listAccountsStatus1;
        update listAccountsStatus2;
    }
}