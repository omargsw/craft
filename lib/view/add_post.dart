import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:craft/components/color.dart';
import 'package:craft/components/context.dart';
import 'package:craft/components/font.dart';
import 'package:craft/components/main_app_bar.dart';
import 'package:craft/components/primary_button.dart';
import 'package:craft/components/web_config.dart';
import 'package:craft/main.dart';
import 'package:craft/model/fetch_categories.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class AddPost extends StatefulWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  var userId = sharedPreferences!.getInt('userID');
  GlobalKey<FormState> form = GlobalKey<FormState>();
  TextEditingController desc = TextEditingController();
  bool _load = false;
  File? imageFile;
  final imagePicker = ImagePicker();
  String status = '';
  String imagebase64 = '';
  String imagepath = '';
  var selectedCategory;

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

  Future insertPost(var image, var imageEncoded, var customerid,
      var description, var categoryid) async {
    try {
      String url = WebConfig.baseUrl + WebConfig.apisPath + WebConfig.inserPost;
      final response = await http.post(Uri.parse(url), body: {
        "image": image,
        "image_encoded": imageEncoded,
        "customer_id": customerid,
        "description": description,
        "category_id": categoryid,
      });
      log(response.body);
    } catch (e) {
      log("[insertPost] $e");
    }
  }

  List<FetchCategory> category = [];
  Future fetshCategory() async {
    try {
      String url =
          WebConfig.baseUrl + WebConfig.apisPath + WebConfig.getCategory;
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<FetchCategory> categories =
            fetchCategoryFromJson(response.body);
        return categories;
      }
    } catch (e) {
      log("[FetshCategory] $e");
    }
  }

  @override
  void initState() {
    super.initState();
    fetshCategory().then((categories) {
      setState(() {
        category = categories;
      });
    });
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choose profile image",
            style: AppFonts.tajawal20BlackW600,
          ),
          const SizedBox(
            height: 3,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            TextButton.icon(
              icon: Icon(
                Icons.image,
                color: AppColors.primaryColor,
              ),
              onPressed: () {
                chooseImage(ImageSource.gallery);
                Navigator.pop(context);
              },
              label: Text(
                "Gallery",
                style: AppFonts.tajawal16PrimapryW600,
              ),
            ),
            TextButton.icon(
              icon: Icon(
                Icons.camera,
                color: AppColors.primaryColor,
              ),
              onPressed: () {
                chooseImage(ImageSource.camera);
                Navigator.pop(context);
              },
              label: Text("Camera", style: AppFonts.tajawal16PrimapryW600),
            ),
          ])
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: mainAppBar(title: "Add Post"),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: InkWell(
          onTap: () async {
            imagebase64 = base64Encode(imageFile!.readAsBytesSync());
            imagepath = imageFile!.path.split("/").last;
            if (form.currentState!.validate()) {
              if (selectedCategory != null) {
                if (imageFile != null) {
                  insertPost(imagepath, imagebase64, userId.toString(),
                      desc.text, selectedCategory.toString());
                  Contaxt().showDoneSnackBar(context, "Post added");
                  imageCache!.clear();
                } else {
                  Contaxt().showErrorSnackBar(context, "You must upload image");
                }
              } else {
                Contaxt()
                    .showErrorSnackBar(context, "You must select category");
              }
            }
          },
          child: PrimaryButton(
            title: "POST",
            width: MediaQuery.of(context).size.width * 0.8,
            backgroundcolor: AppColors.secondaryColor,
            height: 50,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Form(
              key: form,
              child: Container(
                padding: const EdgeInsets.all(20),
                child: TextFormField(
                  keyboardType: TextInputType.name,
                  maxLines: 5,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
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
                    return null;
                  },
                  controller: desc,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: AppColors.primaryColor, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                    child: DropdownButton<String>(
                        hint: Text(
                          "Select Category",
                          style: AppFonts.tajawal14PrimapryW600,
                        ),
                        isExpanded: true,
                        underline: Container(),
                        value: selectedCategory,
                        icon: Icon(
                          Icons.keyboard_arrow_down_outlined,
                          color: AppColors.primaryColor,
                        ),
                        elevation: 16,
                        style: AppFonts.tajawal16BlackW600,
                        onChanged: (newValue) {
                          setState(() {
                            selectedCategory = newValue;
                          });
                        },
                        items: category.map((category) {
                          return DropdownMenuItem(
                              value: category.id.toString(),
                              child: Text(
                                category.name,
                                style: AppFonts.tajawal14PrimapryW600,
                              ));
                        }).toList()),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextButton.icon(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: ((builder) => bottomSheet()),
                  );
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
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: Image.file(File(imageFile!.path))),
                  ),
          ],
        ),
      ),
    );
  }
}
