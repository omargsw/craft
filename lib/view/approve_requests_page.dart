import 'dart:convert';
import 'dart:developer';

import 'package:craft/components/font.dart';
import 'package:craft/components/main_app_bar.dart';
import 'package:craft/components/text_field_withColor.dart';
import 'package:craft/components/web_config.dart';
import 'package:craft/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApproveRequestsPage extends StatefulWidget {
  final String? name;
  final String? profileImage;
  final String? phoneNumber;
  final String? desc;
  final String? image;
  final int? requestid;
  final lat;
  final long;
  const ApproveRequestsPage({
    Key? key,
    required this.name,
    required this.profileImage,
    required this.desc,
    required this.image,
    required this.phoneNumber,
    this.lat,
    this.long,
    required this.requestid,
  }) : super(key: key);

  @override
  State<ApproveRequestsPage> createState() => _ApproveRequestsPageState();
}

class _ApproveRequestsPageState extends State<ApproveRequestsPage> {
  int? userId = sharedPreferences!.getInt('userID');
  GlobalKey<FormState> formPrice = GlobalKey<FormState>();
  TextEditingController priceController = TextEditingController();
  bool isApprove = false;

  Future updateupdateRequestForWho(
      var requestid, var handyManid, var price) async {
    try {
      String url = WebConfig.baseUrl +
          WebConfig.apisPath +
          WebConfig.updateRequestForWho;
      final response = await http.post(Uri.parse(url), body: {
        "request_id": requestid,
        "handy_man_id": handyManid,
        "price": price,
      });
      var json = jsonDecode(response.body);
      if (json['error']) {
        return;
      } else {
        insertBill(requestid, price, "test", "test test test");
      }
      log(response.body);
    } catch (e) {
      log("[updateRequestForWho] $e");
    }
  }

  Future insertBill(
      var requestid, var totalprice, var title, var description) async {
    try {
      String url =
          WebConfig.baseUrl + WebConfig.apisPath + WebConfig.insertBill;
      final response = await http.post(Uri.parse(url), body: {
        "request_id": requestid,
        "total_price": totalprice,
        "title": title,
        "description": description,
      });
      log(response.body);
    } catch (e) {
      log("[insertBill] $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: mainAppBar(title: "Request Details"),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 10),
              child: ListTile(
                title: Text(
                  widget.name!,
                  style: AppFonts.tajawal20BlackW600,
                ),
                subtitle: Text(
                  widget.phoneNumber!,
                  style: AppFonts.tajawal14Black45W400,
                ),
                leading: const CircleAvatar(
                    radius: 28,
                    backgroundImage:
                        AssetImage("assets/images/nouserimage.jpg")),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Text(
                widget.desc!,
                style: AppFonts.tajawal14BlackW600,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.4,
              child: Image.network(WebConfig.baseUrl +
                  WebConfig.apisPath +
                  '/postImages/' +
                  widget.image!),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFieldWithColorWidget(
              formKey: formPrice,
              controller: priceController,
              labelText: "Price",
              inputType: TextInputType.phone,
              ob: false,
              prefixIcon: null,
              suffixIconButton: null,
              type: "name",
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: FloatingActionButton.extended(
                backgroundColor: Colors.green,
                foregroundColor: Colors.black,
                onPressed: () {
                  print(widget.requestid.toString());
                  print(userId.toString());
                  print(priceController.text);
                  if (formPrice.currentState!.validate()) {
                    updateupdateRequestForWho(widget.requestid.toString(),
                        userId.toString(), priceController.text);
                  }
                },
                label: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Text(
                    'SEND',
                    style: AppFonts.tajawal16BlackW600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
