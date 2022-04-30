import 'dart:convert';

List<FetchRequests> fetchRequestsFromJson(String str) =>
    List<FetchRequests>.from(
        json.decode(str).map((x) => FetchRequests.fromJson(x)));

String fetchRequestsToJson(List<FetchRequests> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FetchRequests {
  FetchRequests({
    required this.id,
    required this.longitude,
    required this.latitude,
    required this.image,
    required this.descrption,
    required this.price,
    required this.status,
    required this.name,
    required this.phone,
  });

  final int id;
  final double longitude;
  final double latitude;
  final String image;
  final String descrption;
  final dynamic price;
  final String status;
  final String name;
  final String phone;

  factory FetchRequests.fromJson(Map<String, dynamic> json) => FetchRequests(
        id: json["id"],
        longitude: json["longitude"].toDouble(),
        latitude: json["latitude"].toDouble(),
        image: json["image"],
        descrption: json["descrption"],
        price: json["price"],
        status: json["status"],
        name: json["name"],
        phone: json["phone"],
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
      };
}
