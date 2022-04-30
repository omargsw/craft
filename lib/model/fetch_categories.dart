import 'dart:convert';

List<FetchCategory> fetchCategoryFromJson(String str) =>
    List<FetchCategory>.from(
        json.decode(str).map((x) => FetchCategory.fromJson(x)));

String fetchCategoryToJson(List<FetchCategory> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FetchCategory {
  FetchCategory({
    required this.id,
    required this.name,
    required this.image,
  });

  final int id;
  final String name;
  final String image;

  factory FetchCategory.fromJson(Map<String, dynamic> json) => FetchCategory(
        id: json["id"],
        name: json["name"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
      };
}
