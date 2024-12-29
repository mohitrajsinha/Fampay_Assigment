// import 'package:flutter/material.dart';
// import '../models/card_model.dart';
// import 'hc3_widget.dart'; // Assuming HC3Widget exists
// import 'hc6_widget.dart'; // Assuming HC6Widget exists

// class ContextualCard extends StatelessWidget {
//   final ApiData apiData;

//   const ContextualCard({super.key, required this.apiData});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: Column(
//         children: apiData.hcGroups.map((group) {
//           return Column(
//             children: group.cards.map((card) {
//               switch (group.designType) {
//                 case 'HC3':
//                   return HC3Widget(
//                     id: card.id,
//                     height: group.height!,
//                     title: card.formattedTitle?.entities[0].text ?? '',
//                     description: card.formattedTitle?.entities[0].text ?? '',
//                     formatText: card.formattedTitle?.text ?? '',
//                     titleFontSize:
//                         card.formattedTitle?.entities[0].fontSize ?? 14,
//                     descriptionFontSize:
//                         card.formattedTitle?.entities[0].fontSize ?? 14,
//                     titleColor: card.formattedTitle?.entities[0].color,
//                     descriptionColor: card.formattedTitle?.entities[0].color,
//                     cta: card.cta != null && card.cta!.isNotEmpty
//                         ? card.cta![0]
//                         : null,
//                     bgImage: card.bgImage!,
//                     url: card.url,
//                   );
//                 case 'HC6':
//                   return HC6Widget(
//                     text: card.formattedTitle?.text ?? '',
//                     // color: card.formattedTitle?.entities[0].color != null
//                     //     ? Color(int.parse(card.formattedTitle!.entities[0].color!.replaceAll('#', '0xff')))
//                     //     : Colors.transparent,
//                     height: group.height!,
//                     fontStyle: card.formattedTitle?.entities[0].fontStyle ?? '',
//                     fontFamily:
//                         card.formattedTitle?.entities[0].fontFamily ?? '',
//                     url: card.url!,
//                     // bgColor: card.bgColor!,
//                     iconSize: card.iconSize!,
//                   );
//                 default:
//                   return const SizedBox
//                       .shrink(); // Handle unknown types gracefully
//               }
//             }).toList(),
//           );
//         }).toList(),
//       ),
//     );
//   }
// }
