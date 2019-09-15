public class ConAndOppController {
    
    public Map<String,List<String>> getOpportunity() {
        Map<String,List<String>> results = new Map<String,List<String>>();
        List<Opportunity> OppName = [SELECT StageName,Name FROM Opportunity LIMIT 20];
        //for(Opportunity o: OppName){
        //    if(o.StageName == 'Closed Won'){
        //        results.put(o.StageName,new List<String>());
        //    }
        //    else if(o.StageName == 'Value Proposition'){
        //        results.put(o.StageName,new List<String>());
        //    }
        //}
        //for(Opportunity o: oppName){
        //    results.get(o.StageName).add(o.Name);
        //}
        return results;
    }
    
    public List<Contact> getContacts() {
        List<Contact> results = [SELECT Name,Phone,HiddenOnView__c FROM Contact LIMIT 20];
        return results;
    }
}