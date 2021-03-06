import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/objects/weather.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/widget/dateWidget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather_app/widget/hourlyTemperature.dart';
import 'package:weather_app/widget/imageIcon.dart';

class temperature extends StatelessWidget {
  double? temp;
  String? imagePath;
  temperature({required this.temp, required this.imagePath});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            temp.toString(),
            style: GoogleFonts.roboto(
              fontSize: 45,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            '°C',
            style: GoogleFonts.roboto(
                fontSize: 26, color: Color.fromARGB(255, 253, 194, 106)),
          ),
          Spacer(),
          // Icon(
          //   Icons.cloud,
          //   color: Colors.white,
          //   size: 60,
          // ),
          imageIcon(
            imagePath: imagePath,
          ),
        ],
      ),
    );
  }
}
