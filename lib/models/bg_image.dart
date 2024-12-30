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
