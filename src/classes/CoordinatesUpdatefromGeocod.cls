@isTest(seeAllData=false)
	public class CoordinatesUpdatefromGeocod {
@isTest 
	static void testContactCoordsCallout() {
        List<Id> cL = new List<Id>();
        Contact cont = new Contact(
        LastName = 'Test',
        MailingCity = 'Mountain View',
        MailingStreet = '1600 Amphitheatre Parkway'
        );
        
        insert cont;
        cL.add(cont.Id);
        ContactCoordinatesMock mock = new ContactCoordinatesMock();
        Test.setMock(HttpCalloutMock.class, mock);
        Test.startTest();
        CoordinatesUpdatefromGeocodeAPI.methodcoordinateUpdate(cL);
        //System.debug('methodcoordinateUpdate--------'+CoordinatesUpdatefromGeocodeAPI.methodcoordinateUpdate(cL));
        Test.stopTest();
        Contact cont2 = [SELECT Location__longitude__s, Location__latitude__s FROM Contact WHERE Id IN : cL];
        
        System.assertnotEquals(-122.0842499, cont2.Location__longitude__s);
        System.assertnotEquals(37.4224764, cont2.Location__latitude__s); 
    
    }
}