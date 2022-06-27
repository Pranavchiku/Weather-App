import 'package:flutter/material.dart';
import 'package:weather_app/widget/landingImage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/widget/landingText.dart';

void main() {
  runApp(
    MaterialApp(
      home: LandingPage(),
      theme: new ThemeData(
        // scaffoldBackgroundColor: Color.fromRGBO(31, 40, 94, 1),
        scaffoldBackgroundColor: Color(0XFF030311),
      ),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            left: 30,
            right: 30,
            bottom: size.height * 0.03,
            top: size.height * 0.09,
          ),
          width: size.width,
          height: size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              landingImage(imagePath: "images/cover-bgless.png"),
              const SizedBox(
                height: 20,
              ),
              const landingText(),
            ],
          ),
        ),
      ),
    );
  }
}
