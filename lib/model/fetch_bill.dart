import 'dart:convert';

List<FetchBills> fetchBillsFromJson(String str) =>
    List<FetchBills>.from(json.decode(str).map((x) => FetchBills.fromJson(x)));

String fetchBillsToJson(List<FetchBills> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FetchBills {
  FetchBills({
    required this.billId,
    required this.fetchBillRequestId,
    required this.totalPrice,
    required this.billTitle,
    required this.billDescription,
    required this.requestId,
    required this.longitude,
    required this.latitude,
    required this.image,
    required this.requestDescription,
    required this.price,
    required this.status,
    required this.customerName,
    required this.customerPhone,
    required this.customerEmail,
    required this.handyManId,
    required this.handyManName,
    required this.handyManPhone,
  });

  final int billId;
  final int fetchBillRequestId;
  final int totalPrice;
  final String billTitle;
  final String billDescription;
  final int requestId;
  final double longitude;
  final double latitude;
  final String image;
  final String requestDescription;
  final String price;
  final String status;
  final String customerName;
  final String customerPhone;
  final String customerEmail;
  final int handyManId;
  final String handyManName;
  final String handyManPhone;

  factory FetchBills.fromJson(Map<String, dynamic> json) => FetchBills(
        billId: json["BillID"],
        fetchBillRequestId: json["request_id"],
        totalPrice: json["total_price"],
        billTitle: json["BillTitle"],
        billDescription: json["BillDescription"],
        requestId: json["RequestID"],
        longitude: json["longitude"].toDouble(),
        latitude: json["latitude"].toDouble(),
        image: json["image"],
        requestDescription: json["RequestDescription"],
        price: json["price"],
        status: json["status"],
        customerName: json["CustomerName"],
        customerPhone: json["CustomerPhone"],
        customerEmail: json["CustomerEmail"],
        handyManId: json["HandyManID"],
        handyManName: json["HandyManName"],
        handyManPhone: json["HandyManPhone"],
      );

  Map<String, dynamic> toJson() => {
        "BillID": billId,
        "request_id": fetchBillRequestId,
        "total_price": totalPrice,
        "BillTitle": billTitle,
        "BillDescription": billDescription,
        "RequestID": requestId,
        "longitude": longitude,
        "latitude": latitude,
        "image": image,
        "RequestDescription": requestDescription,
        "price": price,
        "status": status,
        "CustomerName": customerName,
        "CustomerPhone": customerPhone,
        "CustomerEmail": customerEmail,
        "HandyManID": handyManId,
        "HandyManName": handyManName,
        "HandyManPhone": handyManPhone,
      };
}
