import 'package:craft/components/color.dart';
import 'package:craft/components/font.dart';
import 'package:craft/view/sub_categories_posts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 2 / 2.85,
          ),
          itemCount: 15,
          itemBuilder: (_, index) {
            return GestureDetector(
              onTap: () {
                Get.to(const PostsPage());
              },
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        // offset: const Offset(3, 3),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                    child: Column(
                      children: [
                        AspectRatio(
                          aspectRatio: 1,
                          child: Image.asset(
                            "assets/images/logo.jpeg",
                            fit: BoxFit.cover,
                          ),
                        ),
                        Expanded(
                            child: Container(
                          padding: const EdgeInsets.all(5),
                          color: AppColors.primaryColor,
                          child: Text(
                            "Name of Product",
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
