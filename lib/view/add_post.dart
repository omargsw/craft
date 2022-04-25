import 'dart:io';

import 'package:craft/components/color.dart';
import 'package:craft/components/font.dart';
import 'package:craft/components/main_app_bar.dart';
import 'package:craft/components/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddPost extends StatefulWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
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
      body: Column(
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
                },
                controller: desc,
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
                      child: Image.file(File(imageFile!.path))),
                ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Center(
              child: PrimaryButton(
                title: "POST",
                width: MediaQuery.of(context).size.width * 0.8,
                backgroundcolor: AppColors.secondaryColor,
                height: 50,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
