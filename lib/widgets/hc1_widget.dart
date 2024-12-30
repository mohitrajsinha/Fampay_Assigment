import 'package:flutter/material.dart';

class HC1Widget extends StatelessWidget {
  final int height;
  final String bgColor;
  final String imageUrl;
  final String title;
  final String description;
  final String titleColor;
  final String descriptionColor;

  const HC1Widget({
    super.key,
    required this.height,
    required this.bgColor,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.titleColor,
    required this.descriptionColor,
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.only(top: 16, bottom: 16),
      width: width,
      height: height.toDouble() + 16,
      decoration: BoxDecoration(
        color: Color(int.parse(bgColor.replaceFirst('#', '0xff'))),
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Image.network(
            imageUrl,
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) {
                return child;
              } else {
                return const Center(
                    child: Icon(
                  Icons.person_2_rounded,
                ));
              }
            },
            errorBuilder:
                (BuildContext context, Object error, StackTrace? stackTrace) {
              return const Center(child: Icon(Icons.person));
            },
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color:
                        Color(int.parse(titleColor.replaceFirst('#', '0xff'))),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 5),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(
                        int.parse(descriptionColor.replaceFirst('#', '0xff'))),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
