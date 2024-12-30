import 'package:flutter/material.dart';

class HC9Card extends StatelessWidget {
  final List<String> hexGradientColors;
  final int height;
  final int angle;
  final String imageUrl;
  final double aspectRatio;

  const HC9Card({
    Key? key,
    required this.hexGradientColors,
    required this.height,
    required this.imageUrl,
    required this.aspectRatio,
    this.angle = 0, // Default angle is 0 degrees
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Using the passed aspect ratio to calculate the width
    double width = height * aspectRatio;

    return Container(
      width: width,
      height: height.toDouble(),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: hexGradientColors
              .map((color) => Color(int.parse(color.replaceAll('#', '0xff'))))
              .toList(),
          transform: GradientRotation(
              angle * 3.14159 / 180), // Converting degrees to radians
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
          width: width,
          height: height.toDouble(),
        ),
      ),
    );
  }

 
}