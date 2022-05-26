import 'dart:developer';
import 'dart:io';
import 'package:craft/components/color.dart';
import 'package:craft/components/context.dart';
import 'package:craft/components/font.dart';
import 'package:craft/components/main_app_bar.dart';
import 'package:craft/components/web_config.dart';
import 'package:craft/main.dart';
import 'package:craft/model/fetch_comment.dart';
import 'package:craft/model/fetch_handyman.dart';
import 'package:craft/model/fetch_post.dart';
import 'package:craft/view/add_post.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

class PostsPage extends StatefulWidget {
  final String? titlePage;
  final int? categoryId;
  const PostsPage({
    Key? key,
    required this.titlePage,
    required this.categoryId,
  }) : super(key: key);

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  int? userId = sharedPreferences!.getInt('userID');
  int? typeId = sharedPreferences!.getInt('typeID');
  GlobalKey<FormState> form = GlobalKey<FormState>();
  TextEditingController comment = TextEditingController();
  GlobalKey<FormState> formEdit = GlobalKey<FormState>();
  TextEditingController descEdit = TextEditingController();
  GlobalKey<FormState> formCommentEdit = GlobalKey<FormState>();
  TextEditingController commentEdit = TextEditingController();
  bool isLoading = false;
  bool _load = false;
  File? imageFile;
  final imagePicker = ImagePicker();
  String status = '';
  String photo = '';
  String imagepath = '';
  var lat, long;
  late Position cl;
  bool isSelect = false;

  Future chooseImage(ImageSource source) async {
    final pickedFile = await imagePicker.pickImage(source: source);
    setState(() {
      imageFile = File(pickedFile!.path);
      _load = false;
    });
  }

  setStatus(String message) {
    setState(() {
      status = message;
    });
  }

  Future getPer() async {
    bool services;
    LocationPermission per;
    services = await Geolocator.isLocationServiceEnabled();
    if (services == false) {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text(
                  "Services Not Enabled",
                  style: TextStyle(fontSize: 15, color: Colors.black),
                ),
                content: const Text(
                  'Open Your Location',
                  style: TextStyle(fontSize: 12, color: Colors.black45),
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Okay'),
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                  )
                ],
              ));
    }
    per = await Geolocator.checkPermission();
    if (per == LocationPermission.denied) {
      per == await Geolocator.requestPermission();
    } else {
      getLateAndLang();
    }
    return per;
  }

  Future<void> getLateAndLang() async {
    cl = await Geolocator.getCurrentPosition().then((value) => value);
    lat = cl.latitude;
    long = cl.longitude;
    setState(() {});
  }

  List<FetchPost> posts = [];
  Future fetchPost() async {
    isLoading = true;
    try {
      String url = WebConfig.baseUrl +
          WebConfig.apisPath +
          WebConfig.getPostByname +
          "?name=${widget.titlePage}";
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<FetchPost> postList = fetchPostFromJson(response.body);
        return postList;
      }
    } catch (e) {
      log("[FetshPost] $e");
    } finally {
      isLoading = false;
    }
  }

  List<GetHandyMan> handy = [];
  Future fetchHanyMan() async {
    isLoading = true;
    try {
      String url = WebConfig.baseUrl +
          WebConfig.apisPath +
          WebConfig.handyManCatgeory +
          "?name=${widget.titlePage}";
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<GetHandyMan> list = getHandyManFromJson(response.body);
        return list;
      }
    } catch (e) {
      log("[fetchHanyMan] $e");
    } finally {
      isLoading = false;
    }
  }

  List<FetchComment> comments = [];
  Future fetchComment(int postId) async {
    isLoading = true;
    try {
      String url = WebConfig.baseUrl +
          WebConfig.apisPath +
          WebConfig.getComments +
          "?post_id=$postId";
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<FetchComment> commentList =
            fetchCommentFromJson(response.body);
        return commentList;
      }
    } catch (e) {
      log("[fetchComment] $e");
    } finally {
      isLoading = false;
    }
  }

  Future insertComment(var postid, var customerid, var comment) async {
    try {
      String url =
          WebConfig.baseUrl + WebConfig.apisPath + WebConfig.inserComment;
      final response = await http.post(Uri.parse(url), body: {
        "post_id": postid,
        "customer_id": customerid,
        "comment": comment,
      });
      log(response.body);
    } catch (e) {
      log("[insertComment] $e");
    }
  }

  Future insertRequest(var customerid, var longitude, var latitude, var image,
      var descrption, var handyID) async {
    try {
      String url =
          WebConfig.baseUrl + WebConfig.apisPath + WebConfig.insertRequest;
      final response = await http.post(Uri.parse(url), body: {
        "customer_id": customerid,
        "longitude": longitude,
        "latitude": latitude,
        "image": image,
        "descrption": descrption,
        "handyID": handyID
      });
      log(response.body);
    } catch (e) {
      log("[insertRequest] $e");
    }
  }

  Future editPost(postid, description) async {
    String url = WebConfig.baseUrl + WebConfig.apisPath + WebConfig.editPost;
    final response = await http.post(Uri.parse(url),
        body: {"post_id": postid.toString(), "description": description});
    log('Edit Post ------>' + response.body);
  }

  Future deletePost(var id) async {
    String url = WebConfig.baseUrl +
        WebConfig.apisPath +
        WebConfig.deletePost +
        '?post_id=$id';
    final response = await http.get(Uri.parse(url));
    log(response.body);
  }

  Future editComment(commentid, comment) async {
    String url = WebConfig.baseUrl + WebConfig.apisPath + WebConfig.editComment;
    final response = await http.post(Uri.parse(url),
        body: {"comment_id": commentid.toString(), "comment": comment});
    log('Edit Comment ------>' + response.body);
  }

  Future deleteComment(var id) async {
    String url = WebConfig.baseUrl +
        WebConfig.apisPath +
        WebConfig.deleteComment +
        '?comment_id=$id';
    final response = await http.get(Uri.parse(url));
    log(response.body);
  }

  @override
  void initState() {
    super.initState();
    fetchPost().then((postList) {
      setState(() {
        posts = postList;
      });
    });
    fetchHanyMan().then((list) {
      setState(() {
        handy = list;
      });
    });
    getPer();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: mainAppBar(title: widget.titlePage),
      floatingActionButton: (typeId == 1)
          ? FloatingActionButton.extended(
              backgroundColor: AppColors.primaryColor,
              foregroundColor: Colors.black,
              onPressed: () {
                Get.to(const AddPost());
              },
              icon: const Icon(Icons.add),
              label: Text(
                'POST',
                style: AppFonts.tajawal16BlackW600,
              ),
            )
          : Container(),
      body: (isLoading)
          ? Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
              ),
            )
          : (posts.isEmpty)
              ? const Center(
                  child: Text(
                  "No Result",
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ))
              : ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    FetchPost postApi = posts[index];
                    return Card(
                      color: Colors.white38,
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            leading: ClipOval(
                              child: Image.network(
                                WebConfig.baseUrl +
                                    WebConfig.apisPath +
                                    '/customerImages/' +
                                    postApi.userImage,
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                            ),
                            title: Text(postApi.name),
                            subtitle: Text(
                              "${postApi.createdAt.day}-${postApi.createdAt.month}-${postApi.createdAt.year}",
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.6)),
                            ),
                            trailing: (postApi.userId == userId)
                                ? PopupMenuButton(
                                    icon: const Icon(
                                      Icons.more_vert,
                                      color: Colors.black,
                                    ),
                                    iconSize: 30,
                                    itemBuilder: (BuildContext context) =>
                                        <PopupMenuEntry>[
                                      PopupMenuItem(
                                        child: ListTile(
                                          title: Text(
                                            'Edit',
                                            style: AppFonts.tajawal14BlackW600,
                                          ),
                                          leading: const Icon(
                                            Icons.edit,
                                            color: Colors.blue,
                                          ),
                                          onTap: () {
                                            showDialog<String>(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    shape: const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    20.0))),
                                                    backgroundColor:
                                                        Colors.white,
                                                    content: Form(
                                                      key: formEdit,
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(20),
                                                        child: TextFormField(
                                                          keyboardType:
                                                              TextInputType
                                                                  .name,
                                                          maxLines: 5,
                                                          decoration:
                                                              InputDecoration(
                                                            contentPadding:
                                                                const EdgeInsets
                                                                        .fromLTRB(
                                                                    15,
                                                                    5,
                                                                    15,
                                                                    5),
                                                            hintText:
                                                                'Description',
                                                            hintStyle:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        10,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                            fillColor:
                                                                Colors.black12,
                                                            filled: true,
                                                            border:
                                                                OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                              borderSide:
                                                                  BorderSide
                                                                      .none,
                                                            ),
                                                          ),
                                                          validator: (value) {
                                                            if (value!
                                                                .isEmpty) {
                                                              return "Required";
                                                            }
                                                            return null;
                                                          },
                                                          controller: descEdit,
                                                        ),
                                                      ),
                                                    ),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        onPressed: () {
                                                          Get.back();
                                                        },
                                                        child: Text('Cancel',
                                                            style: TextStyle(
                                                              color: AppColors
                                                                  .primaryColor,
                                                            )),
                                                      ),
                                                      TextButton(
                                                        onPressed: () {
                                                          if (formEdit
                                                              .currentState!
                                                              .validate()) {
                                                            editPost(
                                                                postApi.postId,
                                                                descEdit.text);
                                                            fetchPost().then(
                                                                (postList) {
                                                              setState(() {
                                                                posts =
                                                                    postList;
                                                              });
                                                            });
                                                            descEdit.clear();
                                                            Get.back();
                                                          }
                                                        },
                                                        child: Text('Save',
                                                            style: TextStyle(
                                                              color: AppColors
                                                                  .primaryColor,
                                                            )),
                                                      ),
                                                    ],
                                                  );
                                                });
                                          },
                                        ),
                                      ),
                                      const PopupMenuDivider(),
                                      PopupMenuItem(
                                        child: ListTile(
                                          title: Text(
                                            'Delete',
                                            style: AppFonts.tajawal14BlackW600,
                                          ),
                                          leading: const Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                          onTap: () async {
                                            showDialog<String>(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    shape: const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    20.0))),
                                                    backgroundColor:
                                                        Colors.white,
                                                    content: Text(
                                                        'Are you sure to delete this post',
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                          color: AppColors
                                                              .primaryColor,
                                                        )),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        onPressed: () {
                                                          Get.back();
                                                        },
                                                        child: Text('Cancel',
                                                            style: TextStyle(
                                                              color: AppColors
                                                                  .primaryColor,
                                                            )),
                                                      ),
                                                      TextButton(
                                                        onPressed: () async {
                                                          await deletePost(
                                                              postApi.postId);
                                                          fetchPost()
                                                              .then((postList) {
                                                            setState(() {
                                                              posts = postList;
                                                            });
                                                          });
                                                          Get.back();
                                                        },
                                                        child: Text('Delete',
                                                            style: TextStyle(
                                                              color: AppColors
                                                                  .primaryColor,
                                                            )),
                                                      ),
                                                    ],
                                                  );
                                                });
                                          },
                                        ),
                                      ),
                                    ],
                                  )
                                : const SizedBox(
                                    height: 0,
                                  ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Text(
                              postApi.description,
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.6)),
                            ),
                          ),
                          Center(
                            child: Image.network(WebConfig.baseUrl +
                                WebConfig.apisPath +
                                '/postImages/' +
                                postApi.postImage),
                          ),
                          ButtonBar(
                            alignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton.icon(
                                onPressed: () async {
                                  await fetchComment(postApi.postId)
                                      .then((commentList) {
                                    setState(() {
                                      comments = commentList;
                                    });
                                  });
                                  showModelSheetComments(
                                      context, postApi.postId);
                                },
                                label: Text(
                                  'Comment',
                                  style: AppFonts.tajawal16PrimapryW600,
                                ),
                                icon: Icon(
                                  Icons.mode_comment_outlined,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                              (typeId == 1)
                                  ? (postApi.userId == userId)
                                      ? TextButton(
                                          onPressed: () {
                                            showModelSheetContactUs(
                                              context,
                                              postApi.name,
                                              postApi.phone,
                                              postApi.description,
                                              postApi.postImage,
                                            );
                                          },
                                          child: Text(
                                            'Connect with us',
                                            style:
                                                AppFonts.tajawal16PrimapryW600,
                                          ),
                                        )
                                      : Container()
                                  : Container(),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
    );
  }

  void showModelSheetComments(BuildContext context, int postId) {
    showMaterialModalBottomSheet(
        context: context,
        builder: (builder) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                height: MediaQuery.of(context).size.height * 0.8,
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 5,
                ),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 25),
                      child: ListView.builder(
                        itemCount: comments.length,
                        itemBuilder: (context, index) {
                          FetchComment commentApi = comments[index];
                          return Column(
                            children: [
                              ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 5,
                                ),
                                leading: CircleAvatar(
                                    radius: 23,
                                    backgroundImage: NetworkImage(
                                        WebConfig.baseUrl +
                                            WebConfig.apisPath +
                                            '/customerImages/' +
                                            commentApi.image)),
                                trailing: (commentApi.userid == userId)
                                    ? PopupMenuButton(
                                        icon: const Icon(
                                          Icons.more_vert,
                                          color: Colors.black,
                                        ),
                                        iconSize: 30,
                                        itemBuilder: (BuildContext context) =>
                                            <PopupMenuEntry>[
                                          PopupMenuItem(
                                            child: ListTile(
                                              title: Text(
                                                'Edit',
                                                style:
                                                    AppFonts.tajawal14BlackW600,
                                              ),
                                              leading: const Icon(
                                                Icons.edit,
                                                color: Colors.blue,
                                              ),
                                              onTap: () {
                                                showDialog<String>(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        shape: const RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius.circular(
                                                                        20.0))),
                                                        backgroundColor:
                                                            Colors.white,
                                                        content: Form(
                                                          key: formCommentEdit,
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(20),
                                                            child:
                                                                TextFormField(
                                                              keyboardType:
                                                                  TextInputType
                                                                      .name,
                                                              maxLines: 5,
                                                              decoration:
                                                                  InputDecoration(
                                                                contentPadding:
                                                                    const EdgeInsets
                                                                            .fromLTRB(
                                                                        15,
                                                                        5,
                                                                        15,
                                                                        5),
                                                                hintText:
                                                                    'Edit Comment',
                                                                hintStyle: const TextStyle(
                                                                    fontSize:
                                                                        10,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                                fillColor: Colors
                                                                    .black12,
                                                                filled: true,
                                                                border:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10.0),
                                                                  borderSide:
                                                                      BorderSide
                                                                          .none,
                                                                ),
                                                              ),
                                                              validator:
                                                                  (value) {
                                                                if (value!
                                                                    .isEmpty) {
                                                                  return "Required";
                                                                }
                                                                return null;
                                                              },
                                                              controller:
                                                                  commentEdit,
                                                            ),
                                                          ),
                                                        ),
                                                        actions: <Widget>[
                                                          TextButton(
                                                            onPressed: () {
                                                              Get.back();
                                                            },
                                                            child: Text(
                                                                'Cancel',
                                                                style:
                                                                    TextStyle(
                                                                  color: AppColors
                                                                      .primaryColor,
                                                                )),
                                                          ),
                                                          TextButton(
                                                            onPressed:
                                                                () async {
                                                              if (formCommentEdit
                                                                  .currentState!
                                                                  .validate()) {
                                                                editComment(
                                                                    commentApi
                                                                        .commentId,
                                                                    commentEdit
                                                                        .text);
                                                                await fetchComment(
                                                                        postId)
                                                                    .then(
                                                                        (commentList) {
                                                                  setState(() {
                                                                    comments =
                                                                        commentList;
                                                                  });
                                                                });
                                                                commentEdit
                                                                    .clear();
                                                                Get.back();
                                                              }
                                                            },
                                                            child: Text('Save',
                                                                style:
                                                                    TextStyle(
                                                                  color: AppColors
                                                                      .primaryColor,
                                                                )),
                                                          ),
                                                        ],
                                                      );
                                                    });
                                              },
                                            ),
                                          ),
                                          const PopupMenuDivider(),
                                          PopupMenuItem(
                                            child: ListTile(
                                              title: Text(
                                                'Delete',
                                                style:
                                                    AppFonts.tajawal14BlackW600,
                                              ),
                                              leading: const Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                              ),
                                              onTap: () {
                                                showDialog<String>(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        shape: const RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius.circular(
                                                                        20.0))),
                                                        backgroundColor:
                                                            Colors.white,
                                                        content: Text(
                                                            'Are you sure to delete this comment',
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: TextStyle(
                                                              color: AppColors
                                                                  .primaryColor,
                                                            )),
                                                        actions: <Widget>[
                                                          TextButton(
                                                            onPressed: () {
                                                              Get.back();
                                                            },
                                                            child: Text(
                                                                'Cancel',
                                                                style:
                                                                    TextStyle(
                                                                  color: AppColors
                                                                      .primaryColor,
                                                                )),
                                                          ),
                                                          TextButton(
                                                            onPressed:
                                                                () async {
                                                              await deleteComment(
                                                                  commentApi
                                                                      .commentId);
                                                              await fetchComment(
                                                                      postId)
                                                                  .then(
                                                                      (commentList) {
                                                                setState(() {
                                                                  comments =
                                                                      commentList;
                                                                });
                                                              });
                                                              Get.back();
                                                            },
                                                            child: Text(
                                                                'Delete',
                                                                style:
                                                                    TextStyle(
                                                                  color: AppColors
                                                                      .primaryColor,
                                                                )),
                                                          ),
                                                        ],
                                                      );
                                                    });
                                              },
                                            ),
                                          ),
                                        ],
                                      )
                                    : const SizedBox(
                                        height: 0,
                                      ),
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(commentApi.name,
                                        style: AppFonts.tajawal16BlackW600),
                                    const SizedBox(height: 4),
                                    Text(commentApi.comment,
                                        style: AppFonts.tajawal14Black45W400),
                                  ],
                                ),
                              ),
                              const Divider(
                                height: 20,
                                thickness: 0,
                                indent: 40,
                                endIndent: 40,
                                color: Colors.black,
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10),
                          ),
                        ),
                        child: Row(
                          children: [
                            Form(
                              key: form,
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                padding: const EdgeInsets.all(5),
                                child: TextFormField(
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(0),
                                    hintText: "comment",
                                    hintStyle: AppFonts.tajawal14BlackW600,
                                    fillColor: Colors.white,
                                    focusColor: Colors.white,
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide.none,
                                    ),
                                    prefixIcon: Icon(
                                      Icons.mode_comment_outlined,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Required";
                                    }
                                  },
                                  controller: comment,
                                ),
                              ),
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  )),
                              child: IconButton(
                                  onPressed: () async {
                                    await insertComment(postId.toString(),
                                        userId.toString(), comment.text);
                                    await fetchComment(postId)
                                        .then((commentList) {
                                      setState(() {
                                        comments = commentList;
                                      });
                                    });
                                    comment.clear();
                                  },
                                  icon: Icon(
                                    Icons.send,
                                    color: AppColors.primaryColor,
                                  )),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        });
  }

  var selecteditem = null;
  void showModelSheetContactUs(BuildContext context, String name, String phone,
      String desc, String image) {
    showMaterialModalBottomSheet(
        context: context,
        builder: (builder) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                height: MediaQuery.of(context).size.height * 0.65,
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 5,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        child: Text(
                          desc,
                          style:
                              TextStyle(color: Colors.black.withOpacity(0.6)),
                        ),
                      ),
                    ),
                    Center(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.35,
                        child: Image.network(WebConfig.baseUrl +
                            WebConfig.apisPath +
                            '/postImages/' +
                            image),
                      ),
                    ),
                    !isSelect
                        ? Container()
                        : const Text(
                            "*You must select the handyman*",
                            style: TextStyle(color: Colors.red, fontSize: 15),
                          ),
                    DecoratedBox(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.4),
                                  blurRadius: 20,
                                  offset: const Offset(1, 2))
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 10, bottom: 10),
                          child: DropdownButton<String>(
                            hint: Text(
                              "Select the Handyman",
                              style: AppFonts.tajawal14BlackW600,
                            ),
                            isExpanded: true,
                            underline: Container(),
                            value: selecteditem,
                            icon: const Icon(
                              Icons.keyboard_arrow_down_outlined,
                              color: Colors.black,
                            ),
                            elevation: 16,
                            style: AppFonts.tajawal14BlackW600,
                            onChanged: (newValue) {
                              setState(() {
                                selecteditem = newValue;
                              });
                            },
                            items: handy.map((info) {
                              return DropdownMenuItem(
                                value: info.id.toString(),
                                child: Container(
                                  height: 100,
                                  child: Row(
                                    children: [
                                      ClipOval(
                                        child: Image.network(
                                          'https://ogsw.000webhostapp.com/Sanay3i/customerImages/' +
                                              info.image.toString(),
                                          width: 45,
                                          height: 45,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(info.handyManName),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Text(info.phone),
                                            ],
                                          ),
                                          Text(info.descrption),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        )),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: FloatingActionButton.extended(
                        backgroundColor: AppColors.primaryColor,
                        foregroundColor: Colors.black,
                        onPressed: () async {
                          if (selecteditem == null) {
                            setState((() {
                              isSelect = true;
                            }));
                          } else {
                            setState((() {
                              isSelect = false;
                            }));
                            await insertRequest(
                              userId.toString(),
                              lat.toString(),
                              long.toString(),
                              image,
                              desc,
                              selecteditem.toString(),
                            );
                            Get.back();
                            Contaxt()
                                .showDoneSnackBar(context, "Send Successfully");
                          }
                        },
                        label: Row(
                          children: [
                            Text(
                              'Send to Handy man',
                              style: AppFonts.tajawal16BlackW600,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Icon(Icons.send),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        });
  }
}
