import 'dart:developer';

import 'package:craft/components/color.dart';
import 'package:craft/components/font.dart';
import 'package:craft/components/web_config.dart';
import 'package:craft/model/fetch_categories.dart';
import 'package:craft/view/sub_categories_posts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;

  List<FetchCategory> category = [];
  Future fetshCategory() async {
    isLoading = true;
    try {
      String url =
          WebConfig.baseUrl + WebConfig.apisPath + WebConfig.getCategory;
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<FetchCategory> categories =
            fetchCategoryFromJson(response.body);
        return categories;
      }
    } catch (e) {
      log("[FetshCategory] $e");
    } finally {
      isLoading = false;
    }
  }

  @override
  void initState() {
    super.initState();
    fetshCategory().then((categories) {
      setState(() {
        category = categories;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: (category.isEmpty || category == null)
          ? Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
              ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 2 / 2.85,
                ),
                itemCount: category.length,
                itemBuilder: (_, index) {
                  FetchCategory categoryApi = category[index];
                  return GestureDetector(
                    onTap: () {
                      Get.to(PostsPage(
                        titlePage: categoryApi.name,
                        categoryId: categoryApi.id,
                      ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(16.0)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.4),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(16.0)),
                          child: Column(
                            children: [
                              AspectRatio(
                                aspectRatio: 1,
                                child: Image.network(
                                  'https://ogsw.000webhostapp.com/Sanay3i/CategoryImages/' +
                                      categoryApi.image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Expanded(
                                  child: Container(
                                width: width,
                                padding: const EdgeInsets.all(5),
                                color: AppColors.primaryColor,
                                child: Text(
                                  categoryApi.name,
                                  style: AppFonts.tajawal14WhiteW600,
                                  textAlign: TextAlign.center,
                                ),
                              )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
