@IsTest
private class ProcessServicesTest {
    @isTest static void testGetIdByDate() {
        RestRequest request = new RestRequest();
        request.requestUri ='https://ap15.lightning.force.com/services/apexrest/task20/2019-7-16';
        request.httpMethod = 'GET';
        Date createdDate = Date.valueOf('2019-7-16');
        List<Account> listAccount = [SELECT id FROM Account WHERE DAY_ONLY(CreatedDate) = : createdDate];
        List<Contact> listContact = [SELECT id FROM Contact WHERE DAY_ONLY(CreatedDate) = : createdDate];
        List<Id> idAccountList = new List<Id>();
        List<Id>  idContactList = new List<Id> ();

        for(Account acc: listAccount){
            idAccountList.add(acc.Id);
        }

        for (Contact con : listContact) {
            idContactList.add(con.Id);
        }
        RestContext.request = request;

        System.assert(ProcessHTTP.doGet() != null);
        System.assertEquals(ProcessHTTP.doGet().contactId, idContactList);
        System.assertEquals(ProcessHTTP.doGet().accountId, idAccountList);
    }

    @isTest static void testPostNewAccountContact() {
        RestRequest request = new RestRequest();
        request.requestUri ='https://ap15.lightning.force.com/services/apexrest/task20/';
        request.httpMethod = 'POST';
        request.addHeader('Content-Type', 'application/json');
        request.requestBody = Blob.valueOf('{"account":[{"name": "Test111"}],"contact": [{"lastname": "Test222"}]}');
        RestContext.request = request;

        ProcessHTTP.RequestWrapper thisListOfIds = ProcessHTTP.doPost();

        Account thisAccount = [SELECT Name FROM Account WHERE Id IN :thisListOfIds.accountId];
        Contact thisContact = [SELECT LastName FROM Contact WHERE Id IN :thisListOfIds.contactId];
        System.assert(thisAccount != null);
        System.assertEquals(thisAccount.Name, 'Test111');
        System.assertEquals(thisContact.LastName, 'Test222');
    }
}