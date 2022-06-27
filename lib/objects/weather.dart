class Weather {
  double? tempC;
  String? condition;
  String? iconPath;
  String? city;
  double? winddKph;

  Weather({
    required this.tempC,
    this.condition,
    this.iconPath,
    required this.city,
    required this.winddKph,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      tempC: json['current']["temp_c"] as double,
      condition: json['current']["condition"]["text"] as String,
      iconPath: json['current']["condition"]["icon"] as String,
      city: json["location"]["name"] as String,
      winddKph: json['current']["wind_kph"] as double,
    );
  }
}
