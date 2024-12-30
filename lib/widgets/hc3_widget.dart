import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/models.dart';

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
  final String titleFontStyle;
  final String descriptionFontStyle;
  final String titleFontFamily;
  final String descriptionFontFamily;

  const HC3Widget({
    super.key,
    required this.id,
    required this.height,
    required this.title,
    required this.description,
    required this.formatText,
    required this.titleFontSize,
    required this.descriptionFontSize,
    this.titleColor,
    this.descriptionColor,
    this.cta,
    required this.bgImage,
    this.url,
    required this.titleFontStyle,
    required this.descriptionFontStyle,
    required this.titleFontFamily,
    required this.descriptionFontFamily,
  });

  @override
  _HC3WidgetState createState() => _HC3WidgetState();
}

class _HC3WidgetState extends State<HC3Widget>
    with SingleTickerProviderStateMixin {
  bool _isLongPressed = false;
  bool _isVisible = true;

  late AnimationController _controller;
  late Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _checkIfDismissed();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _initializeAnimations() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _slideAnimation = Tween<double>(begin: 0, end: 100.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    _slideAnimation.addListener(() => setState(() {}));
  }

  Future<void> _checkIfDismissed() async {
    final prefs = await SharedPreferences.getInstance();
    final dismissedCards = prefs.getStringList('dismissedCards') ?? [];

    if (dismissedCards.contains(widget.id.toString())) {
      setState(() => _isVisible = false);
    }
  }

  Future<void> _updateCardVisibility(String action) async {
    final prefs = await SharedPreferences.getInstance();
    const dismissedKey = 'dismissedCards';

    if (action == 'dismiss') {
      final dismissedCards = prefs.getStringList(dismissedKey) ?? [];
      dismissedCards.add(widget.id.toString());
      await prefs.setStringList(dismissedKey, dismissedCards);
    }

    setState(() => _isVisible = false);
  }

  void _handleLongPress() {
    setState(() {
      _isLongPressed = true;
      _controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isVisible) return const SizedBox.shrink();

    final subtitle = widget.formatText.replaceAll(RegExp(r'[{}\n]'), '');

    return Stack(
      children: [
        if (_isLongPressed) _buildActionMenu(),
        Transform.translate(
          offset: Offset(_slideAnimation.value, 0),
          child: GestureDetector(
            onLongPress: _handleLongPress,
            child: _buildCardContent(subtitle),
          ),
        ),
      ],
    );
  }

  Widget _buildActionMenu() {
    return Positioned(
      left: 0,
      top: 0,
      bottom: 0,
      child: Container(
        width: 100,
        color: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildActionButton('Remind Later', Icons.timer,
                () => _updateCardVisibility('remindLater')),
            _buildActionButton(
                'Dismiss', Icons.close, () => _updateCardVisibility('dismiss')),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(String label, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: const Color(0xffF7F6F3),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.amberAccent, size: 40),
            const SizedBox(height: 8),
            Text(label,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildCardContent(String subtitle) {
    return Container(
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
                color: _parseColor(widget.titleColor) ?? Colors.white,
                fontSize: widget.titleFontSize.toDouble(),
                fontWeight: FontWeight.w600,
                fontStyle: widget.titleFontStyle == 'italic'
                    ? FontStyle.italic
                    : FontStyle.normal,
                decoration: widget.titleFontStyle == 'underline'
                    ? TextDecoration.underline
                    : TextDecoration.none,
                fontFamily: widget.titleFontFamily,
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
                  color: _parseColor(widget.descriptionColor) ?? Colors.white,
                  fontStyle: widget.descriptionFontStyle == 'italic'
                      ? FontStyle.italic
                      : FontStyle.normal,
                  decoration: widget.descriptionFontStyle == 'underline'
                      ? TextDecoration.underline
                      : TextDecoration.none,
                  fontFamily: widget.descriptionFontFamily),
            ),
            const SizedBox(height: 16),
            _buildCtaButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildCtaButton() {
    return ElevatedButton(
      onPressed: () {
        if (widget.url != null) {
          launch(widget.url!);
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      ),
      child: Text(
        widget.cta?.text.isEmpty ?? true ? 'Action' : widget.cta!.text,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  Future<void> _launchUrl() async {
    if (widget.url != null && await canLaunchUrl(Uri.parse(widget.url!))) {
      await launchUrl(Uri.parse(widget.url!));
    }
  }

  Color? _parseColor(String? color) {
    if (color == null) return null;
    return Color(int.parse(color.replaceFirst('#', '0xff')));
  }
}
