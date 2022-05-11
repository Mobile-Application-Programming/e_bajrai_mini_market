import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:e_bajrai_mini_market/screens/login.dart';

class HomepageAdmin extends StatefulWidget {

  @override
  State<HomepageAdmin> createState() => _HomepageAdminState();
}

class _HomepageAdminState extends State<HomepageAdmin> {

bool homeColor=true;
bool cartColor=false;
bool aboutColor=false;

final GlobalKey<ScaffoldState> _key1 = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key1,
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(
                "Admin", 
                style: TextStyle(color: Colors.black)
              ),
              currentAccountPicture: CircleAvatar(
                radius: 20,
                backgroundColor: HexColor("#53B175"),
                backgroundImage: AssetImage("images/user.jpg"),
              ), 
              decoration: BoxDecoration(
                color: Color(0xfff2f2f2)
              ),
              accountEmail: Text(
                "admin@gmail.com",
                style: TextStyle(color: Colors.black)
              ),
            ),
            ListTile(
              selected: homeColor,
              onTap: (){
                setState(() {
                  homeColor=true;
                  cartColor=false;
                  aboutColor=false;
                });
              },
              leading: Icon(Icons.home),
              title: Text("Home"),
            ),
            ListTile(
              selected: cartColor,
              onTap: (){
                setState(() {
                  cartColor=true;
                  homeColor=false;
                  aboutColor=false;
                });
              },
              leading: Icon(Icons.shopping_cart),
              title: Text("Cart"),
            ),
            ListTile(
              selected: aboutColor,
              onTap: (){
                setState(() {
                  aboutColor=true;
                  cartColor=false;
                  homeColor=false;
                });
              },
              leading: Icon(Icons.info),
              title: Text("About"),
            ),
            ListTile(
              onTap: (){
                logout(context);
              },
              leading: Icon(Icons.exit_to_app),
              title: Text("Logout"),
            ),
          ]
        )
      ),
      appBar: AppBar(
        title: Text(
          "Admin HomePage",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.grey[100],
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color:Colors.black,
          ),
          onPressed: (){
            _key1.currentState?.openDrawer();
        }),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search,color: Colors.black,), 
            onPressed: (){}),
          IconButton(
            icon: Icon(Icons.notifications_none,color: Colors.black,), 
            onPressed: (){}),
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
              return Login();
            })
        );
  }
}