import 'package:craft/components/main_app_bar.dart';
import 'package:flutter/material.dart';

class AddPost extends StatefulWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  GlobalKey<FormState> form = GlobalKey<FormState>();
  TextEditingController desc = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white24,
      appBar: mainAppBar(title: "Add Post"),
      body: Column(
        children: [
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
                  fillColor: Colors.white24,
                  focusColor: Colors.white24,
                  hoverColor: Colors.white24,
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
        ],
      ),
    );
  }
}
