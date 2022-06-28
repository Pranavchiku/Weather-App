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
import 'package:weather_app/widget/hourlyTemperature.dart';
import 'package:weather_app/widget/imageIcon.dart';
import 'package:weather_app/widget/location.dart';
import 'package:weather_app/widget/overallWeatherCard.dart';
import 'package:weather_app/widget/temperature.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:draw_graph/draw_graph.dart';
import 'package:draw_graph/models/feature.dart';

class hourlyCard extends StatelessWidget {
  String? imagePath;
  int? time;
  double? temp;

  hourlyCard({
    required this.imagePath,
    required this.time,
    required this.temp,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 140,
          width: 140,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                imageIcon(imagePath: imagePath),
                const SizedBox(height: 10),
                Text(
                  "Time: " + (time! + 1).toString() + " hr",
                  style: GoogleFonts.roboto(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                hourlyTemperature(
                  temp: temp,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
      ],
    );
  }
}
