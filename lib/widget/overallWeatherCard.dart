import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/objects/weather.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/widget/dateWidget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather_app/widget/location.dart';
import 'package:weather_app/widget/temperature.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class overallWeatherCard extends StatefulWidget {
  double? tempC;
  String? city;
  String? imagePath;
  overallWeatherCard(
      {required this.tempC, required this.city, required this.imagePath});

  @override
  State<overallWeatherCard> createState() => _overallWeatherCardState();
}

class _overallWeatherCardState extends State<overallWeatherCard> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      height: 200,
      width: size.width,
      padding: EdgeInsets.only(
        top: 20,
        left: 30,
        bottom: 20,
        right: 30,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0XFF3D3748).withOpacity(0.1),
            Color(0XFF3D3748).withOpacity(0.15),
          ],
          begin: AlignmentDirectional.topStart,
          end: AlignmentDirectional.bottomEnd,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          date(),
          const SizedBox(
            height: 20,
          ),
          temperature(temp: widget.tempC, imagePath: widget.imagePath),
          const SizedBox(
            height: 20,
          ),
          location(city: widget.city),
        ],
      ),
    );
  }
}
