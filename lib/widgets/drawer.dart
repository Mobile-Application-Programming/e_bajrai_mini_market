import 'package:e_bajrai_mini_market/screens/cartscreen.dart';
import 'package:e_bajrai_mini_market/screens/customerOrder.dart';
import 'package:e_bajrai_mini_market/screens/homepage.dart';
import 'package:e_bajrai_mini_market/screens/login.dart';
import 'package:e_bajrai_mini_market/screens/profilescreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

bool homeColor = true;
bool cartColor = false;
bool aboutColor = false;
bool profileColor = false;

class DrawerCustomer extends StatefulWidget {

  @override
  State<DrawerCustomer> createState() => _DrawerCustomerState();
}

class _DrawerCustomerState extends State<DrawerCustomer> {
  @override
  Widget build(BuildContext context) => Drawer(
    child: ListView(children: <Widget>[
      ListTile(
        selectedColor: Color.fromARGB(255, 25, 95, 28),
        selected: homeColor,
        onTap: () {
          setState(() {
            homeColor = true;
            cartColor = false;
            aboutColor = false;
            profileColor = false;
          });
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (ctx)=>HomePage(),
            ),
          );
        },
        leading: Icon(Icons.home),
        title: Text("Home"),
      ),
      ListTile(
        selectedColor: Color.fromARGB(255, 25, 95, 28),
        selected: profileColor,
        onTap: () {
          setState(() {
            aboutColor = false;
            cartColor = false;
            homeColor = false;
            profileColor = true;
          });
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (ctx)=>ProfileScreen(),
            ),
          );
        },
        leading: Icon(Icons.account_circle),
        title: Text("Profile"),
      ),
      ListTile(
        selectedColor: Color.fromARGB(255, 25, 95, 28),
        selected: cartColor,
        onTap: () {
          setState(() {
            cartColor = true;
            homeColor = false;
            aboutColor = false;
            profileColor = false;
          });
          Get.to(() => CartScreen());
        },
        leading: Icon(Icons.shopping_cart),
        title: Text("Cart"),
      ),
      ListTile(
        selectedColor: Color.fromARGB(255, 25, 95, 28),
        selected: aboutColor,
        onTap: () {
          setState(() {
            aboutColor = true;
            cartColor = false;
            homeColor = false;
            profileColor = false;
          });
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (ctx) => CustomerOrder()),
          );
        },
        leading: Icon(Icons.list_alt_sharp),
        title: Text("Orders"),
      ),
      ListTile(
        selectedColor: Color.fromARGB(255, 25, 95, 28),
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