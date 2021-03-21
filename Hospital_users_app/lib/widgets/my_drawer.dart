import 'package:flutter/material.dart';
import 'package:users_app/global/global.dart';
import 'package:users_app/mainScreens/about_screen.dart';
import 'package:users_app/mainScreens/profile_screen.dart';
import 'package:users_app/mainScreens/trips_history_screen.dart';
import 'package:users_app/splashScreen/splash_screen.dart';

class MyDrawer extends StatefulWidget {
  String? name;
  String? email;

  MyDrawer({this.name, this.email});

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
        decoration: BoxDecoration(
        image: DecorationImage(
        image: AssetImage("images/11.png"),
    fit: BoxFit.cover,
    ),
    ),
    child: Column(
    children: [
    //drawer header
    Expanded(
    flex: 2,
    child: Container(
    color: Colors.transparent,
    child: DrawerHeader(
    decoration: const BoxDecoration(color: Colors.transparent),
    child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    const Icon(
    Icons.person,
    size: 70,
    color: Colors.white,
    ),
    const SizedBox(
    height: 10,
    ),
    Text(
    widget.name.toString(),
    style: const TextStyle(
    fontSize: 16,
    color: Colors.white,
    fontWeight: FontWeight.bold,
    ),
    ),
    Text(
    widget.email.toString(),
    style: const TextStyle(
    fontSize: 11,
    color: Colors.white,
    ),
    ),
    ],
    ),
    ),
    ),
    ),
    const SizedBox(
    height: 12.0,
    ),

    //drawer body
    Expanded(
    flex: 3,
    child: ListView(
    children: [
    GestureDetector(
    onTap: () {
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (c) => TripsHistoryScreen(),
    ),
    );
    },
    child: ListTile(
    leading: Icon(
    Icons.history,
    color: Colors.white54,
    ),
    title: Text(
    "History",
    style: TextStyle(color: Colors.white54),
    ),
    ),
    ),

    GestureDetector(
    onTap: () {
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (c) => ProfileScreen(),
    ),
    );
    },
    child: ListTile(
    leading: Icon(
    Icons.person,
    color: Colors.white54,
    ),
    title: Text(
    "Visit Profile",
    style: TextStyle(color: Colors.white54),
    ),
    ),
    ),

    GestureDetector(
    onTap: () {
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (c) => AboutScreen(),
    ),
    );
    },
    child: ListTile(
    leading: Icon(
    Icons.info,
    color: Colors.white54,
    ),
    title: Text(
    "About",
    style: TextStyle(color: Colors.white54),
    ),
    ),
    ),
    ],
    ),
    ),

    //drawer footer
    GestureDetector(
    onTap: () {
    fAuth.signOut();
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (c) => const MySplashScreen(),
    ),
    );
    },
    child: Container(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    color: Colors.transparent,
      child: ListTile(
        leading: Icon(
          Icons.logout,
          color: Colors.white54,
        ),
        title: Text(
          "Sign Out",
          style: TextStyle(color: Colors.white54),
        ),
      ),
    ),
    ),
    ],
    ),
        ),
    );
  }
}
