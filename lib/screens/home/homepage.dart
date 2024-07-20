import 'dart:ui';

import 'package:fancy/screens/home/postoffice_screen/post_office_screen.dart';
import 'package:fancy/screens/home/profile_screen/profile.dart';
import 'package:fancy/screens/home/profile_screen/profile_page.dart';
import 'package:fancy/screens/home/shop_page/shoppage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'explore_page/explore.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    if (FirebaseAuth.instance.currentUser != null) {
      print(FirebaseAuth.instance.currentUser?.uid);
    }
    super.initState();
  }

  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const ShopPage(),
    ExploreList.create(),
    PostOfficeSearch.create(),
    const ProfilePage(),
  ];

  PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        flexibleSpace: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 10,
              sigmaY: 10,
            ),
            child: Container(
              color: Colors.transparent,
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black.withAlpha(0),
        elevation: 1,
        leading: const Padding(padding: EdgeInsets.only(left: 15), child: DraggableExample()),
        actions: [
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.all(5),
              child: const Icon(
                CupertinoIcons.heart,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.only(right: 20, left: 5),
              child: const Icon(
                Icons.shopping_bag_rounded,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
        ],
      ),
      body: PageView(
        physics: const BouncingScrollPhysics(),
        controller: controller,
        children: _widgetOptions,
        onPageChanged: (value) {
          _selectedIndex = value;
          setState(() {});
        },
      ),
      // body: Center(
      //   child: _widgetOptions.elementAt(_selectedIndex),
      // ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.bolt_fill),
            label: 'Shop',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.eye_solid),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.bookmark_fill),
            label: 'Brands',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.profile_circled),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.black87,
        selectedLabelStyle:
            const TextStyle(color: Colors.white, fontFamily: 'Raleway', fontSize: 13),
        unselectedLabelStyle:
            const TextStyle(color: Colors.white, fontFamily: 'Raleway', fontSize: 13),
        elevation: 0.0,
        onTap: (value) {
          setState(() {
            _selectedIndex = value;
            controller.animateToPage(value,
                duration: const Duration(milliseconds: 1250),
                curve: Curves.easeInOutCubicEmphasized);
          });
          // controller.addListener(() {
          //   _selectedIndex;
          //   // setState(() {});
          // });
        },
      ),
    );
  }
}
