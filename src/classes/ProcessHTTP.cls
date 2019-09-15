//jsonFormat = "account":[{"name": "Test1","City":"Minsk"},{"name":"Test2"}],"contact":[{"lastname":"testing1"},{"lastname":"testing2"}];
@RestResource(urlMapping='/task20/*')
global with sharing class ProcessHTTP {

    global class RequestWrapper{
        public List<Id> accountId;
        public List<Id> contactId;
    }

    @HttpPost
    global static RequestWrapper doPost() {
        List<Account> listAccount = new List<Account>();
        List<Contact> listContact = new List<Contact>();
        List<Id> idAccountList = new List<Id>();
        List<Id>  idContactList = new List<Id> ();
        RequestWrapper reqWrap = new RequestWrapper();
        RestRequest request = RestContext.request;
        Map<String, Object> params = (Map<String, Object>)JSON.deserializeUntyped(request.requestbody.tostring());

        if(!params.isEmpty()){
            List<Object> accountItems = (List<Object>)params.get('account');
            List<Object> contactItems = (List<Object>)params.get('contact');

            for(Object itemAccount: accountItems){
                Map<String,Object> mapNewAccount = (Map<String,Object>)itemAccount;
                Account acc = new Account();
                for(String fieldName: mapNewAccount.keySet()){
                    acc.put(fieldName, mapNewAccount.get(fieldName));
                }
                listAccount.add(acc);
            }

            for(Object itemContact: contactItems){
                Map<String,Object> mapNewContact = (Map<String,Object>)itemContact;
                Contact con = new Contact();
                for(String fieldName: mapNewContact.keySet()){
                    con.put(fieldName, mapNewContact.get(fieldName));
                }
                listContact.add(con);
            }

            insert listAccount;
            insert listContact;
            
            for(Account acc: listAccount){
                idAccountList.add(acc.Id);
            }

            for (Contact con : listContact) {
                idContactList.add(con.Id);
            }

            reqWrap.accountId = idAccountList;
            reqWrap.contactId = idContactList;

        }
        return reqWrap;
    }
 //"7/16/2019"
    @HttpGet
    global static RequestWrapper doGet() {
        RequestWrapper reqWrap = new RequestWrapper();
        RestRequest request = RestContext.request;
        List<Account> listAccount = new List<Account>();
        List<Contact> listContact = new List<Contact>();
        List<Id> idAccountList = new List<Id>();
        List<Id>  idContactList = new List<Id> ();
        List<Date> listDate = new List<Date>();

        String dateFromRequest = request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);
        Date dateFormat = Date.valueOf(dateFromRequest);

        listAccount = [SELECT id FROM Account WHERE DAY_ONLY(CreatedDate) = : dateFormat];
        listContact = [SELECT id FROM Contact WHERE DAY_ONLY(CreatedDate) = : dateFormat];

        for(Account acc: listAccount){
            idAccountList.add(acc.Id);
        }

        for (Contact con : listContact) {
            idContactList.add(con.Id);
        }
        
        reqWrap.accountId = idAccountList;
        reqWrap.contactId = idContactList;
        return reqWrap;
    } 

}