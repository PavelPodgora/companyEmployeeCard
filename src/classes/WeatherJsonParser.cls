public class WeatherJsonParser {

	public class Wind {
		public Double speed {get;set;} 
		public Double deg {get;set;} 

		public Wind(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'speed') {
							speed = parser.getDoubleValue();
						} else if (text == 'deg') {
							deg = parser.getDoubleValue();
						} else {
							System.debug(LoggingLevel.WARN, 'Wind consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public String cod {get;set;} 
	public Double message {get;set;} 
	public Integer cnt {get;set;} 
	public List<List_Z> list_Z {get;set;} // in json: list
	public City city {get;set;} 

	public WeatherJsonParser(JSONParser parser) {
		while (parser.nextToken() != System.JSONToken.END_OBJECT) {
			if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
				String text = parser.getText();
				if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
					if (text == 'cod') {
						cod = parser.getText();
					} else if (text == 'message') {
						message = parser.getDoubleValue();
					} else if (text == 'cnt') {
						cnt = parser.getIntegerValue();
					} else if (text == 'list') {
						list_Z = arrayOfList_Z(parser);
					} else if (text == 'city') {
						city = new City(parser);
					} else {
						System.debug(LoggingLevel.WARN, 'WeatherJsonParser consuming unrecognized property: '+text);
						consumeObject(parser);
					}
				}
			}
		}
	}
	
	public class Clouds {
		public Integer all {get;set;} 

		public Clouds(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'all') {
							all = parser.getIntegerValue();
						} else {
							System.debug(LoggingLevel.WARN, 'Clouds consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class City {
		public Integer id {get;set;} 
		public String name {get;set;} 
		public Coord coord {get;set;} 
		public String country {get;set;} 
		public Integer population {get;set;} 
		public Integer timezone {get;set;} 

		public City(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'id') {
							id = parser.getIntegerValue();
						} else if (text == 'name') {
							name = parser.getText();
						} else if (text == 'coord') {
							coord = new Coord(parser);
						} else if (text == 'country') {
							country = parser.getText();
						} else if (text == 'population') {
							population = parser.getIntegerValue();
						} else if (text == 'timezone') {
							timezone = parser.getIntegerValue();
						} else {
							System.debug(LoggingLevel.WARN, 'City consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Sys {
		public String pod {get;set;} 

		public Sys(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'pod') {
							pod = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'Sys consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Weather {
		public Integer id {get;set;} 
		public String main {get;set;} 
		public String description {get;set;} 
		public String icon {get;set;} 

		public Weather(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'id') {
							id = parser.getIntegerValue();
						} else if (text == 'main') {
							main = parser.getText();
						} else if (text == 'description') {
							description = parser.getText();
						} else if (text == 'icon') {
							icon = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'Weather consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Coord {
		public Double lat {get;set;} 
		public Double lon {get;set;} 

		public Coord(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'lat') {
							lat = parser.getDoubleValue();
						} else if (text == 'lon') {
							lon = parser.getDoubleValue();
						} else {
							System.debug(LoggingLevel.WARN, 'Coord consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Rain {
		public Integer h {get;set;} 

		public Rain(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'h') {
							h = parser.getIntegerValue();
						} else {
							System.debug(LoggingLevel.WARN, 'Rain consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Wind_Z {
		public Integer speed {get;set;} 
		public Double deg {get;set;} 

		public Wind_Z(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'speed') {
							speed = parser.getIntegerValue();
						} else if (text == 'deg') {
							deg = parser.getDoubleValue();
						} else {
							System.debug(LoggingLevel.WARN, 'Wind_Z consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class List_Z {
		public Integer dt {get;set;} 
		public Main main {get;set;} 
		public List<Weather> weather {get;set;} 
		public Clouds clouds {get;set;} 
		public Wind wind {get;set;} 
		public Rain rain {get;set;} 
		public Sys sys {get;set;} 
		public String dt_txt {get;set;} 

		public List_Z(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'dt') {
							dt = parser.getIntegerValue();
						} else if (text == 'main') {
							main = new Main(parser);
						} else if (text == 'weather') {
							weather = arrayOfWeather(parser);
						} else if (text == 'clouds') {
							clouds = new Clouds(parser);
						} else if (text == 'wind') {
							wind = new Wind(parser);
						} else if (text == 'rain') {
							rain = new Rain(parser);
						} else if (text == 'sys') {
							sys = new Sys(parser);
						} else if (text == 'dt_txt') {
							dt_txt = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'List_Z consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Main_Z {
		public Double temp {get;set;} 
		public Double temp_min {get;set;} 
		public Double temp_max {get;set;} 
		public Double pressure {get;set;} 
		public Double sea_level {get;set;} 
		public Double grnd_level {get;set;} 
		public Integer humidity {get;set;} 
		public Integer temp_kf {get;set;} 

		public Main_Z(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'temp') {
							temp = parser.getDoubleValue();
						} else if (text == 'temp_min') {
							temp_min = parser.getDoubleValue();
						} else if (text == 'temp_max') {
							temp_max = parser.getDoubleValue();
						} else if (text == 'pressure') {
							pressure = parser.getDoubleValue();
						} else if (text == 'sea_level') {
							sea_level = parser.getDoubleValue();
						} else if (text == 'grnd_level') {
							grnd_level = parser.getDoubleValue();
						} else if (text == 'humidity') {
							humidity = parser.getIntegerValue();
						} else if (text == 'temp_kf') {
							temp_kf = parser.getIntegerValue();
						} else {
							System.debug(LoggingLevel.WARN, 'Main_Z consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Rain_Z {
		public Double h {get;set;} 

		public Rain_Z(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == '3h') {
							h = parser.getDoubleValue();
						} else {
							System.debug(LoggingLevel.WARN, 'Rain_Z consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Main {
		public Double temp {get;set;} 
		public Double temp_min {get;set;} 
		public Double temp_max {get;set;} 
		public Double pressure {get;set;} 
		public Double sea_level {get;set;} 
		public Double grnd_level {get;set;} 
		public Integer humidity {get;set;} 
		public Double temp_kf {get;set;} 

		public Main(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'temp') {
							temp = parser.getDoubleValue();
						} else if (text == 'temp_min') {
							temp_min = parser.getDoubleValue();
						} else if (text == 'temp_max') {
							temp_max = parser.getDoubleValue();
						} else if (text == 'pressure') {
							pressure = parser.getDoubleValue();
						} else if (text == 'sea_level') {
							sea_level = parser.getDoubleValue();
						} else if (text == 'grnd_level') {
							grnd_level = parser.getDoubleValue();
						} else if (text == 'humidity') {
							humidity = parser.getIntegerValue();
						} else if (text == 'temp_kf') {
							temp_kf = parser.getDoubleValue();
						} else {
							System.debug(LoggingLevel.WARN, 'Main consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Main_Y {
		public Double temp {get;set;} 
		public Double temp_min {get;set;} 
		public Double temp_max {get;set;} 
		public Double pressure {get;set;} 
		public Double sea_level {get;set;} 
		public Integer grnd_level {get;set;} 
		public Integer humidity {get;set;} 
		public Integer temp_kf {get;set;} 

		public Main_Y(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'temp') {
							temp = parser.getDoubleValue();
						} else if (text == 'temp_min') {
							temp_min = parser.getDoubleValue();
						} else if (text == 'temp_max') {
							temp_max = parser.getDoubleValue();
						} else if (text == 'pressure') {
							pressure = parser.getDoubleValue();
						} else if (text == 'sea_level') {
							sea_level = parser.getDoubleValue();
						} else if (text == 'grnd_level') {
							grnd_level = parser.getIntegerValue();
						} else if (text == 'humidity') {
							humidity = parser.getIntegerValue();
						} else if (text == 'temp_kf') {
							temp_kf = parser.getIntegerValue();
						} else {
							System.debug(LoggingLevel.WARN, 'Main_Y consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Main_X {
		public Integer temp {get;set;} 
		public Integer temp_min {get;set;} 
		public Integer temp_max {get;set;} 
		public Double pressure {get;set;} 
		public Double sea_level {get;set;} 
		public Double grnd_level {get;set;} 
		public Integer humidity {get;set;} 
		public Integer temp_kf {get;set;} 

		public Main_X(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'temp') {
							temp = parser.getIntegerValue();
						} else if (text == 'temp_min') {
							temp_min = parser.getIntegerValue();
						} else if (text == 'temp_max') {
							temp_max = parser.getIntegerValue();
						} else if (text == 'pressure') {
							pressure = parser.getDoubleValue();
						} else if (text == 'sea_level') {
							sea_level = parser.getDoubleValue();
						} else if (text == 'grnd_level') {
							grnd_level = parser.getDoubleValue();
						} else if (text == 'humidity') {
							humidity = parser.getIntegerValue();
						} else if (text == 'temp_kf') {
							temp_kf = parser.getIntegerValue();
						} else {
							System.debug(LoggingLevel.WARN, 'Main_X consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	public static WeatherJsonParser parse(String json) {
		System.JSONParser parser = System.JSON.createParser(json);
		return new WeatherJsonParser(parser);
	}
	public static void consumeObject(System.JSONParser parser) {
		Integer depth = 0;
		do {
			System.JSONToken curr = parser.getCurrentToken();
			if (curr == System.JSONToken.START_OBJECT || 
				curr == System.JSONToken.START_ARRAY) {
				depth++;
			} else if (curr == System.JSONToken.END_OBJECT ||
				curr == System.JSONToken.END_ARRAY) {
				depth--;
			}
		} while (depth > 0 && parser.nextToken() != null);
	}
    private static List<Weather> arrayOfWeather(System.JSONParser p) {
        List<Weather> res = new List<Weather>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new Weather(p));
        }
        return res;
    }
    private static List<List_Z> arrayOfList_Z(System.JSONParser p) {
        List<List_Z> res = new List<List_Z>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new List_Z(p));
        }
        return res;
    }
}