import 'dart:convert';

List<GetHandyMan> getHandyManFromJson(String str) => List<GetHandyMan>.from(
    json.decode(str).map((x) => GetHandyMan.fromJson(x)));

String getHandyManToJson(List<GetHandyMan> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetHandyMan {
  GetHandyMan({
    required this.id,
    required this.handyManName,
    required this.email,
    required this.phone,
    required this.image,
    required this.descrption,
    required this.categoryName,
  });

  final int id;
  final String handyManName;
  final String email;
  final String phone;
  final String image;
  final String descrption;
  final String categoryName;

  factory GetHandyMan.fromJson(Map<String, dynamic> json) => GetHandyMan(
        id: json["id"],
        handyManName: json["HandyManName"],
        email: json["email"],
        phone: json["phone"],
        image: json["image"],
        descrption: json["descrption"],
        categoryName: json["CategoryName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "HandyManName": handyManName,
        "email": email,
        "phone": phone,
        "image": image,
        "descrption": descrption,
        "CategoryName": categoryName,
      };
}
