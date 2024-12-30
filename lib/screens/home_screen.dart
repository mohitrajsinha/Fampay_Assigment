import 'package:flutter/material.dart';
import 'package:fampay_assignment/widgets/hc1_widget.dart';
import 'package:fampay_assignment/widgets/hc3_widget.dart';
import 'package:fampay_assignment/widgets/hc5_widget.dart';
import 'package:fampay_assignment/widgets/hc6_widget.dart';
import 'package:fampay_assignment/widgets/hc9_widget.dart';
import '../models/models.dart';
import '../utils/api_service.dart';

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
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {
          _futureCards = ApiService.fetchCards();
        });
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Image.asset('assets/fampaylogo.png', height: 30),
          centerTitle: true,
        ),
        body: FutureBuilder<List<ApiData>>(
          future: _futureCards,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Failed to load cards.'),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _futureCards = ApiService.fetchCards();
                        });
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No cards available.'));
            }

            final cards = snapshot.data!;
            return _buildCardList(cards);
          },
        ),
      ),
    );
  }

  Widget _buildCardList(List<ApiData> cards) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: cards.length,
      itemBuilder: (context, index) {
        final groupWidgets = _buildGroupWidgets(cards[index]);
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: groupWidgets,
          ),
        );
      },
    );
  }

  List<Widget> _buildGroupWidgets(ApiData apiData) {
    return apiData.hcGroups.map((group) {
      final card = group.cards.isNotEmpty ? group.cards[0] : null;
      if (card != null) {
        return _buildCard(group, card);
      }
      return const SizedBox.shrink();
    }).toList();
  }

  Widget _buildCard(HcGroup group, ContextualCard card) {
    switch (group.designType) {
      case 'HC3':
        return _buildHC3Card(group, card);
      case 'HC6':
        return _buildHC6Card(group, card);
      case 'HC5':
        return _buildHC5Card(card);
      case 'HC9':
        return _buildHC9Card(group);
      case 'HC1':
        return _buildHC1Card(group, card);
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildHC3Card(HcGroup group, ContextualCard card) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: HC3Widget(
        id: card.id,
        height: group.height!,
        title: card.formattedTitle?.entities[0].text ?? '',
        description: card.formattedTitle?.entities[1].text ?? '',
        formatText: card.formattedTitle?.text ?? '',
        titleFontSize: card.formattedTitle?.entities[0].fontSize ?? 14,
        descriptionFontSize: card.formattedTitle?.entities[1].fontSize ?? 16,
        titleColor: card.formattedTitle?.entities[0].color,
        descriptionColor: card.formattedTitle?.entities[1].color,
        cta: card.cta?.isNotEmpty == true ? card.cta![0] : null,
        bgImage: card.bgImage!,
        url: card.url,
        titleFontFamily: card.formattedTitle?.entities[0].fontFamily ?? '',
        descriptionFontFamily:
            card.formattedTitle?.entities[1].fontFamily ?? '',
        titleFontStyle: card.formattedTitle?.entities[0].fontStyle ?? '',
        descriptionFontStyle: card.formattedTitle?.entities[1].fontStyle ?? '',
      ),
    );
  }

  Widget _buildHC6Card(HcGroup group, ContextualCard card) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
      child: HC6Widget(
        text: card.formattedTitle!.entities[0].text!,
        bgColor: card.bgColor!,
        height: group.height!,
        fontStyle: card.formattedTitle?.entities[0].fontStyle ?? '',
        fontFamily: card.formattedTitle?.entities[0].fontFamily ?? '',
        url: card.icon!.imageUrl,
        iconSize: card.iconSize!,
      ),
    );
  }

  Widget _buildHC5Card(ContextualCard card) {
    return HC5Widget(
      bgImage: card.bgImage!.imageUrl,
    );
  }

  Widget _buildHC9Card(HcGroup group) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      height: group.height!.toDouble(),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: group.cards.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: HC9Card(
              imageUrl: group.cards[index].bgImage!.imageUrl,
              aspectRatio: group.cards[index].bgImage!.aspectRatio,
              hexGradientColors: group.cards[index].bgGradient!.colors,
              angle: group.cards[index].bgGradient!.angle,
              height: group.height!,
            ),
          );
        },
      ),
    );
  }

  Widget _buildHC1Card(HcGroup group, ContextualCard card) {
    return HC1Widget(
      height: group.height!,
      bgColor: card.bgColor!,
      cards: group.cards,
      isScrollable:
          group.isScrollable, 
    );
  }
}
