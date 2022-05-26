import 'dart:convert';

List<FetchRequest> fetchRequestFromJson(String str) => List<FetchRequest>.from(
    json.decode(str).map((x) => FetchRequest.fromJson(x)));

String fetchRequestToJson(List<FetchRequest> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FetchRequest {
  FetchRequest({
    required this.id,
    required this.longitude,
    required this.latitude,
    required this.image,
    required this.descrption,
    required this.price,
    required this.status,
    required this.name,
    required this.phone,
    required this.customersImage,
  });

  final int id;
  final double longitude;
  final double latitude;
  final String image;
  final String descrption;
  final String price;
  final String status;
  final String name;
  final String phone;
  final String customersImage;

  factory FetchRequest.fromJson(Map<String, dynamic> json) => FetchRequest(
        id: json["id"],
        longitude: json["longitude"].toDouble(),
        latitude: json["latitude"].toDouble(),
        image: json["image"],
        descrption: json["descrption"],
        price: json["price"] == null ? "" : json["price"],
        status: json["status"],
        name: json["name"],
        phone: json["phone"],
        customersImage: json["customersImage"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "longitude": longitude,
        "latitude": latitude,
        "image": image,
        "descrption": descrption,
        "price": price,
        "status": status,
        "name": name,
        "phone": phone,
        "customersImage": customersImage,
      };
}
