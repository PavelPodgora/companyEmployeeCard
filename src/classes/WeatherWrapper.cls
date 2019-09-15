public class WeatherWrapper {
    public String dateP {get;set;}
    public String timeP {get;set;}
	public Double temp {get;set;}
	public Double pressure {get;set;}
	public Integer humidity {get;set;}
	public Double temp_min {get;set;}
	public Double temp_max {get;set;}
    public List<WeatherWrapper> weatherWrapperList{get;set;}
    public WeatherWrapper(String dateP, Double temp,Double temp_min,
                          Double temp_max,Double pressure,Integer humidity){
        this.dateP = dateP;
        this.temp = temp;
        this.temp_min = temp_min;
        this.temp_max = temp_max;
        this.pressure = pressure;
        this.humidity = humidity;                      
    }
}