import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HC6Widget extends StatefulWidget {
  final int height;
  final String text;
  final String fontStyle;
  final String fontFamily;
  final String url;
  final String bgColor;
  final int iconSize;

  const HC6Widget({
    super.key,
    required this.text,
    required this.height,
    required this.fontStyle,
    required this.fontFamily,
    required this.url,
    required this.bgColor,
    required this.iconSize,
  });

  @override
  State<HC6Widget> createState() => _HC6WidgetState();
}

class _HC6WidgetState extends State<HC6Widget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height.toDouble(),
      decoration: BoxDecoration(
        color: Color(int.parse(widget.bgColor.replaceAll('#', '0xff'))),
        border: Border.all(width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(
          horizontal: 16), // Uniform horizontal padding
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween, // Space between elements
        crossAxisAlignment: CrossAxisAlignment.center, // Center vertically
        children: [
          Row(
            children: [
              Image.network(
                widget.url,
                height: widget.iconSize.toDouble(),
                width: widget.iconSize.toDouble(),
              ),
              const SizedBox(width: 10),
              Text(
                widget.text,
                style: TextStyle(
                  color: const Color(0xff000000),
                  fontSize: widget.height / 2,
                  decoration: widget.fontStyle == 'underline'
                      ? TextDecoration.underline
                      : TextDecoration.none,
                  fontFamily: widget.fontFamily,
                ),
              ),
            ],
          ),
          IconButton(
            icon: Icon(
              Icons.arrow_forward_ios,
              size: widget.iconSize.toDouble(),
            ),
            onPressed: () {
              launch(widget.url);
            },
          ),
        ],
      ),
    );
  }
}