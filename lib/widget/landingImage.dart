import 'package:flutter/material.dart';

class landingImage extends StatelessWidget {
  String? imagePath;
  landingImage({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath!),
        ),
      ),
    );
  }
}
