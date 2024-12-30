import 'package:fampay_assignment/models/contextual_card.dart';
import 'package:flutter/material.dart';

class HC1Widget extends StatelessWidget {
  final int height;
  final String bgColor;
  final bool isScrollable; 
  final List<ContextualCard> cards;

  const HC1Widget({
    super.key,
    required this.height,
    required this.bgColor,
    required this.isScrollable, 
    required this.cards,
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Container(
      margin: const EdgeInsets.only(top: 16),
      width: width,
      height: height.toDouble(),
      child: isScrollable
          ? ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: cards.length,
              separatorBuilder: (context, index) =>
                  const SizedBox(width: 16), 
              itemBuilder: (context, index) {
                return buildCard(cards[index]);
              },
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: cards.map((card) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: buildCard(card),
                  ),
                );
              }).toList(),
            ),
    );
  }

  Widget buildCard(ContextualCard card) {
    return Container(
      decoration: BoxDecoration(
        color: Color(int.parse(card.bgColor?.replaceFirst('#', '0xff') ??
            '0xffF7F6F3')), 
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Image.network(
            card.icon?.imageUrl ?? '',
            width: card.iconSize?.toDouble() ?? 40,
            height: card.iconSize?.toDouble() ?? 40,
            fit: BoxFit.cover,
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) {
                return child;
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
            errorBuilder:
                (BuildContext context, Object error, StackTrace? stackTrace) {
              return const Icon(Icons.image_not_supported, size: 50);
            },
          ),
          const SizedBox(width: 8),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                card.formattedTitle?.entities[0].text ?? '',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(int.parse(card.formattedTitle?.entities[0].color
                          ?.replaceFirst('#', '0xff') ??
                      '0xff000000')), 
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              if (card.formattedDescription != null)
                Text(
                  card.formattedDescription!.entities[0].text ?? '',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(int.parse(card
                            .formattedDescription!.entities[0].color
                            ?.replaceFirst('#', '0xff') ??
                        '0xff666666')), 
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
            ],
          ),
        ],
      ),
    );
  }
}
