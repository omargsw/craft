import 'dart:convert';

List<FetchRequestsToCustomer> fetchRequestsToCustomerFromJson(String str) =>
    List<FetchRequestsToCustomer>.from(
        json.decode(str).map((x) => FetchRequestsToCustomer.fromJson(x)));

String fetchRequestsToCustomerToJson(List<FetchRequestsToCustomer> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FetchRequestsToCustomer {
  FetchRequestsToCustomer({
    required this.id,
    required this.longitude,
    required this.latitude,
    required this.image,
    required this.descrption,
    required this.price,
    required this.status,
    required this.name,
    required this.phone,
    required this.handyManImage,
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
  final String handyManImage;

  factory FetchRequestsToCustomer.fromJson(Map<String, dynamic> json) =>
      FetchRequestsToCustomer(
        id: json["id"],
        longitude: json["longitude"].toDouble(),
        latitude: json["latitude"].toDouble(),
        image: json["image"],
        descrption: json["descrption"],
        price: json["price"],
        status: json["status"],
        name: json["name"],
        phone: json["phone"],
        handyManImage: json["HandyManImage"],
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
        "HandyManImage": handyManImage,
      };
}
