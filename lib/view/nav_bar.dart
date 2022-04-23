import 'package:craft/components/color.dart';
import 'package:craft/components/font.dart';
import 'package:craft/view/home_page.dart';
import 'package:craft/view/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class NavBar extends StatefulWidget {
  final int? typeId;
  const NavBar({Key? key, required this.typeId}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = <Widget>[
      const HomePage(),
      const HomePage(),
      const HomePage(),
      const ProfileScreen(),
    ];
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    void _onItemTapped(int index) {
      setState(() {
        _currentIndex = index;
      });
    }

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.all(5.0),
            child: ClipOval(
              child: Image.asset(
                'assets/images/nouserimage.jpg',
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
                onPressed: () {},
                icon: const Icon(
                  Icons.logout,
                  color: Colors.black,
                ))
          ],
          backgroundColor: Colors.white,
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          backgroundColor: colorScheme.surface,
          selectedItemColor: AppColors.secondaryColor,
          unselectedItemColor: colorScheme.onSurface.withOpacity(.30),
          selectedLabelStyle: textTheme.caption,
          unselectedLabelStyle: textTheme.caption,
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              label: 'Centers',
              icon: Icon(Icons.store),
            ),
            BottomNavigationBarItem(
              label: 'Reservations',
              icon: Icon(Icons.list_alt),
            ),
            BottomNavigationBarItem(
              label: 'Profile',
              icon: Icon(Icons.person),
            ),
          ],
        ),
        // drawer: const NavDrawer(),
        body: Center(child: _pages.elementAt(_currentIndex)));
  }
}
