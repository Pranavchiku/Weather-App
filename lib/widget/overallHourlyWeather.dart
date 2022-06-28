import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/objects/weather.dart';
import 'package:weather_app/widget/hourlyCard.dart';

class overallHourlyWeather extends StatefulWidget {
  Future<Weather>? futureWeather;

  overallHourlyWeather({required this.futureWeather});
  @override
  State<overallHourlyWeather> createState() => _overallHourlyWeatherState();
}

class _overallHourlyWeatherState extends State<overallHourlyWeather> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return FutureBuilder<Weather>(
      future: widget.futureWeather,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    for (int i = 0; i < snapshot.data!.tempHourly!.length; i++)
                      hourlyCard(
                        imagePath: snapshot.data!.hourlyIconPath![i],
                        temp: snapshot.data!.tempHourly![i],
                        time: i,
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
