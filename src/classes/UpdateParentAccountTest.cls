@isTest
public class UpdateParentAccountTest {
    @testSetup 
    static void setup() {
        List<Account> accounts = new List<Account>();
        accounts.add(new Account(name='Parent'));
        for (Integer i = 0; i < 5; i++) {
            accounts.add(new Account(
                name='Test Account'+i
            ));
        }
        insert accounts;
    }
    
    static testmethod void testQueueable() {
        Id parentId = [select id from account where name = 'Parent'][0].Id;
        List<Account> accounts = [select id, name from account where name like 'Test Account%'];
        UpdateParentAccount updater = new UpdateParentAccount(accounts, parentId);
        Test.startTest();        
        System.enqueueJob(updater);
        Test.stopTest();        
        System.assertEquals(5, [select count() from account where parentId = :parentId]);
    }
    
}