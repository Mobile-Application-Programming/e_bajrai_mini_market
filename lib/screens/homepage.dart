// ignore_for_file: prefer_const_constructors
import 'package:e_bajrai_mini_market/screens/detailscreen.dart';
import 'package:e_bajrai_mini_market/screens/listproduct.dart';
import 'package:e_bajrai_mini_market/widgets/singleproduct.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../model/product.dart';
import 'package:hexcolor/hexcolor.dart';

Product ? chickenData;
Product ? beefData;
var mySnapShot;

class HomePage extends StatelessWidget {

Widget _buildCategoryProduct(String image, String color) {
  return CircleAvatar(
    maxRadius: 40,
    backgroundColor: HexColor(color),
    child: Container(
      height: 40,
      child: Image(
        color: Colors.white,
        image: AssetImage("images/$image")
      ),
    ),   
  );
}

  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawer: Drawer(),
      appBar: AppBar(
        title: Text(
          "HomePage",
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
            //_key.currentState.openDrawer();
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
      body: FutureBuilder(
        future: FirebaseFirestore.instance.collection("products").get(),
        builder: (context, AsyncSnapshot snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          mySnapShot = snapshot;
          chickenData = Product(
            name: snapshot.data.docs[0]["name"], 
            description: snapshot.data.docs[0]["description"], 
            price: snapshot.data.docs[0]["price"],
            quantity: snapshot.data.docs[0]["quantity"],
            image: snapshot.data.docs[0]["image"], 
            categoryID: snapshot.data.docs[0]["categoryID"],
            packing: snapshot.data.docs[0]["packing"]
          );
          beefData = Product(
            name: snapshot.data.docs[1]["name"], 
            description: snapshot.data.docs[1]["description"], 
            price: snapshot.data.docs[1]["price"],
            quantity: snapshot.data.docs[1]["quantity"],
            image: snapshot.data.docs[1]["image"], 
            categoryID: snapshot.data.docs[1]["categoryID"],
            packing: snapshot.data.docs[0]["packing"]
          );

          return Container(
            height: double.infinity,
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal:20),
            child: ListView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        height: 200,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: AssetImage("images/grocery.png"),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 40,
                                      ),
                                      Container(
                                        height: 50,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              "Categories",
                                              style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 60,
                                        child: Row(
                                          children: <Widget>[
                                            _buildCategoryProduct("apple_icon.png", "#53B175"),
                                            _buildCategoryProduct("eggs.png", "#53B175"),
                                            _buildCategoryProduct("meat.png", "#53B175"),
                                            _buildCategoryProduct("soda-bottle.png", "#53B175")
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                        
                              Container(
                                height: 50,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          "Featured",
                                          style: TextStyle(
                                            fontSize: 17,fontWeight: FontWeight.bold),
                                        ),
                                        GestureDetector(
                                          onTap: (){
                                            Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                builder: (ctx)=>ListProduct(
                                                  snapShot: mySnapShot,
                                                ),
                                              ),
                                            );
                                          },
                                          child: Text(
                                            "See all",
                                            style: TextStyle(
                                              fontSize: 18,fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    )
                                  ]
                                ),
                              ),
                              Row(
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(children: <Widget>[
                                        GestureDetector(
                                          onTap: (){
                                            Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                builder: (ctx)=>DetailScreen(
                                                  name: chickenData!.name, 
                                                  description: chickenData!.description, 
                                                  price: chickenData!.price,
                                                  image: chickenData!.image,
                                                  packing: chickenData!.packing
                                                ),
                                              ),
                                            );
                                          },
                                          child: SingleProduct(
                                            name: chickenData!.name, 
                                            price: chickenData!.price, 
                                            image: chickenData!.image
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: (){
                                            Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                builder: (ctx)=>DetailScreen(
                                                  name: beefData!.name, 
                                                  description: beefData!.description, 
                                                  price: beefData!.price,
                                                  image: beefData!.image,
                                                  packing: beefData!.packing
                                                ),
                                              ),
                                            );
                                          },
                                          child: SingleProduct(
                                            name: beefData!.name, 
                                            price: beefData!.price, 
                                            image: beefData!.image
                                          ),
                                        ),
                                      ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
      
                        ],
                        ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}