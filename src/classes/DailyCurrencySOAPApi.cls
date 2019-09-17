public class DailyCurrencySOAPApi {
    
    public static Double getExchangeRate (String currency1) {
        List<Currency__mdt> key = [SELECT Key__c FROM Currency__mdt];
        XigniteComClass.XigniteGlobalCurrenciesSoap exchangeRate = new XigniteComClass.XigniteGlobalCurrenciesSoap();
        XigniteComClass.Header header = new XigniteComClass.Header();
        header.Username = key[0].Key__c;
        exchangeRate.Header = header;
        XigniteComClass.Rate exchange = exchangeRate.GetRealTimeRate(currency1);
        return exchange.Mid;
    }
    public static void updateAccountCurrency(List<Account> listAccountId){
        Double salaryValue = 0;
        List <Id> listId = new List <Id>();
        
        for (Account acc : listAccountId) {
            listId.add(acc.Id);
        }
        
        List<Account> listAccount = [SELECT Id,Currency__c,Salary__c,(SELECT Id,Currency__c,Salary__c FROM Contacts) FROM Account WHERE Id IN :listId];
        if(!listAccount.isEmpty()){
            for (Account acc : listAccount) {
                if(!acc.Contacts.isEmpty()){
                    for (Contact con : acc.Contacts){
                        if(con.Currency__c == acc.Currency__c && con.Currency__c != null){
                            salaryValue += con.Salary__c;
                        } 
                        else{
                            String currencyValue = con.Currency__c + acc.Currency__c;
                            if(currencyValue != null){
                                salaryValue += (con.Salary__c * getExchangeRate(currencyValue));   
                            }
                            else{
                                salaryValue = 0;
                            }
                        }
                    }
                }
                acc.Salary__c = salaryValue;
            }
            update listAccount;    
        }
        
    }

}