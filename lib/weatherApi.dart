import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:weather_app/objects/weather.dart';
import 'package:geolocator/geolocator.dart';

class WeatherApi {
  static Future<Weather> fetchWeather() async {
    String? uri =
        "http://api.weatherapi.com/v1/current.json?key=984fd85ccdce4550947184750222706&q=";

    await Geolocator.getCurrentPosition().then((Position position) {
      uri = uri! +
          position.latitude.toString() +
          ',' +
          position.longitude.toString();
    });

    final response = await http.get(Uri.parse(uri!));

    if (response.statusCode == 200) {
      return Weather.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
