import 'dart:developer';
import 'package:craft/components/color.dart';
import 'package:craft/components/context.dart';
import 'package:craft/components/font.dart';
import 'package:craft/components/main_app_bar.dart';
import 'package:craft/components/primary_button.dart';
import 'package:craft/components/text_field_withColor.dart';
import 'package:craft/components/web_config.dart';
import 'package:craft/view/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class LocationAndBillPage extends StatefulWidget {
  final double lat;
  final double long;
  final int requestId;
  final String price;
  const LocationAndBillPage({
    Key? key,
    required this.lat,
    required this.long,
    required this.requestId,
    required this.price,
  }) : super(key: key);

  @override
  State<LocationAndBillPage> createState() => _LocationAndBillPageState();
}

class _LocationAndBillPageState extends State<LocationAndBillPage> {
  bool isClickOngoogle = false;
  bool isArrived = false;
  GlobalKey<FormState> formtitle = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  GlobalKey<FormState> formdesc = GlobalKey<FormState>();
  TextEditingController descController = TextEditingController();

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
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: mainAppBar(title: "View Details"),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isClickOngoogle
              ? isArrived
                  ? Column(
                      children: [
                        Center(
                          child: Text(
                            "Add a bill",
                            style: AppFonts.tajawal20BlackW600,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: InkWell(
                            onTap: () async {
                              showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20.0))),
                                      backgroundColor: Colors.white,
                                      content: SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.5,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              //Explain what the problem is and how to solve it
                                              Center(
                                                child: Text(
                                                  "Explain what the problem is and how to solve it",
                                                  style: AppFonts
                                                      .tajawal16Black45W400,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              TextFieldWithColorWidget(
                                                formKey: formtitle,
                                                controller: titleController,
                                                labelText: "Title",
                                                inputType: TextInputType.text,
                                                ob: false,
                                                prefixIcon: null,
                                                suffixIconButton: null,
                                                type: "name",
                                              ),
                                              TextFieldWithColorWidget(
                                                formKey: formdesc,
                                                controller: descController,
                                                labelText: "Description",
                                                inputType: TextInputType.text,
                                                ob: false,
                                                prefixIcon: null,
                                                suffixIconButton: null,
                                                type: "name",
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 20),
                                                child: InkWell(
                                                  onTap: () async {
                                                    if (formtitle.currentState!
                                                            .validate() &&
                                                        formdesc.currentState!
                                                            .validate()) {
                                                      insertBill(
                                                        widget.requestId
                                                            .toString(),
                                                        widget.price,
                                                        titleController.text,
                                                        descController.text,
                                                      );
                                                      Contaxt().showDoneSnackBar(
                                                          context,
                                                          "Send Request Successfully");
                                                      Get.back();
                                                      Get.offAll(const NavBar(
                                                          typeId: 2));
                                                    }
                                                  },
                                                  child: PrimaryButton(
                                                    title: "SEND",
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.7,
                                                    backgroundcolor: AppColors
                                                        .secondaryColor,
                                                    height: 50,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )),
                                    );
                                  });
                              // insertBill(
                              //     requestid, price, "test", "test test test");
                            },
                            child: PrimaryButton(
                              title: "Add Bill",
                              width: width * 0.8,
                              backgroundcolor: AppColors.secondaryColor,
                              height: 50,
                            ),
                          ),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        Center(
                          child: Text(
                            "When you arrived the location \n click I'am Arrived",
                            style: AppFonts.tajawal20BlackW600,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: InkWell(
                            onTap: () async {
                              setState(() {
                                isArrived = true;
                              });
                            },
                            child: PrimaryButton(
                                title: "I'am Arrived",
                                width: width * 0.8,
                                backgroundcolor: AppColors.secondaryColor,
                                height: 50),
                          ),
                        ),
                      ],
                    )
              : Column(
                  children: [
                    Center(
                      child: Text(
                        "Click this button to go to \n the person's location",
                        style: AppFonts.tajawal20BlackW600,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () async {
                        setState(() {
                          isClickOngoogle = true;
                        });
                        var uri = Uri.parse(
                            "https://maps.google.com/?q=${widget.lat},${widget.long}&mode=d%22");
                        if (await canLaunch(uri.toString())) {
                          await launch(uri.toString());
                        } else {
                          throw 'Could not launch ${uri.toString()}';
                        }
                      },
                      child: PrimaryButton(
                          title: "Go to the google maps",
                          width: width * 0.8,
                          backgroundcolor: AppColors.secondaryColor,
                          height: 50),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
