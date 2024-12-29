import 'package:fampay_assignment/widgets/hc3_widget.dart';
import 'package:fampay_assignment/widgets/hc5_widget.dart';
import 'package:fampay_assignment/widgets/hc6_widget.dart';
import 'package:fampay_assignment/widgets/hc9_widget.dart';
import 'package:flutter/material.dart';
import '../utils/api_service.dart';
import '../models/card_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<ApiData>> _futureCards;

  @override
  void initState() {
    super.initState();
    _futureCards = ApiService.fetchCards();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('fampay'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<ApiData>>(
        future: _futureCards,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No cards available.'));
          }

          final cards = snapshot.data!;

          // Flatten the list to include all widgets
          final allWidgets = cards
              .expand((apiData) => apiData.hcGroups.expand((group) =>
                  group.cards.map((card) => _buildCard(group, card))))
              .toList();

          return ListView.builder(
            padding: const EdgeInsets.only(right: 20, left: 20),
            itemCount: allWidgets.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: allWidgets[index],
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildCard(HcGroup group, ContextualCard card) {
    switch (group.designType) {
      case 'HC3':
        return HC3Widget(
          id: card.id,
          height: group.height!,
          title: card.formattedTitle?.entities[0].text ?? '',
          description: card.formattedTitle?.entities[0].text ?? '',
          formatText: card.formattedTitle?.text ?? '',
          titleFontSize: card.formattedTitle?.entities[0].fontSize ?? 14,
          descriptionFontSize: card.formattedTitle?.entities[0].fontSize ?? 14,
          titleColor: card.formattedTitle?.entities[0].color,
          descriptionColor: card.formattedTitle?.entities[0].color,
          cta: card.cta != null && card.cta!.isNotEmpty ? card.cta![0] : null,
          bgImage: card.bgImage!,
          url: card.url,
        );
      case 'HC6':
        return HC6Widget(
          text: card.formattedTitle!.entities[0].text!,
          bgColor: card.bgColor!,
          height: group.height!,
          fontStyle: card.formattedTitle?.entities[0].fontStyle ?? '',
          fontFamily: card.formattedTitle?.entities[0].fontFamily ?? '',
          url: card.icon!.imageUrl,
          iconSize: card.iconSize!,
        );
      case 'HC5':
        return HC5Widget(
          bgImage: card.bgImage!.imageUrl,
        );
      case 'HC9':
        return HorizontalHC9Cards(
          cards: group.cards.map((card) => card.toJson()).toList(),
          height: group.height!,
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
