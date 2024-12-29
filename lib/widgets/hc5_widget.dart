import 'package:flutter/material.dart';

class HC5Widget extends StatefulWidget {
  final String bgImage;
  const HC5Widget({super.key, required this.bgImage});

  @override
  State<HC5Widget> createState() => _HC5WidgetState();
}

class _HC5WidgetState extends State<HC5Widget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.network(widget.bgImage, fit: BoxFit.cover),
    );
  }
}
