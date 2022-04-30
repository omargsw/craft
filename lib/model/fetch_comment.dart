import 'dart:convert';

List<FetchComment> fetchCommentFromJson(String str) => List<FetchComment>.from(
    json.decode(str).map((x) => FetchComment.fromJson(x)));

String fetchCommentToJson(List<FetchComment> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FetchComment {
  FetchComment({
    required this.commentId,
    required this.postId,
    required this.comment,
    required this.userid,
    required this.name,
    required this.image,
    required this.phone,
    required this.email,
  });

  final int commentId;
  final int postId;
  final String comment;
  final int userid;
  final String name;
  final String image;
  final String phone;
  final String email;

  factory FetchComment.fromJson(Map<String, dynamic> json) => FetchComment(
        commentId: json["CommentID"],
        postId: json["post_id"],
        comment: json["comment"],
        userid: json["userid"],
        name: json["name"],
        image: json["image"],
        phone: json["phone"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "CommentID": commentId,
        "post_id": postId,
        "comment": comment,
        "userid": userid,
        "name": name,
        "image": image,
        "phone": phone,
        "email": email,
      };
}
