import 'package:flutter/material.dart';

class imageIcon extends StatelessWidget {
  String? imagePath;
  imageIcon({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Container(
        height: 64,
        width: 64,
        child: ImageIcon(
          NetworkImage(
            "https:" + imagePath!,
          ),
          color: Colors.white,
        ),
      ),
    );
  }
}
