import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/objects/hourlyWeather.dart';
import 'package:weather_app/objects/weather.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/widget/dateWidget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather_app/widget/location.dart';
import 'package:weather_app/widget/overallWeatherCard.dart';
import 'package:weather_app/widget/temperature.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:draw_graph/draw_graph.dart';
import 'package:draw_graph/models/feature.dart';

class Index extends StatefulWidget {
  const Index({Key? key}) : super(key: key);

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  Position? _currentPosition;

  late Future<Weather> futureWeather;
  late Future<HourlyWeather> futureHourlyWeather;

  List<String> labelX = [];
  List<String> labelY = ['Sunday'];
  final List<Feature> features = [];
  List<double> chanceRain = [];

  Future<HourlyWeather> fetchHourlyWeather() async {
    String? hourlyUri =
        "http://api.weatherapi.com/v1/forecast.json?key=984fd85ccdce4550947184750222706&q=";
    await Geolocator.getCurrentPosition().then((Position position) async {
      setState(() {
        _currentPosition = position;

        hourlyUri = hourlyUri! +
            _currentPosition!.latitude.toString() +
            ',' +
            _currentPosition!.longitude.toString();
        hourlyUri = hourlyUri! + "&days=1&aqi=no&alerts=no";
      });
    });
    final hourlyResponse = await http.get(Uri.parse(hourlyUri!));

    if (hourlyResponse.statusCode == 200) {
      return HourlyWeather.makeList(json.decode(hourlyResponse.body));
    } else {
      throw Exception("Failed to load hourly weather");
    }
  }

  Future<Weather> fetchWeather() async {
    String? uri =
        "http://api.weatherapi.com/v1/current.json?key=984fd85ccdce4550947184750222706&q=";

    await Geolocator.getCurrentPosition().then((Position position) {
      setState(() {
        _currentPosition = position;
        uri = uri! +
            _currentPosition!.latitude.toString() +
            ',' +
            _currentPosition!.longitude.toString();
      });
    });

    final response = await http.get(Uri.parse(uri!));

    if (response.statusCode == 200) {
      return Weather.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  @override
  void initState() {
    super.initState();
    futureWeather = fetchWeather();
    futureHourlyWeather = fetchHourlyWeather();

    for (int i = 0; i < 24; i++) {
      labelX.insert(i, i.toString());
    }

    futureHourlyWeather.then((value) => {
          value.rain!.forEach((element) {
            chanceRain.insert(0, element.toDouble());
          })
        });
    features.add(
      Feature(
        title: 'Rain Chance',
        color: Color.fromARGB(255, 253, 194, 106),
        data: chanceRain,
      ),
    );
  }

  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: size.height * 0.03,
            top: size.height * 0.08,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Weather Forecast',
                  style: GoogleFonts.roboto(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              FutureBuilder<Weather>(
                future: futureWeather,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        overallWeatherCard(
                          tempC: snapshot.data!.tempC,
                          city: snapshot.data!.city,
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Text(
                      '${snapshot.error}',
                      style: GoogleFonts.poppins(
                        fontSize: 36,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    );
                  }
                  // By default, show a loading spinner.
                  return Container(
                    padding: EdgeInsets.only(top: size.height * 0.1),
                    child: Center(
                      child: const CircularProgressIndicator(),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        "Today",
                        style: GoogleFonts.roboto(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        "Next 7 Days",
                        style: GoogleFonts.roboto(
                            fontSize: 20,
                            color: Color.fromARGB(255, 253, 194, 106)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              FutureBuilder<HourlyWeather>(
                future: futureHourlyWeather,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              for (int i = 0;
                                  i < snapshot.data!.tempC!.length;
                                  i++)
                                Row(
                                  children: [
                                    Container(
                                      height: 130,
                                      width: 130,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Color(0XFF3D3748).withOpacity(0.1),
                                            Color(0XFF3D3748).withOpacity(0.5),
                                          ],
                                          begin: AlignmentDirectional.topStart,
                                          end: AlignmentDirectional.bottomEnd,
                                        ),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Container(
                                        padding: EdgeInsets.only(
                                          top: 10,
                                          left: 20,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              alignment: Alignment.center,
                                              child: Icon(
                                                Icons.cloud,
                                                color: Colors.white,
                                                size: 40,
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              "Time " +
                                                  (i + 1).toString() +
                                                  " hr",
                                              style: GoogleFonts.roboto(
                                                fontSize: 12,
                                                color: Colors.white,
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Row(
                                              children: [
                                                Text(
                                                  snapshot.data!.tempC![i]
                                                      .toString(),
                                                  style: GoogleFonts.roboto(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Text(
                                                  '°C',
                                                  style: GoogleFonts.roboto(
                                                      fontSize: 14,
                                                      color: Color.fromARGB(
                                                          255, 253, 194, 106)),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ],
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text(
                      '${snapshot.error}',
                      style: GoogleFonts.poppins(
                        fontSize: 36,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    );
                  }
                  // By default, show a loading spinner.
                  return Container(
                    padding: EdgeInsets.only(top: size.height * 0.1),
                    child: Center(
                      child: const CircularProgressIndicator(),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                "Chance of Rain",
                style: GoogleFonts.roboto(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: LineGraph(
                  features: features,
                  size: Size(600, 300),
                  labelX: labelX,
                  labelY: ["0", "1"],
                  showDescription: true,
                  graphColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
