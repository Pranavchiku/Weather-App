import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/objects/weather.dart';
import 'package:weather_app/widget/hourlyCard.dart';

class timeDay extends StatefulWidget {
  Future<Weather>? futureWeather;

  timeDay({required this.futureWeather});
  @override
  State<timeDay> createState() => _timeDayState();
}

class _timeDayState extends State<timeDay> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return FutureBuilder<Weather>(
      future: widget.futureWeather,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            height: 170,
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: Icon(
                        FeatherIcons.sunrise,
                        color: Color.fromARGB(255, 253, 194, 106),
                        size: 60,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Sunrise",
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      snapshot.data!.sunrise!.toString(),
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 30,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: Icon(
                        FeatherIcons.sunset,
                        color: Colors.white,
                        size: 60,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Sunset",
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      snapshot.data!.sunset!.toString(),
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
