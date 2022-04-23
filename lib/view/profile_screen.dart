import 'dart:io';
import 'package:craft/components/color.dart';
import 'package:craft/components/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  GlobalKey<FormState> form = GlobalKey<FormState>();
  var name = TextEditingController();
  var phone = TextEditingController();
  var email = TextEditingController();
  var pass = TextEditingController();
  var pass2 = TextEditingController();
  var pass3 = TextEditingController();
  bool ob = true, ob2 = true, ob3 = true;
  var confpass;
  Icon iconpass = Icon(Icons.visibility, color: AppColors.primaryColor);
  Icon iconpass2 = Icon(
    Icons.visibility,
    color: AppColors.primaryColor,
  );
  Icon iconpass3 = Icon(
    Icons.visibility,
    color: AppColors.primaryColor,
  );

  bool _load = false;
  File? imageFile;
  final imagePicker = ImagePicker();
  String status = '';
  String photo = '';
  String imagepath = '';

  void _showDoneSnackBar(BuildContext context, String text) {
    final snackBar = SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Icon(
            Icons.done_outline,
            size: 20,
            color: Colors.green,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 15, color: Colors.green),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.black45,
      duration: const Duration(seconds: 3),
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

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

  // Widget bottomSheet() {
  //   return Container(
  //     height: 100.0,
  //     width: MediaQuery.of(context).size.width,
  //     margin: const EdgeInsets.symmetric(
  //       horizontal: 20,
  //       vertical: 20,
  //     ),
  //     child: Column(
  //       children: <Widget>[
  //         const Text(
  //           "Choose profile image",
  //           style: TextStyle(
  //             fontSize: 20.0,
  //           ),
  //         ),
  //         const SizedBox(
  //           height: 3,
  //         ),
  //         Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
  //           FlatButton.icon(
  //             icon: const Icon(Icons.image),
  //             onPressed: () {
  //               chooseImage(ImageSource.gallery);
  //               Navigator.pop(context);
  //             },
  //             label: Text("gallery",style: TextStyle(),),
  //
  //           ),
  //         ])
  //       ],
  //     ),
  //   );
  // }

  @override
  void initState() {
    // typeId = sharedPreferences!.getInt('typeID');
    // print(typeId);
    super.initState();
  }

  // Future updateName(int id, var name) async {
  //   String url = 'https://abulsamrie11.000webhostapp.com/onTheGo/updatename.php';
  //   final response = await http.post(Uri.parse(url),
  //       body: {"id": id.toString(), "name": name});
  //
  //   print('UPDATE-NAME------>' + response.body);
  // }

  // Future updatePhone(int id, var phone) async {
  //   String url = 'https://abulsamrie11.000webhostapp.com/onTheGo/updatephone.php';
  //   final response = await http.post(Uri.parse(url),
  //       body: {"id": id.toString(), "phone": phone});
  //
  //   print('UPDATE-PHONE------>' + response.body);
  // }
  //
  // Future updatePassword(int id, var password) async {
  //   String url = 'https://abulsamrie11.000webhostapp.com/onTheGo/updatepassword.php';
  //   final response = await http.post(Uri.parse(url),
  //       body: {"id": id.toString(), "password": password});
  //
  //   print('UPDATE-PASSWORD------>' + response.body);
  // }
  // Future updateImage(int id, var image,var profileDecoded) async {
  //   String url = 'https://abulsamrie11.000webhostapp.com/onTheGo/updateimage.php';
  //   final response = await http.post(Uri.parse(url),
  //       body: {"id": id.toString(), "image": image,"profileDecoded": profileDecoded});
  //
  //   print('UPDATE-IMAGE------>' + response.body);
  // }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
        child: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            //UserInfoApi userApi = widget.user![index];
            // if(widget.user!.isEmpty || widget.user == null){
            //   return Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: const [
            //       CircularProgressIndicator(),
            //     ],
            //   );
            // }else{
            //   fname.text = userApi.name;
            //   phnum.text = userApi.phone;
            //   email.text = userApi.email;
            return Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: Center(
                    child: Stack(children: <Widget>[
                      imageFile == null
                          ? Container(
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
                              child: ClipOval(
                                child: Image.asset(
                                  'assets/images/logo.jpeg',
                                  width: 200,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          : Container(
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
                              child: CircleAvatar(
                                radius: 80.0,
                                backgroundImage:
                                    FileImage(File(imageFile!.path)),
                              ),
                            ),
                      Positioned(
                        bottom: 0.0,
                        right: 0.0,
                        child: Row(
                          children: [
                            imageFile == null
                                ? InkWell(
                                    onTap: () async {
                                      // showModalBottomSheet(
                                      //   context: context,
                                      //   builder: ((builder) => bottomSheet()),
                                      // );
                                    },
                                    child: const Icon(
                                      Icons.camera_alt,
                                      color: Colors.black,
                                      size: 30.0,
                                    ),
                                  )
                                : Row(
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          // showModalBottomSheet(
                                          //   context: context,
                                          //   builder: ((builder) => bottomSheet()),
                                          //
                                          // );
                                        },
                                        child: const Icon(
                                          Icons.camera_alt,
                                          color: Colors.white,
                                          size: 30.0,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: InkWell(
                                          onTap: () async {
                                            // if (imageFile == null ) return ;
                                            // photo = base64Encode(imageFile!.readAsBytesSync());
                                            // imagepath = imageFile!.path.split("/").last;
                                            // updateImage(id!, imagepath, photo);
                                            // imageCache!.clear();
                                          },
                                          child: const Icon(
                                            Icons.done,
                                            color:
                                                Color.fromARGB(250, 9, 85, 245),
                                            size: 30.0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                          ],
                        ),
                      ),
                    ]),
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Form(
                        key: form,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: [
                              // TextFieldWidget(hintText: "Name..",
                              //   prefixIcon: const Icon(Icons.person,color: Colors.black,),
                              //   controller: name,
                              //   suffixIconButton: null,
                              //   ob: false,
                              //   type: "name",
                              //   inputType: TextInputType.name,
                              // ),
                              // const SizedBox(height: 10,),
                              // TextFieldWidget(hintText: "Email..",
                              //   prefixIcon: const Icon(Icons.email,color: Colors.black,),
                              //   controller: email,
                              //   suffixIconButton: null,
                              //   ob: false,
                              //   type: "email",
                              //   inputType: TextInputType.emailAddress,
                              // ),
                              // const SizedBox(height: 10,),
                              // TextFieldWidget(hintText: "Phone number..",
                              //   prefixIcon: const Icon(Icons.phone_android,color: Colors.black,),
                              //   controller: phone,
                              //   suffixIconButton: null,
                              //   ob: false,
                              //   type: "phone",
                              //   inputType: TextInputType.phone,
                              // ),
                              // const SizedBox(height: 10,),
                              // TextFieldWidget(hintText: "Password..",
                              //   prefixIcon: const Icon(Icons.lock,color: Colors.black,),
                              //   controller: pass,
                              //   suffixIconButton: IconButton(
                              //     onPressed: () {
                              //       setState(() {
                              //         if (ob == true) {
                              //           ob = false;
                              //           iconpass = const Icon(Icons.visibility_off,color: Colors.black);
                              //         } else {
                              //           ob = true;
                              //           iconpass = const Icon(Icons.visibility,color: Colors.black);
                              //         }
                              //       });
                              //     },
                              //     icon: iconpass,
                              //   ),
                              //   ob: ob, type: "pass",
                              //   inputType: TextInputType.visiblePassword,
                              // ),
                              // const SizedBox(height: 10,),
                              // TextFieldWidget(hintText: "Confirm Password..",
                              //   prefixIcon: const Icon(Icons.lock,color: Colors.black,),
                              //   controller: pass2,
                              //   suffixIconButton: IconButton(
                              //     onPressed: () {
                              //       setState(() {
                              //         if (ob2 == true) {
                              //           ob2 = false;
                              //           iconpass2 = const Icon(Icons.visibility_off,color: Colors.black);
                              //         } else {
                              //           ob2 = true;
                              //           iconpass2 = const Icon(Icons.visibility,color: Colors.black);
                              //         }
                              //       });
                              //     },
                              //     icon: iconpass2,
                              //   ),
                              //   ob: ob2,
                              //   type: "pass",
                              //   inputType: TextInputType.visiblePassword,
                              // ),
                              const SizedBox(
                                height: 40,
                              ),
                              InkWell(
                                onTap: () {},
                                child: PrimaryButton(
                                  title: "SAVE",
                                  width: width * 0.7,
                                  backgroundcolor: AppColors.secondaryColor,
                                  height: 40,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ))
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
