class HourlyWeather {
  List<double>? tempC;
  List<int>? rain;
  HourlyWeather({
    required this.tempC,
    required this.rain,
  });

  factory HourlyWeather.makeList(Map<String, dynamic> json) {
    List<double> temp = [];
    List<int> rainH = [];

    for (int i = 0; i < 24; i++) {
      temp.insert(
          i, json['forecast']['forecastday'][0]['hour'][i]['temp_c'] as double);

      rainH.insert(
          i,
          json['forecast']['forecastday'][0]['hour'][i]['chance_of_rain']
              as int);
    }
    return HourlyWeather(
      tempC: temp,
      rain: rainH,
    );
  }
}
