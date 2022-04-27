import 'dart:io';

import 'package:craft/components/color.dart';
import 'package:craft/components/font.dart';
import 'package:craft/components/main_app_bar.dart';
import 'package:craft/components/primary_button.dart';
import 'package:craft/main.dart';
import 'package:craft/view/add_post.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class PostsPage extends StatefulWidget {
  final String? titlePage;
  const PostsPage({Key? key, required this.titlePage}) : super(key: key);

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  int? typeId = sharedPreferences!.getInt('typeID');
  GlobalKey<FormState> form = GlobalKey<FormState>();
  TextEditingController comment = TextEditingController();
  bool _load = false;
  File? imageFile;
  final imagePicker = ImagePicker();
  String status = '';
  String photo = '';
  String imagepath = '';

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
      body: ListView.builder(
        itemCount: 2,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.white38,
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                ListTile(
                  leading: ClipOval(
                    child: Image.asset(
                      'assets/images/nouserimage.jpg',
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: const Text('Name'),
                  subtitle: Text(
                    '23/4/2022',
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Greyhound divisively hello coldly wonderfully marginally far upon excluding.',
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                ),
                Image.asset('assets/images/nouserimage.jpg'),
                ButtonBar(
                  alignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton.icon(
                      onPressed: () {
                        showModelSheetCooments(context);
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
                        ? TextButton(
                            onPressed: () {
                              showModelSheetContactUs(
                                context,
                                'name',
                                '56654654',
                                'Greyhound divisively hello coldly wonderfully marginally far upon excluding.',
                                'assets/images/nouserimage.jpg',
                              );
                            },
                            child: Text(
                              'Connect with us',
                              style: AppFonts.tajawal16PrimapryW600,
                            ),
                          )
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

  void showModelSheetCooments(BuildContext context) {
    showMaterialModalBottomSheet(
        context: context,
        builder: (builder) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setModelState) {
              return Container(
                height: MediaQuery.of(context).size.height * 0.8,
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 5,
                ),
                child: Stack(
                  children: [
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconButton(
                              onPressed: () {
                                Get.back();
                              },
                              icon: const Icon(
                                Icons.cancel_outlined,
                                size: 30,
                              ),
                            ),
                            const SizedBox(
                              width: 60,
                            ),
                            Text(
                              "Comments",
                              style: AppFonts.tajawal25PrimaryW600,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: ListView.builder(
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 5,
                                ),
                                leading: const CircleAvatar(
                                    radius: 23,
                                    backgroundImage: AssetImage(
                                        "assets/images/nouserimage.jpg")),
                                trailing: PopupMenuButton(
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
                                        onTap: () {},
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
                                        onTap: () {},
                                      ),
                                    ),
                                  ],
                                ),
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("name",
                                        style: AppFonts.tajawal16BlackW600),
                                    const SizedBox(height: 4),
                                    Text("description",
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
                      alignment: Alignment.bottomCenter,
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
                                  onPressed: () async {},
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

  void showModelSheetContactUs(BuildContext context, String name, String phone,
      String desc, String image) {
    showMaterialModalBottomSheet(
        context: context,
        builder: (builder) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setModelState) {
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
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.4,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(100.0)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.4),
                              offset: const Offset(4, 4),
                              blurRadius: 16,
                            ),
                          ],
                        ),
                        child: Image.asset(image),
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: FloatingActionButton.extended(
                        backgroundColor: AppColors.primaryColor,
                        foregroundColor: Colors.black,
                        onPressed: () {
                          Get.to(const AddPost());
                        },
                        label: Row(
                          children: [
                            Text(
                              'Send to admin',
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
