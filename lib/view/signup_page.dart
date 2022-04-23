import 'package:craft/components/color.dart';
import 'package:craft/components/font.dart';
import 'package:craft/components/primary_button.dart';
import 'package:craft/components/text_field_widget.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  GlobalKey<FormState> formName = GlobalKey<FormState>();
  GlobalKey<FormState> formEmail = GlobalKey<FormState>();
  GlobalKey<FormState> formPhone = GlobalKey<FormState>();
  GlobalKey<FormState> formPass = GlobalKey<FormState>();
  GlobalKey<FormState> formPass2 = GlobalKey<FormState>();
  bool ob = true;
  Icon iconpass = const Icon(
    Icons.visibility,
    color: Colors.white,
  );
  bool ob2 = true;
  Icon iconpass2 = const Icon(
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
                    Text(
                      "SIGNUP",
                      style: AppFonts.tajawal20WhiteW600,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFieldWidget(
                      formKey: formName,
                      controller: name,
                      labelText: "Name",
                      inputType: TextInputType.name,
                      ob: false,
                      prefixIcon: const Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      suffixIconButton: null,
                      type: "name",
                    ),
                    const SizedBox(
                      height: 10,
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
                      formKey: formPhone,
                      controller: phone,
                      labelText: "Phone",
                      inputType: TextInputType.phone,
                      ob: false,
                      prefixIcon: const Icon(
                        Icons.phone_android,
                        color: Colors.white,
                      ),
                      suffixIconButton: null,
                      type: "phone",
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
                      height: 10,
                    ),
                    TextFieldWidget(
                      formKey: formPass2,
                      controller: pass2,
                      labelText: "Confirem Password",
                      inputType: TextInputType.visiblePassword,
                      ob: ob2,
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: Colors.white,
                      ),
                      suffixIconButton: IconButton(
                        onPressed: () {
                          setState(() {
                            if (ob2 == true) {
                              ob2 = false;
                              iconpass2 = const Icon(Icons.visibility_off,
                                  color: Colors.white);
                            } else {
                              ob2 = true;
                              iconpass2 = const Icon(Icons.visibility,
                                  color: Colors.white);
                            }
                          });
                        },
                        icon: iconpass2,
                      ),
                      type: "pass",
                    ),
                  ],
                )),
            const SizedBox(
              height: 30,
            ),
            PrimaryButton(
              title: "SignUp",
              width: width * 0.8,
              backgroundcolor: AppColors.secondaryColor,
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
