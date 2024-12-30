import 'bg_image.dart';
import 'cta.dart';
import 'formatted.dart';
import 'bg_gradient.dart';

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
