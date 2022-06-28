import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/objects/weather.dart';
import 'package:weather_app/widget/hourlyCard.dart';

class dayCondition extends StatefulWidget {
  Future<Weather>? futureWeather;

  dayCondition({required this.futureWeather});
  @override
  State<dayCondition> createState() => _dayConditionState();
}

class _dayConditionState extends State<dayCondition> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return FutureBuilder<Weather>(
      future: widget.futureWeather,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            height: 150,
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      child: Icon(
                        FeatherIcons.sun,
                        color: Color.fromARGB(255, 253, 194, 106),
                        size: 40,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "UV Index",
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      snapshot.data!.uv.toString(),
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 120,
                  child: VerticalDivider(color: Colors.white),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      child: Icon(
                        FeatherIcons.wind,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Wind",
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      snapshot.data!.windKph.toString() + " km/h",
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 120,
                  child: VerticalDivider(color: Colors.white),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      child: Icon(
                        FeatherIcons.droplet,
                        color: Color.fromARGB(255, 253, 194, 106),
                        size: 40,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Humidity",
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      snapshot.data!.humidity.toString(),
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                        color: Colors.white,
                      ),
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
    );
  }
}
