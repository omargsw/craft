import 'dart:convert';

List<FetchPost> fetchPostFromJson(String str) =>
    List<FetchPost>.from(json.decode(str).map((x) => FetchPost.fromJson(x)));

String fetchPostToJson(List<FetchPost> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FetchPost {
  FetchPost({
    required this.postId,
    required this.postImage,
    required this.description,
    required this.createdAt,
    required this.userId,
    required this.name,
    required this.userImage,
    required this.phone,
    required this.email,
  });

  final int postId;
  final String postImage;
  final String description;
  final DateTime createdAt;
  final int userId;
  final String name;
  final String userImage;
  final String phone;
  final String email;

  factory FetchPost.fromJson(Map<String, dynamic> json) => FetchPost(
        postId: json["PostId"],
        postImage: json["PostImage"],
        description: json["description"],
        createdAt: DateTime.parse(json["created_at"]),
        userId: json["UserId"],
        name: json["name"],
        userImage: json["UserImage"],
        phone: json["phone"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "PostId": postId,
        "PostImage": postImage,
        "description": description,
        "created_at": createdAt.toIso8601String(),
        "UserId": userId,
        "name": name,
        "UserImage": userImage,
        "phone": phone,
        "email": email,
      };
}
