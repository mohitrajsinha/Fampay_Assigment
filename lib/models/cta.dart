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
