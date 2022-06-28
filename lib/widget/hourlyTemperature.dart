import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class hourlyTemperature extends StatelessWidget {
  double? temp;
  hourlyTemperature({required this.temp});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          temp!.toString(),
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
            color: Color.fromARGB(255, 253, 194, 106),
          ),
        ),
      ],
    );
  }
}
