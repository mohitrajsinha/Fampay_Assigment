import 'package:flutter/material.dart';

class HorizontalHC9Cards extends StatelessWidget {
  final List<Map<String, dynamic>> cards;
  final int height;

  const HorizontalHC9Cards({
    super.key,
    required this.cards,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SizedBox(
        height: height.toDouble(), // Adjust based on card height
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: cards.length,
          itemBuilder: (context, index) {
            final card = cards[index];
            return Padding(
              padding: const EdgeInsets.only(right: 12), // Spacing between cards
              child: HC9Card(
                hexGradientColors: List<String>.from(card['bg_gradient']['colors']),
                height: height,
                imageUrl: card['bg_image']['image_url'],
                aspectRatio: card['bg_image']['aspect_ratio'],
                angle: card['bg_gradient']['angle'],
              ),
            );
          },
        ),
      ),
    );
  }
}

class HC9Card extends StatelessWidget {
  final List<String> hexGradientColors;
  final int height;
  final int angle;
  final String imageUrl;
  final double aspectRatio;

  const HC9Card({
    super.key,
    required this.hexGradientColors,
    required this.height,
    required this.imageUrl,
    required this.aspectRatio,
    this.angle = 0, // Default angle is 0 degrees
  });

  @override
  Widget build(BuildContext context) {
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
          transform: GradientRotation(angle * 3.14159 / 180),
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
