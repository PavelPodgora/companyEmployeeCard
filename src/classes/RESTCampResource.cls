@RestResource(urlMapping='/Account/*')
global with sharing class RESTCampResource {
	@HttpGet
    global static Account doGet(){
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String sId = '0012v00002OwAqrAAF';
        Account result = [SELECT Id, Name 
                                        FROM Account WHERE Id=:sId];
        
        return result;
    }
}