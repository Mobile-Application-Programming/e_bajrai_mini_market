import 'package:e_bajrai_mini_market/screens/cartscreen.dart';
import 'package:e_bajrai_mini_market/screens/customerOrder.dart';
import 'package:e_bajrai_mini_market/screens/homepage.dart';
import 'package:e_bajrai_mini_market/screens/login.dart';
import 'package:e_bajrai_mini_market/screens/profilescreen.dart';
import 'package:e_bajrai_mini_market/screens/salesReport.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

bool homeColor = true;
bool salesColor = false;

class DrawerAdmin extends StatefulWidget {

  @override
  State<DrawerAdmin> createState() => _DrawerAdminState();
}

class _DrawerAdminState extends State<DrawerAdmin> {
  @override
  Widget build(BuildContext context) => Drawer(
    child: ListView(children: <Widget>[
      ListTile(
        selectedColor: Color.fromARGB(255, 25, 95, 28),
        selected: homeColor,
        onTap: () {
          setState(() {
            homeColor = true;
            salesColor = false;
          });
        },
        leading: Icon(Icons.home),
        title: Text("Homepage"),
      ),
      ListTile(
        selectedColor: Color.fromARGB(255, 25, 95, 28),
        selected: salesColor,
        onTap: () {
          setState(() {
            salesColor = true;
            homeColor = false;
          });
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (ctx) => SalesReport()),
          );
        },
        leading: Icon(Icons.analytics_outlined),
        title: Text("Sales Analytics"),
      ),
      ListTile(
        onTap: () {
          logout(context);
        },
        leading: Icon(Icons.exit_to_app),
        title: Text("Logout"),
      ),
    ])
  );
}

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (BuildContext context) {
      return Login();
    }));
  }