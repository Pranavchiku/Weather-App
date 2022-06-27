import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/objects/weather.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/widget/dateWidget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather_app/widget/temperature.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class location extends StatelessWidget {
  String? city;
  location({required this.city});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          FeatherIcons.mapPin,
          color: Color.fromARGB(255, 253, 194, 106),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          city!,
          style: GoogleFonts.roboto(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
