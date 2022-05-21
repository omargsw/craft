import 'package:craft/components/color.dart';
import 'package:craft/components/font.dart';
import 'package:craft/view/sub_categories_posts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DateSearch extends SearchDelegate<String> {
  List<dynamic> caregorires;
  List<dynamic> categorydetails;
  DateSearch(this.caregorires, this.categorydetails);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: const Icon(
            Icons.clear,
            color: Colors.red,
          )),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null.toString());
        },
        icon: Icon(Icons.arrow_back, color: AppColors.secondaryColor));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
        color: AppColors.primaryColor,
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text("hekko"),
            );
          },
        ));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var searchlist = query.isEmpty
        ? caregorires
        : caregorires.where((element) => element.startsWith(query)).toList();
    return Container(
        color: Colors.green,
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 300,
                  child: ListView.separated(
                    separatorBuilder: (context, index) {
                      return const Divider(
                        color: Colors.black45,
                      );
                    },
                    itemCount: searchlist.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          ListTile(
                            title: Text(searchlist[index],
                                style: AppFonts.tajawal16BlackW600),
                            leading: CircleAvatar(
                              radius: 23,
                              backgroundImage: NetworkImage(
                                  'https://ogsw.000webhostapp.com/Sanay3i/CategoryImages/' +
                                      categorydetails[index]['image']),
                            ),
                            onTap: () async {
                              query = searchlist[index];
                              // showResults(context);
                              print(searchlist[index]);
                              print(categorydetails[index]['id']);
                              Get.to(PostsPage(
                                titlePage: searchlist[index],
                                categoryId: categorydetails[index]['id'],
                              ));
                            },
                          )
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
