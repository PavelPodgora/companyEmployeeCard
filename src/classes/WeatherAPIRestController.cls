public class WeatherAPIRestController {  
    
    public List<WeatherJsonParser.List_Z> listOfData {get; set;}
    public String city {get;set;}
    public List<WeatherWrapper> weatherWrapperList{get;set;}
    public String selectedCity{get; set;}
    
    public WeatherAPIRestController(){}
    
    public List<Selectoption> getSelectedFieldCity(){
        List<Selectoption> citySetList = new List<Selectoption>();
        citySetList.add(new selectOption('','Choose City'));
        citySetList.add(new selectOption('Minsk','Minsk'));
        citySetList.add(new selectOption('Brest','Brest'));
        citySetList.add(new selectOption('Grodno','Grodno'));
        citySetList.add(new selectOption('Vitebsk','Vitebsk'));
        return citySetList;
    }
    
        public void getWeatherJson(){
        List<WeatherAPI__mdt> weatherApi = [SELECT Api__c,Key__c FROM WeatherAPI__mdt];
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(weatherApi[0].Api__c + selectedCity + weatherApi[0].Key__c);
        request.setMethod('GET');
        HTTPResponse response = http.send(request);
            
        if (response.getStatusCode() == 200) {
            WeatherJsonParser weatherJsonParser = WeatherJsonParser.parse(response.getBody());
            city = weatherJsonParser.City.name;
            listOfData = weatherJsonParser.list_Z;
            weatherWrapperList = new List<WeatherWrapper>();
            system.debug('listofData' + listOFData);
            for(Integer i = 0; i < listOfData.size();i = i + 4){
                WeatherJsonParser.List_Z data1 = listOfData.get(i);
                Datetime tmDate = Date.valueOf(data1.dt_txt);
                WeatherJsonParser.Main main1 = data1.main;
                String dateP = tmDate.format('dd.MM.YYYY');
                Double temp = (Integer)(main1.temp - 273.15);
                Double temp_min = (Integer)(main1.temp_min - 273.15);
                Double temp_max = (Integer)(main1.temp_max - 273.15);
                Double pressure = main1.pressure;
                Integer humidity = main1.humidity;
                weatherWrapperList.add(new WeatherWrapper(dateP,temp,temp_min,temp_max,pressure,humidity));
            }
            system.debug('weatherWrapperList[0]'+weatherWrapperList);
        }
    }
}