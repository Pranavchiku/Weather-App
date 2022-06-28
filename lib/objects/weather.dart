class Weather {
  double? tempC;
  String? condition;
  String? iconPath;
  String? city;
  double? windKph;
  List<double>? tempHourly;
  List<int>? chanceOfRain;
  List<String>? hourlyIconPath;
  String? sunrise;
  String? sunset;
  double? uv;
  int? humidity;
  Weather({
    required this.tempC,
    this.condition,
    this.iconPath,
    required this.city,
    required this.windKph,
    required this.tempHourly,
    required this.chanceOfRain,
    required this.hourlyIconPath,
    required this.sunrise,
    required this.sunset,
    required this.uv,
    required this.humidity,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    List<double> temp = [];
    List<int> rainH = [];
    List<String> hourlyIconPath = [];

    for (int i = 0; i < 24; i++) {
      temp.insert(
          i, json['forecast']['forecastday'][0]['hour'][i]['temp_c'] as double);

      rainH.insert(
          i,
          json['forecast']['forecastday'][0]['hour'][i]['chance_of_rain']
              as int);

      hourlyIconPath.insert(
          i,
          json['forecast']['forecastday'][0]['hour'][i]['condition']['icon']
              as String);
    }
    return Weather(
      tempC: json['current']["temp_c"] as double,
      condition: json['current']["condition"]["text"] as String,
      iconPath: json['current']["condition"]["icon"] as String,
      city: json["location"]["name"] as String,
      windKph: json['current']["wind_kph"] as double,
      tempHourly: temp,
      chanceOfRain: rainH,
      hourlyIconPath: hourlyIconPath,
      sunrise: json['forecast']['forecastday'][0]['astro']['sunrise'] as String,
      sunset: json['forecast']['forecastday'][0]['astro']['sunset'] as String,
      uv: json['forecast']['forecastday'][0]['day']['uv'] as double,
      humidity: json['current']["humidity"] as int,
    );
  }
}
