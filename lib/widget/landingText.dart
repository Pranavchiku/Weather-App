import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/index.dart';

class landingText extends StatelessWidget {
  const landingText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Weather",
              style: GoogleFonts.poppins(
                fontSize: 36,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              "News",
              style: GoogleFonts.poppins(
                fontSize: 36,
                fontWeight: FontWeight.w400,
                color: Color.fromARGB(255, 253, 194, 106),
              ),
            ),
          ],
        ),
        Text(
          "& Feed",
          style: GoogleFonts.poppins(
            fontSize: 36,
            fontWeight: FontWeight.w400,
            color: Color.fromARGB(255, 253, 194, 106),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          "Weather is the state of the art of the world. \nIt is the most powerful tool to predict the future. \n",
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Color.fromARGB(255, 185, 182, 182),
          ),
        ),
        RaisedButton(
          onPressed: () => {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Index())),
          },
          elevation: 0,
          padding: EdgeInsets.all(18),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          color: Color.fromARGB(255, 253, 194, 106),
          child: Center(
            child: Text(
              "Get Started",
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
