class BlogDataModel {
  final String id;
  final String imageUrl;
  final String title;

  BlogDataModel({
    required this.id,
    required this.imageUrl,
    required this.title,
  });

  factory BlogDataModel.fromJson(Map<String, dynamic> json) => BlogDataModel(
        id: json["id"],
        imageUrl: json["image_url"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image_url": imageUrl,
        "title": title,
      };
}
