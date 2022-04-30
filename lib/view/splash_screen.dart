import 'dart:async';
import 'package:craft/components/color.dart';
import 'package:craft/components/primary_button.dart';
import 'package:craft/view/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool time = false;
var lat, long;
  late Position cl;

    Future getPer() async {
    bool services;
    LocationPermission per;
    services = await Geolocator.isLocationServiceEnabled();
    if (services == false) {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text(
                  "Services Not Enabled",
                  style: TextStyle(fontSize: 15, color: Colors.black),
                ),
                content: const Text(
                  'Open Your Location',
                  style: TextStyle(fontSize: 12, color: Colors.black45),
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Okay'),
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                  )
                ],
              ));
    }
    per = await Geolocator.checkPermission();
    if (per == LocationPermission.denied) {
      per == await Geolocator.requestPermission();
    } else {
      getLateAndLang();
    }
    return per;
  }

  Future<void> getLateAndLang() async {
    cl = await Geolocator.getCurrentPosition().then((value) => value);
    lat = cl.latitude;
    long = cl.longitude;
    setState(() {});
  }
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
                  title: "Login as Handy man",
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
