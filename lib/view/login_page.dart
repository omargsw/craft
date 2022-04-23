import 'package:craft/components/color.dart';
import 'package:craft/components/font.dart';
import 'package:craft/components/primary_button.dart';
import 'package:craft/components/text_field_widget.dart';
import 'package:craft/view/nav_bar.dart';
import 'package:craft/view/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> formName = GlobalKey<FormState>();
  GlobalKey<FormState> formEmail = GlobalKey<FormState>();
  GlobalKey<FormState> formPhone = GlobalKey<FormState>();
  GlobalKey<FormState> formPass = GlobalKey<FormState>();
  bool ob = true;
  Icon iconpass = const Icon(
    Icons.visibility,
    color: Colors.white,
  );
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController pass1 = TextEditingController();
  TextEditingController pass2 = TextEditingController();
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
                      style: AppFonts.tajawal20WhiteW600,
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
                    const Spacer(),
                    InkWell(
                      onTap: () => Get.to(const SignUpPage()),
                      child: Center(
                        child: RichText(
                          text: TextSpan(
                              text: "Don't have account?",
                              style: AppFonts.tajawal16WhiteW600,
                              children: [
                                TextSpan(
                                  text: " Sign up",
                                  style: AppFonts.tajawal20BBlackW600Underline,
                                )
                              ]),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                )),
            const SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: (() => Get.to(const NavBar(typeId: 1))),
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
