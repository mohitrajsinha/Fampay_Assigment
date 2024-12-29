// import 'package:flutter/material.dart';
// import '../models/card_model.dart';

// class HC1Widget extends StatelessWidget {
//   final CardModel card;

//   const HC1Widget({super.key, required this.card});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.all(8.0),
//       decoration: BoxDecoration(
//         color: card.bgColor != null
//             ? Color(int.parse(card.bgColor!.replaceFirst('#', '0xff')))
//             : Colors.white,
//         borderRadius: BorderRadius.circular(8.0),
//       ),
//       child: Center(
//         child: Text(
//           card.formattedTitle?['text'] ?? '',
//           style: const TextStyle(fontSize: 18, color: Colors.black),
//         ),
//       ),
//     );
//   }
// }
