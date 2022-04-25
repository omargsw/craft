import 'dart:async';

import 'package:craft/components/color.dart';
import 'package:craft/components/primary_button.dart';
import 'package:craft/view/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool time = false;
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () => time = true,
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/tools.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: ClipOval(
                child: Image.asset(
                  'assets/images/logo.jpeg',
                  width: 250,
                  height: 250,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 180,
            ),
            InkWell(
              onTap: () => Get.to(const LoginPage(
                typeId: 1,
              )),
              child: PrimaryButton(
                  title: "Login as customer",
                  width: width * 0.8,
                  backgroundcolor: AppColors.secondaryColor,
                  height: 50),
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () => Get.to(const LoginPage(
                typeId: 2,
              )),
              child: PrimaryButton(
                  title: "Login as admin",
                  width: width * 0.8,
                  backgroundcolor: AppColors.secondaryColor,
                  height: 50),
            ),
          ],
        ),
      ),
    );
  }
}
