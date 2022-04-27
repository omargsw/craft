import 'package:craft/components/font.dart';
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
                  height: 250,
                  width: width * 0.9,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                    color: const Color.fromARGB(255, 82, 40, 40),
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
                          "Carft details",
                          style: AppFonts.tajawal20PrimaryW600,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "Name : ",
                            style: AppFonts.tajawal16PrimapryW600,
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
                            style: AppFonts.tajawal16PrimapryW600,
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
                              style: AppFonts.tajawal16BlackW600,
                            ),
                            Text(
                              "Price",
                              style: AppFonts.tajawal16BlackW600,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Description",
                              style: AppFonts.tajawal16SecondaryW600,
                            ),
                            Row(
                              children: [
                                Text(
                                  "20",
                                  style: AppFonts.tajawal16SecondaryW600,
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
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Total : ",
                              style: AppFonts.tajawal16BlackW600,
                            ),
                            Row(
                              children: [
                                Text(
                                  "20",
                                  style: AppFonts.tajawal16SecondaryW600,
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
