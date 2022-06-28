import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/objects/weather.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/weatherApi.dart';
import 'package:weather_app/widget/dateWidget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather_app/widget/dayCondition.dart';
import 'package:weather_app/widget/hourlyCard.dart';
import 'package:weather_app/widget/location.dart';
import 'package:weather_app/widget/overallHourlyWeather.dart';
import 'package:weather_app/widget/overallWeatherCard.dart';
import 'package:weather_app/widget/temperature.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:draw_graph/draw_graph.dart';
import 'package:draw_graph/models/feature.dart';
import 'package:weather_app/widget/timeDay.dart';

class Index extends StatefulWidget {
  const Index({Key? key}) : super(key: key);

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  Position? _currentPosition;

  late Future<Weather> futureWeather;

  List<String> labelX = [];
  List<String> labelY = ['Sunday'];
  final List<Feature> features = [];
  List<double> chanceRain = [];

  @override
  void initState() {
    super.initState();
    futureWeather = WeatherApi.fetchWeather();

    for (int i = 0; i < 24; i++) {
      labelX.insert(i, i.toString());
    }

    futureWeather.then((value) => {
          value.chanceOfRain!.forEach((element) {
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
                          imagePath: snapshot.data!.iconPath.toString(),
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
              overallHourlyWeather(futureWeather: futureWeather),
              const SizedBox(
                height: 30,
              ),
              Text(
                "Timings of the Day",
                style: GoogleFonts.roboto(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              timeDay(futureWeather: futureWeather),

              const SizedBox(
                height: 30,
              ),
              dayCondition(futureWeather: futureWeather),
              // SingleChildScrollView(
              //   scrollDirection: Axis.horizontal,
              //   child: LineGraph(
              //     features: features,
              //     size: Size(600, 300),
              //     labelX: labelX,
              //     labelY: ["0", "1"],
              //     showDescription: true,
              //     graphColor: Colors.white,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
