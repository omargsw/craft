import 'dart:convert';
import 'dart:developer';

import 'package:craft/components/color.dart';
import 'package:craft/components/context.dart';
import 'package:craft/components/font.dart';
import 'package:craft/components/primary_button.dart';
import 'package:craft/components/text_field_widget.dart';
import 'package:craft/components/web_config.dart';
import 'package:craft/view/nav_bar.dart';
import 'package:craft/view/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  final int typeId;
  const LoginPage({Key? key, required this.typeId}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> formEmail = GlobalKey<FormState>();
  GlobalKey<FormState> formPass = GlobalKey<FormState>();
  bool isLoading = false;
  bool ob = true;
  Icon iconpass = const Icon(
    Icons.visibility,
    color: Colors.white,
  );
  TextEditingController email = TextEditingController();
  TextEditingController pass1 = TextEditingController();

  Future userLoginIn(var email, var pass) async {
    setState(() {
      isLoading = true;
    });
    try {
      String url = WebConfig.baseUrl + WebConfig.apisPath + WebConfig.userLogin;
      final response = await http.post(Uri.parse(url), body: {
        "email": email.toString(),
        "password": pass,
      });
      var json = jsonDecode(response.body);
      if (json['error']) {
        Contaxt().showErrorSnackBar(context, "Invalid user name or password");
        setState(() {
          isLoading = false;
        });
      } else {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setInt('userID', json['user']['id']);
        sharedPreferences.setString('name', json['user']['name']);
        sharedPreferences.setString('email', json['user']['email']);
        sharedPreferences.setString('phone', json['user']['phone']);
        sharedPreferences.setString('image', json['user']['image']);
        sharedPreferences.setString('password', json['user']['password']);
        Get.to(NavBar(typeId: widget.typeId));
      }
      return true;
    } catch (e) {
      log("[userLoginIn] : $e");
    } finally {
      isLoading = false;
    }
  }

  Future handlyManLoginIn(var email, var pass) async {
    setState(() {
      isLoading = true;
    });
    try {
      String url =
          WebConfig.baseUrl + WebConfig.apisPath + WebConfig.handyManLogin;
      final response = await http.post(Uri.parse(url), body: {
        "email": email.toString(),
        "password": pass,
      });
      var json = jsonDecode(response.body);
      if (json['error']!) {
        Contaxt().showErrorSnackBar(context, "Invalid user name or password");
        setState(() {
          isLoading = false;
        });
      } else {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setInt('userID', json['user']['id']);
        sharedPreferences.setString('name', json['user']['name']);
        sharedPreferences.setString('email', json['user']['email']);
        sharedPreferences.setString('phone', json['user']['phone']);
        sharedPreferences.setString('image', json['user']['image']);
        sharedPreferences.setString('password', json['user']['password']);
        Get.to(NavBar(typeId: widget.typeId));
      }
      return true;
    } catch (e) {
      log("[handlyManLoginIn] : $e");
    } finally {
      isLoading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
                height: MediaQuery.of(context).size.height * 0.8,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(80),
                    // bottomLeft: Radius.circular(80),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 60,
                    ),
                    ClipOval(
                      child: Image.asset(
                        'assets/images/logo.jpeg',
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "LOGIN",
                      style: AppFonts.tajawal25WhiteW600,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFieldWidget(
                      formKey: formEmail,
                      controller: email,
                      labelText: "Email",
                      inputType: TextInputType.emailAddress,
                      ob: false,
                      prefixIcon: const Icon(
                        Icons.email,
                        color: Colors.white,
                      ),
                      suffixIconButton: null,
                      type: "email",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(
                      formKey: formPass,
                      controller: pass1,
                      labelText: "Password",
                      inputType: TextInputType.visiblePassword,
                      ob: ob,
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: Colors.white,
                      ),
                      suffixIconButton: IconButton(
                        onPressed: () {
                          setState(() {
                            if (ob == true) {
                              ob = false;
                              iconpass = const Icon(Icons.visibility_off,
                                  color: Colors.white);
                            } else {
                              ob = true;
                              iconpass = const Icon(Icons.visibility,
                                  color: Colors.white);
                            }
                          });
                        },
                        icon: iconpass,
                      ),
                      type: "pass",
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const SizedBox(
                            height: 0,
                          ),
                    const Spacer(),
                    (widget.typeId == 1)
                        ? InkWell(
                            onTap: () => Get.to(const SignUpPage()),
                            child: Center(
                              child: RichText(
                                text: TextSpan(
                                    text: "Don't have account?",
                                    style: AppFonts.tajawal16WhiteW600,
                                    children: [
                                      TextSpan(
                                        text: " Sign up",
                                        style: AppFonts
                                            .tajawal20BBlackW600Underline,
                                      )
                                    ]),
                              ),
                            ),
                          )
                        : Container(),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                )),
            const SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () async {
                SharedPreferences sharedPreferences =
                    await SharedPreferences.getInstance();
                sharedPreferences.setInt('typeID', widget.typeId);
                int? typeId = sharedPreferences.getInt('typeID');
                if (widget.typeId == 1) {
                  userLoginIn(email.text, pass1.text);
                } else {
                  handlyManLoginIn(email.text, pass1.text);
                }
              },
              child: PrimaryButton(
                title: "Login",
                width: width * 0.8,
                backgroundcolor: AppColors.secondaryColor,
                height: 50,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
