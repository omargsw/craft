import 'dart:io';

import 'package:craft/components/color.dart';
import 'package:craft/components/font.dart';
import 'package:craft/components/main_app_bar.dart';
import 'package:craft/components/primary_button.dart';
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
  GlobalKey<FormState> form = GlobalKey<FormState>();
  TextEditingController desc = TextEditingController();
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

  void showModelSheet(BuildContext context) {
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
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
                            width: 75,
                          ),
                          Text(
                            "Add Post",
                            style: AppFonts.tajawal25PrimaryW600,
                          ),
                        ],
                      ),
                    ),
                    Form(
                      key: form,
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        child: TextFormField(
                          keyboardType: TextInputType.name,
                          maxLines: 5,
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.fromLTRB(15, 5, 15, 5),
                            hintText: 'Description',
                            hintStyle: const TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold),
                            fillColor: Colors.black12,
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Required";
                            }
                          },
                          controller: desc,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextButton.icon(
                        onPressed: () {
                          chooseImage(ImageSource.gallery);
                        },
                        label: Text(
                          'Add Image',
                          style: AppFonts.tajawal16PrimapryW600,
                        ),
                        icon: Icon(
                          Icons.add_photo_alternate_outlined,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                    imageFile == null
                        ? Container()
                        : Center(
                            child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(100.0)),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.4),
                                      offset: const Offset(4, 4),
                                      blurRadius: 16,
                                    ),
                                  ],
                                ),
                                child: Image.file(File(imageFile!.path))),
                          ),
                    const Spacer(),
                    Center(
                      child: PrimaryButton(
                        title: "POST",
                        width: MediaQuery.of(context).size.width * 0.8,
                        backgroundcolor: AppColors.primaryColor,
                        height: 50,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: mainAppBar(title: widget.titlePage),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.black,
        onPressed: () {
          // Get.to(const AddPost());
          showModelSheet(context);
        },
        icon: const Icon(Icons.add),
        label: Text(
          'POST',
          style: AppFonts.tajawal16BlackW600,
        ),
      ),
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
                        // Perform some action
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
                    TextButton(
                      onPressed: () {
                        // Perform some action
                      },
                      child: Text(
                        'Connect with us',
                        style: AppFonts.tajawal16PrimapryW600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
