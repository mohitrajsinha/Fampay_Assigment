import 'dart:convert';

List<ApiData> apiDataFromJson(String str) =>
    List<ApiData>.from(json.decode(str).map((x) => ApiData.fromJson(x)));

String apiDataToJson(List<ApiData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ApiData {
  int id;
  String slug;
  dynamic title;
  dynamic formattedTitle;
  dynamic description;
  dynamic formattedDescription;
  dynamic assets;
  List<HcGroup> hcGroups;

  ApiData({
    required this.id,
    required this.slug,
    required this.title,
    required this.formattedTitle,
    required this.description,
    required this.formattedDescription,
    required this.assets,
    required this.hcGroups,
  });

  factory ApiData.fromJson(Map<String, dynamic> json) => ApiData(
        id: json["id"] ?? 0,
        slug: json["slug"] ?? "",
        title: json["title"] ?? "",
        formattedTitle: json["formatted_title"] ?? "",
        description: json["description"] ?? "",
        formattedDescription: json["formatted_description"] ?? "",
        assets: json["assets"] ?? "",
        hcGroups: json["hc_groups"] != null
            ? List<HcGroup>.from(json["hc_groups"].map((x) => HcGroup.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "slug": slug,
        "title": title,
        "formatted_title": formattedTitle,
        "description": description,
        "formatted_description": formattedDescription,
        "assets": assets,
        "hc_groups": List<dynamic>.from(hcGroups.map((x) => x.toJson())),
      };
}

class HcGroup {
  int id;
  String name;
  String designType;
  int cardType;
  List<ContextualCard> cards;
  bool isScrollable;
  int? height;
  bool isFullWidth;
  String? slug;
  int level;

  HcGroup({
    required this.id,
    required this.name,
    required this.designType,
    required this.cardType,
    required this.cards,
    required this.isScrollable,
    this.height,
    required this.isFullWidth,
    this.slug,
    required this.level,
  });

  factory HcGroup.fromJson(Map<String, dynamic> json) => HcGroup(
        id: json["id"] ?? 0,
        name: json["name"] ?? "",
        designType: json["design_type"] ?? "",
        cardType: json["card_type"] ?? 0,
        cards: json["cards"] != null
            ? List<ContextualCard>.from(json["cards"].map((x) => ContextualCard.fromJson(x)))
            : [],
        isScrollable: json["is_scrollable"] ?? false,
        height: json["height"],
        isFullWidth: json["is_full_width"] ?? false,
        slug: json["slug"],
        level: json["level"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "design_type": designType,
        "card_type": cardType,
        "cards": List<dynamic>.from(cards.map((x) => x.toJson())),
        "is_scrollable": isScrollable,
        "height": height,
        "is_full_width": isFullWidth,
        "slug": slug,
        "level": level,
      };
}

class ContextualCard {
  int id;
  String name;
  String slug;
  String? title;
  Formatted? formattedTitle;
  List<dynamic> positionalImages;
  List<dynamic> components;
  String? url;
  BgImage? bgImage;
  List<Cta>? cta;
  bool isDisabled;
  bool isShareable;
  bool isInternal;
  BgImage? icon;
  String? bgColor;
  int? iconSize;
  BgGradient? bgGradient;
  String? description;
  Formatted? formattedDescription;

  ContextualCard({
    required this.id,
    required this.name,
    required this.slug,
    this.title,
    this.formattedTitle,
    required this.positionalImages,
    required this.components,
    this.url,
    this.bgImage,
    this.cta,
    required this.isDisabled,
    required this.isShareable,
    required this.isInternal,
    this.icon,
    this.bgColor,
    this.iconSize,
    this.bgGradient,
    this.description,
    this.formattedDescription,
  });

  factory ContextualCard.fromJson(Map<String, dynamic> json) => ContextualCard(
        id: json["id"] ?? 0,
        name: json["name"] ?? "",
        slug: json["slug"] ?? "",
        title: json["title"],
        formattedTitle: json["formatted_title"] == null
            ? null
            : Formatted.fromJson(json["formatted_title"]),
        positionalImages: json["positional_images"] != null
            ? List<dynamic>.from(json["positional_images"].map((x) => x))
            : [],
        components: json["components"] != null
            ? List<dynamic>.from(json["components"].map((x) => x))
            : [],
        url: json["url"],
        bgImage: json["bg_image"] == null
            ? null
            : BgImage.fromJson(json["bg_image"]),
        cta: json["cta"] != null
            ? List<Cta>.from(json["cta"].map((x) => Cta.fromJson(x)))
            : [],
        isDisabled: json["is_disabled"] ?? false,
        isShareable: json["is_shareable"] ?? false,
        isInternal: json["is_internal"] ?? false,
        icon: json["icon"] == null ? null : BgImage.fromJson(json["icon"]),
        bgColor: json["bg_color"],
        iconSize: json["icon_size"],
        bgGradient: json["bg_gradient"] == null
            ? null
            : BgGradient.fromJson(json["bg_gradient"]),
        description: json["description"],
        formattedDescription: json["formatted_description"] == null
            ? null
            : Formatted.fromJson(json["formatted_description"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "title": title,
        "formatted_title": formattedTitle?.toJson(),
        "positional_images": List<dynamic>.from(positionalImages.map((x) => x)),
        "components": List<dynamic>.from(components.map((x) => x)),
        "url": url,
        "bg_image": bgImage?.toJson(),
        "cta": cta != null ? List<dynamic>.from(cta!.map((x) => x.toJson())) : [],
        "is_disabled": isDisabled,
        "is_shareable": isShareable,
        "is_internal": isInternal,
        "icon": icon?.toJson(),
        "bg_color": bgColor,
        "icon_size": iconSize,
        "bg_gradient": bgGradient?.toJson(),
        "description": description,
        "formatted_description": formattedDescription?.toJson(),
      };
}

class BgGradient {
  int angle;
  List<String> colors;

  BgGradient({
    required this.angle,
    required this.colors,
  });

  factory BgGradient.fromJson(Map<String, dynamic> json) => BgGradient(
        angle: json["angle"] ?? 0,
        colors: json["colors"] != null
            ? List<String>.from(json["colors"].map((x) => x))
            : ['#000000'],
      );

  Map<String, dynamic> toJson() => {
        "angle": angle,
        "colors": List<dynamic>.from(colors.map((x) => x)),
      };
}

class BgImage {
  String imageType;
  String imageUrl;
  double aspectRatio;

  BgImage({
    required this.imageType,
    required this.imageUrl,
    required this.aspectRatio,
  });

  factory BgImage.fromJson(Map<String, dynamic> json) => BgImage(
        imageType: json["image_type"] ?? 'default',
        imageUrl: json["image_url"] ?? '',
        aspectRatio: json["aspect_ratio"]?.toDouble() ?? 1.0,
      );

  Map<String, dynamic> toJson() => {
        "image_type": imageType,
        "image_url": imageUrl,
        "aspect_ratio": aspectRatio,
      };
}

class Cta {
  String text;
  String type;
  String bgColor;
  bool isCircular;
  bool isSecondary;
  int strokeWidth;

  Cta({
    required this.text,
    required this.type,
    required this.bgColor,
    required this.isCircular,
    required this.isSecondary,
    required this.strokeWidth,
  });

  factory Cta.fromJson(Map<String, dynamic> json) => Cta(
        text: json["text"] ?? 'Default Text',
        type: json["type"] ?? 'default',
        bgColor: json["bg_color"] ?? '#FFFFFF',
        isCircular: json["is_circular"] ?? false,
        isSecondary: json["is_secondary"] ?? false,
        strokeWidth: json["stroke_width"] ?? 1,
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "type": type,
        "bg_color": bgColor,
        "is_circular": isCircular,
        "is_secondary": isSecondary,
        "stroke_width": strokeWidth,
      };
}

class Formatted {
  String text;
  String align;
  List<Entity> entities;

  Formatted({
    required this.text,
    required this.align,
    required this.entities,
  });

  factory Formatted.fromJson(Map<String, dynamic> json) => Formatted(
        text: json["text"] ?? '',
        align: json["align"] ?? 'left',
        entities: json["entities"] != null
            ? List<Entity>.from(json["entities"].map((x) => Entity.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "align": align,
        "entities": List<dynamic>.from(entities.map((x) => x.toJson())),
      };
}

class Entity {
  String? text;
  String type;
  String? color;
  String fontStyle;
  String fontFamily;
  int? fontSize;

  Entity({
    this.text,
    required this.type,
    this.color,
    required this.fontStyle,
    required this.fontFamily,
    this.fontSize,
  });

  factory Entity.fromJson(Map<String, dynamic> json) => Entity(
        text: json["text"] ?? '',
        type: json["type"] ?? 'text',
        color: json["color"] ?? '#000000',
        fontStyle: json["font_style"] ?? 'normal',
        fontFamily: json["font_family"] ?? 'Arial',
        fontSize: json["font_size"] ?? 14,
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "type": type,
        "color": color,
        "font_style": fontStyle,
        "font_family": fontFamily,
        "font_size": fontSize,
      };
}
