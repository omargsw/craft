import 'package:craft/components/color.dart';
import 'package:craft/components/font.dart';
import 'package:craft/main.dart';
import 'package:craft/view/bills_page.dart';
import 'package:craft/view/home_page.dart';
import 'package:craft/view/profile_screen.dart';
import 'package:craft/view/requests_page.dart';
import 'package:craft/view/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class NavBar extends StatefulWidget {
  final int? typeId;
  const NavBar({Key? key, required this.typeId}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int? userId = sharedPreferences!.getInt('userID');
  var accountImage = sharedPreferences!.getString('image');
  int _currentIndex = 0;
  int _currentIndexAdmin = 0;

  @override
  void initState() {
    super.initState();
    print("asdasd" + accountImage.toString());
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = <Widget>[
      const HomePage(),
      //  const RequestsPage(),
      const BillsPage(),
      const ProfileScreen(),
    ];
    final List<Widget> _pagesAdmin = <Widget>[
      const HomePage(),
      const RequestsPage(),
      // const BillsPage(),
      const ProfileScreen(),
    ];
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    void _onItemTapped(int index) {
      setState(() {
        _currentIndex = index;
      });
    }

    void _onItemTappedAdmin(int index) {
      setState(() {
        _currentIndexAdmin = index;
      });
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(5.0),
          child: ClipOval(
            child: Image.network(
              'https://ogsw.000webhostapp.com/Sanay3i/customerImages/' +
                  accountImage.toString(),
              width: 75,
              height: 75,
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Text(
          "إطلب صنايعي",
          style: AppFonts.tajawal25PrimaryW600,
        ),
        actions: [
          IconButton(
              onPressed: () async {
                Get.offAll(() => SplashScreen());
                SharedPreferences sharedPreferences =
                    await SharedPreferences.getInstance();
                sharedPreferences.clear();
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.black,
              ))
        ],
        backgroundColor: Colors.white,
      ),
      bottomNavigationBar: (widget.typeId == 1)
          ? BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: _currentIndex,
              backgroundColor: colorScheme.surface,
              selectedItemColor: AppColors.primaryColor,
              unselectedItemColor: colorScheme.onSurface.withOpacity(.30),
              selectedLabelStyle: textTheme.caption,
              unselectedLabelStyle: textTheme.caption,
              onTap: _onItemTapped,
              items: const [
                BottomNavigationBarItem(
                  label: 'Home',
                  icon: Icon(Icons.home),
                ),
                // BottomNavigationBarItem(
                //   label: 'Requests',
                //   icon: Icon(Icons.list_alt),
                // ),
                BottomNavigationBarItem(
                  label: 'Bills',
                  icon: Icon(Icons.article_rounded),
                ),
                BottomNavigationBarItem(
                  label: 'Profile',
                  icon: Icon(Icons.person),
                ),
              ],
            )
          : BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: _currentIndexAdmin,
              backgroundColor: colorScheme.surface,
              selectedItemColor: AppColors.primaryColor,
              unselectedItemColor: colorScheme.onSurface.withOpacity(.30),
              selectedLabelStyle: textTheme.caption,
              unselectedLabelStyle: textTheme.caption,
              onTap: _onItemTappedAdmin,
              items: const [
                BottomNavigationBarItem(
                  label: 'Home',
                  icon: Icon(Icons.home),
                ),
                BottomNavigationBarItem(
                  label: 'Requests',
                  icon: Icon(Icons.list_alt),
                ),
                // BottomNavigationBarItem(
                //   label: 'Bills',
                //   icon: Icon(Icons.article_rounded),
                // ),
                BottomNavigationBarItem(
                  label: 'Profile',
                  icon: Icon(Icons.person),
                ),
              ],
            ),
      // drawer: const NavDrawer(),
      body: Center(
        child: (widget.typeId == 1)
            ? _pages.elementAt(_currentIndex)
            : _pagesAdmin.elementAt(_currentIndexAdmin),
      ),
    );
  }
}
