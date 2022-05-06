import 'package:craft/components/color.dart';
import 'package:craft/components/font.dart';
import 'package:craft/components/primary_button.dart';
import 'package:flutter/material.dart';

class BillsPage extends StatefulWidget {
  const BillsPage({Key? key}) : super(key: key);

  @override
  State<BillsPage> createState() => _BillsPageState();
}

class _BillsPageState extends State<BillsPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView.builder(
        itemCount: 2,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Container(
                  height: 300,
                  width: width * 0.9,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                    color: AppColors.secondaryColor,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.8),
                        offset: const Offset(4, 4),
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          "Handy man details",
                          style: AppFonts.tajawal20PrimaryW600,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "Name : ",
                            style: AppFonts.tajawal16WhiteW600,
                          ),
                          Text(
                            "OGSW",
                            style: AppFonts.tajawal16BlackW600,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Phone number : ",
                            style: AppFonts.tajawal16WhiteW600,
                          ),
                          Text(
                            "0781212121",
                            style: AppFonts.tajawal16BlackW600,
                          ),
                        ],
                      ),
                      const Divider(
                        height: 20,
                        thickness: 0,
                        indent: 20,
                        endIndent: 20,
                        color: Colors.black,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Description",
                              style: AppFonts.tajawal16WhiteW600,
                            ),
                            Text(
                              "Price",
                              style: AppFonts.tajawal16WhiteW600,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: width * 0.5,
                              child: Text(
                                "asdasda asdasd asdasd asdasda asd",
                                style: AppFonts.tajawal16BlackW600,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  "20",
                                  style: AppFonts.tajawal16BlackW600,
                                ),
                                Text(
                                  " JOD",
                                  style: AppFonts.tajawal16PrimapryW600,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      const Divider(
                        height: 20,
                        thickness: 0,
                        indent: 20,
                        endIndent: 20,
                        color: Colors.black,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Total : ",
                              style: AppFonts.tajawal16WhiteW600,
                            ),
                            Row(
                              children: [
                                Text(
                                  "20",
                                  style: AppFonts.tajawal16BlackW600,
                                ),
                                Text(
                                  " JOD",
                                  style: AppFonts.tajawal16PrimapryW600,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        height: 20,
                        thickness: 0,
                        indent: 20,
                        endIndent: 20,
                        color: Colors.black,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FloatingActionButton.extended(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.black,
                            onPressed: () {
                              // Get.to(const AddPost());
                            },
                            label: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                'Reject',
                                style: AppFonts.tajawal14WhiteW600,
                              ),
                            ),
                          ),
                          FloatingActionButton.extended(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.black,
                            onPressed: () {
                              // Get.to(const AddPost());
                            },
                            label: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                'Approve',
                                style: AppFonts.tajawal14WhiteW600,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
