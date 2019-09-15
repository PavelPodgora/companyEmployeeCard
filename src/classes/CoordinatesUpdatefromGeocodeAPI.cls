public class CoordinatesUpdatefromGeocodeAPI {
	@future(callout=true)
    public static void methodcoordinateUpdate(List<Id> contacts){
        List<Contact> contactList = [SELECT Name,MailingCity,MailingStreet,MailingCountry,MailingState,MailingPostalCode from Contact where Id IN :contacts];
		List<String> addressList = new List<String>();
        List<GoogleApi__mdt> gooogleApi = [SELECT Api__c,Key__c FROM GoogleApi__mdt];
        for(Contact contactValue: contactList){
            
            String strok = '';
            if(contactValue.MailingCity != null && contactValue.MailingStreet != null){
                strok = contactValue.MailingCity + ',' + contactValue.MailingStreet;
                addressList.add(strok);
            }
            
            //addressList[i] = EncodingUtil.urlEncode(addressList[i], ‘UTF-8’);
            Http http = new Http();
			HttpRequest request = new HttpRequest();
			request.setEndpoint(gooogleApi[0].Api__c + contactValue.MailingCity + '%20' + contactValue.MailingStreet + gooogleApi[0].Key__c);
			request.setMethod('GET');
		
			HttpResponse response = http.send(request);
            System.debug('123'+response.getBody());
            Double lat, lng;
			System.debug('Next');
            if (response.getStatusCode() == 200) {
                JSONParser parser = JSON.createParser(response.getBody());
                while (parser.nextToken() != null) {
                    if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && (parser.getText() == 'location')){
                        parser.nextToken();
                        while (parser.nextToken() != JSONToken.END_OBJECT){
                            String txt = parser.getText();
                            parser.nextToken();
                            if (txt == 'lat')
                                lat = parser.getDoubleValue();
                            else if (txt == 'lng')
                                lng = parser.getDoubleValue();
                        }
                    }
                }
            }
            if (lat != null && lng != null){
                contactValue.Location__Latitude__s = lat;
                contactValue.Location__Longitude__s = lng;
                update contactValue;
            }
        }
    }
}