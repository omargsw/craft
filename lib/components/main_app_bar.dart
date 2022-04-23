import 'package:craft/components/color.dart';
import 'package:craft/components/font.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//This should be a functional widget since that the appBar parameter
//in scaffold only accepts it as a function.
AppBar mainAppBar({required String? title}) {
  return AppBar(
    centerTitle: true,
    elevation: 0,
    leading: Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: IconButton(
        onPressed: () => Get.back(),
        icon: const Icon(
          Icons.arrow_back_ios_rounded,
          color: Colors.black,
          size: 25,
        ),
      ),
    ),
    title: Text(
      title!,
      style: AppFonts.tajawal25BlackW600,
      textAlign: TextAlign.center,
      textDirection: TextDirection.rtl,
    ),
    backgroundColor: AppColors.primaryColor,
  );
}
