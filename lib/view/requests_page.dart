import 'package:craft/components/color.dart';
import 'package:craft/components/font.dart';
import 'package:craft/components/main_app_bar.dart';
import 'package:craft/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class RequestsPage extends StatefulWidget {
  const RequestsPage({Key? key}) : super(key: key);

  @override
  State<RequestsPage> createState() => _RequestsPageState();
}

class _RequestsPageState extends State<RequestsPage> {
  int? typeId = sharedPreferences!.getInt('typeID');
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        // appBar: mainAppBar(title: "My Requests"),
        body: (typeId == 1)
            ? ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Container(
                          height: 80,
                          width: width * 0.9,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(16.0)),
                            color: Colors.white,
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.8),
                                offset: const Offset(4, 4),
                                blurRadius: 5,
                              ),
                            ],
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 5,
                            ),
                            leading: const CircleAvatar(
                                radius: 23,
                                backgroundImage: AssetImage(
                                    "assets/images/nouserimage.jpg")),
                            trailing: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.article_rounded,
                                  color: Colors.black,
                                )),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("name",
                                    style: AppFonts.tajawal16BlackW600),
                                const SizedBox(height: 4),
                                Text("Approved your request",
                                    style: AppFonts.tajawal14PrimapryW600),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              )
            : ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Container(
                          height: 100,
                          width: width * 0.9,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(16.0)),
                            color: Colors.white,
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.8),
                                offset: const Offset(4, 4),
                                blurRadius: 5,
                              ),
                            ],
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 5,
                            ),
                            leading: const CircleAvatar(
                                radius: 25,
                                backgroundImage: AssetImage(
                                    "assets/images/nouserimage.jpg")),
                            trailing: TextButton(
                              onPressed: () {
                                showModelSheetContactUs(
                                  context,
                                  'name',
                                  '56654654',
                                  'Greyhound divisively hello coldly wonderfully marginally far upon excluding.',
                                  'assets/images/nouserimage.jpg',
                                );
                              },
                              child: Text(
                                'View details',
                                style: AppFonts.tajawal16PrimapryW600,
                              ),
                            ),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: width * 0.5,
                                  child: Wrap(
                                    children: [
                                      Text("Omar wathaifi",
                                          style: AppFonts.tajawal16BlackW600),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text("0784523698",
                                    style: AppFonts.tajawal16BlackW600),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ));
  }

  void showModelSheetContactUs(BuildContext context, String name, String phone,
      String desc, String image) {
    showMaterialModalBottomSheet(
        context: context,
        builder: (builder) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setModelState) {
              return Container(
                height: MediaQuery.of(context).size.height * 0.65,
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 5,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        child: Text(
                          desc,
                          style:
                              TextStyle(color: Colors.black.withOpacity(0.6)),
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.4,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(100.0)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.4),
                              offset: const Offset(4, 4),
                              blurRadius: 16,
                            ),
                          ],
                        ),
                        child: Image.asset(image),
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: FloatingActionButton.extended(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.black,
                        onPressed: () {
                          // Get.to(const AddPost());
                        },
                        label: Text(
                          'Approve',
                          style: AppFonts.tajawal16BlackW600,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        });
  }
}
