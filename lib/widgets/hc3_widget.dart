import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/card_model.dart';

class HC3Widget extends StatefulWidget {
  final int id;
  final int height;
  final String formatText;
  final String title;
  final int titleFontSize;
  final String? titleColor;
  final String? description;
  final int descriptionFontSize;
  final String? descriptionColor;
  final Cta? cta;
  final BgImage bgImage;
  final String? url;

  const HC3Widget({
    super.key,
    required this.id,
    required this.height,
    required this.title,
    required this.description,
    required this.formatText,
    required this.titleFontSize,
    required this.descriptionFontSize,
    required this.titleColor,
    required this.descriptionColor,
    required this.cta,
    required this.bgImage,
    required this.url,
  });

  @override
  _HC3WidgetState createState() => _HC3WidgetState();
}

class _HC3WidgetState extends State<HC3Widget> {
  bool _longPressed = false;

  @override
  Widget build(BuildContext context) {
    String subtitle = widget.formatText.replaceAll(RegExp(r'[\{\}\n]'), '');
    var width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onLongPress: () {
        setState(() {
          _longPressed = !_longPressed;
        });
      },
      child: Row(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: _longPressed ? width / 3 : 0,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                bottomLeft: Radius.circular(15),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildActionCard("Remind later", Icons.notifications),
                const SizedBox(height: 10),
                _buildActionCard(
                    "Dismiss now", Icons.disabled_by_default_rounded),
              ],
            ),
          ),
          Expanded(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: widget.height.toDouble() - 200,
              decoration: BoxDecoration(
                color: const Color(0xff454AA6),
                image: DecorationImage(
                  image: NetworkImage(widget.bgImage.imageUrl),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: widget.height.toDouble() / 4),
                    Text(
                      widget.title,
                      style: TextStyle(
                        color: widget.titleColor != null
                            ? Color(int.parse(
                                widget.titleColor!.replaceFirst('#', '0xff')))
                            : Colors.white,
                        fontSize: widget.titleFontSize.toDouble(),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: widget.titleFontSize.toDouble(),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      widget.description?.isNotEmpty ?? false
                          ? widget.description!
                          : "This is a sample text for the subtitle that you can add to contextual cards",
                      style: TextStyle(
                        fontSize: widget.descriptionFontSize.toDouble(),
                      ),
                    ),
                    // const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () async {
                        try {
                          await launch(widget.url!);
                        } catch (e) {
                          // Handle URL launch error
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.black),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      child: Text(
                        widget.cta?.text.isEmpty ?? true
                            ? 'Action'
                            : widget.cta!.text,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard(String label, IconData icon) {
    var width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        // Handle action tap if needed
      },
      child: Container(
        width: width / 4,
        height: width / 4,
        decoration: BoxDecoration(
          color: const Color(0xffF7F6F3),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                icon,
                color: Colors.amberAccent,
                size: width / 8,
              ),
              Text(
                label,
                style: TextStyle(fontSize: width / 30),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
