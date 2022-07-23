// ignore_for_file: prefer_const_constructors
import 'package:e_bajrai_mini_market/screens/customerOrder.dart';
import 'package:e_bajrai_mini_market/screens/detailscreen.dart';
import 'package:e_bajrai_mini_market/screens/listproduct.dart';
import 'package:e_bajrai_mini_market/screens/profilescreen.dart';
import 'package:e_bajrai_mini_market/widgets/drawer.dart';
import 'package:e_bajrai_mini_market/widgets/singleproduct.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../model/product.dart';
import '../model/usermodel.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:e_bajrai_mini_market/screens/login.dart';
import 'package:e_bajrai_mini_market/screens/profilescreen.dart';
import 'package:e_bajrai_mini_market/screens/searchproduct.dart';
import 'package:get/get.dart';
import '../widgets/checkout_singleproduct.dart';
import 'package:e_bajrai_mini_market/screens/cartscreen.dart';

Product? chickenData;
Product? beefData;
var mySnapShot;
var fruitVeg;
var dairyEgg;
var meatFish;
var beverage;

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool searchState = false;

  Widget _buildCategoryProduct(String image, String color) {
    return CircleAvatar(
      maxRadius: 40,
      backgroundColor: HexColor(color),
      child: Container(
        height: 40,
        child: Image(color: Colors.white, image: AssetImage("images/$image")),
      ),
    );
  }

  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _key,
      drawer: DrawerCustomer(),
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
            color: Colors.black,
          ),
          onPressed: () {
            _key.currentState?.openDrawer();
          }
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.black,
              ),
              onPressed: () {
                showSearch(context: context, delegate: SearchProduct());
              }),
        ],
      ),
      body: FutureBuilder(
          future: FirebaseFirestore.instance.collection("products").get(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
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
                packing: snapshot.data.docs[0]["packing"]);
            beefData = Product(
                name: snapshot.data.docs[1]["name"],
                description: snapshot.data.docs[1]["description"],
                price: snapshot.data.docs[1]["price"],
                quantity: snapshot.data.docs[1]["quantity"],
                image: snapshot.data.docs[1]["image"],
                categoryID: snapshot.data.docs[1]["categoryID"],
                packing: snapshot.data.docs[0]["packing"]);

            return FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection("products")
                    .where("categoryID", isEqualTo: "fruitVeg")
                    .get(),
                builder: (context, AsyncSnapshot snapshot2) {
                  if (snapshot2.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  fruitVeg = snapshot2;

                  return FutureBuilder(
                      future: FirebaseFirestore.instance
                          .collection("products")
                          .where("categoryID", isEqualTo: "dairyEgg")
                          .get(),
                      builder: (context, AsyncSnapshot snapshot3) {
                        if (snapshot3.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        dairyEgg = snapshot3;

                        return FutureBuilder(
                            future: FirebaseFirestore.instance
                                .collection("products")
                                .where("categoryID", isEqualTo: "meatFish")
                                .get(),
                            builder: (context, AsyncSnapshot snapshot4) {
                              if (snapshot4.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              meatFish = snapshot4;

                              return FutureBuilder(
                                  future: FirebaseFirestore.instance
                                      .collection("products")
                                      .where("categoryID",
                                          isEqualTo: "beverage")
                                      .get(),
                                  builder: (context, AsyncSnapshot snapshot5) {
                                    if (snapshot5.connectionState ==
                                        ConnectionState.waiting) {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                    beverage = snapshot5;

                                    return Container(
                                      height: double.infinity,
                                      width: double.infinity,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      child: ListView(
                                        children: <Widget>[
                                          Column(
                                            children: <Widget>[
                                              Column(
                                                children: <Widget>[
                                                  Container(
                                                    width: double.infinity,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        Column(
                                                          children: <Widget>[
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: <
                                                                  Widget>[
                                                                Container(
                                                                  height: 200,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    image:
                                                                        DecorationImage(
                                                                      fit: BoxFit
                                                                          .fill,
                                                                      image: AssetImage(
                                                                          "images/grocery.png"),
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 40,
                                                                ),
                                                                Container(
                                                                  height: 50,
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: <
                                                                        Widget>[
                                                                      Text(
                                                                        "Categories",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                17,
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Container(
                                                                  height: 60,
                                                                  child: Row(
                                                                    children: <
                                                                        Widget>[
                                                                        GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            Navigator.of(context).pushReplacement(
                                                                              MaterialPageRoute(
                                                                                builder: (ctx) => ListProduct(title: "Fruit and Vegetables", snapShot: fruitVeg),
                                                                              ),
                                                                            );
                                                                          },
                                                                          child: _buildCategoryProduct(
                                                                              "apple_icon.png",
                                                                              "#53B175")),
                                                                      GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            Navigator.of(context).pushReplacement(
                                                                              MaterialPageRoute(
                                                                                  builder: (ctx) => ListProduct(
                                                                                        title: "Dairy and Eggs",
                                                                                        snapShot: dairyEgg,
                                                                                      )),
                                                                            );
                                                                          },
                                                                          child: _buildCategoryProduct(
                                                                              "eggs.png",
                                                                              "#53B175")),
                                                                      GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            Navigator.of(context).pushReplacement(
                                                                              MaterialPageRoute(
                                                                                builder: (ctx) => ListProduct(title: "Meat and Fish", snapShot: meatFish),
                                                                              ),
                                                                            );
                                                                          },
                                                                          child: _buildCategoryProduct(
                                                                              "meat.png",
                                                                              "#53B175")),
                                                                      GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            Navigator.of(context).pushReplacement(
                                                                              MaterialPageRoute(
                                                                                builder: (ctx) => ListProduct(title: "Beverages", snapShot: beverage),
                                                                              ),
                                                                            );
                                                                          },
                                                                          child: _buildCategoryProduct(
                                                                              "soda-bottle.png",
                                                                              "#53B175"))
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
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              children: <
                                                                  Widget>[
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: <
                                                                      Widget>[
                                                                    Text(
                                                                      "Featured",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              17,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                    GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        Navigator.of(context)
                                                                            .pushReplacement(
                                                                          MaterialPageRoute(
                                                                            builder: (ctx) =>
                                                                                ListProduct(
                                                                              title: "Featured",
                                                                              snapShot: mySnapShot,
                                                                            ),
                                                                          ),
                                                                        );
                                                                      },
                                                                      child:
                                                                          Text(
                                                                        "See all",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                18,
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                )
                                                              ]),
                                                        ),
                                                        Row(
                                                          children: <Widget>[
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: <
                                                                  Widget>[
                                                                Row(
                                                                  children: <
                                                                      Widget>[
                                                                    Container(
                                                                      width: 160,
                                                                      child: GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          Navigator.of(context)
                                                                              .pushReplacement(
                                                                            MaterialPageRoute(
                                                                              builder: (ctx) => DetailScreen(
                                                                                  name: chickenData!.name,
                                                                                  description: chickenData!.description,
                                                                                  price: chickenData!.price,
                                                                                  image: chickenData!.image,
                                                                                  packing: chickenData!.packing),
                                                                            ),
                                                                          );
                                                                        },
                                                                        child: SingleProduct(
                                                                            name: chickenData!
                                                                                .name,
                                                                            price: chickenData!
                                                                                .price,
                                                                            image:
                                                                                chickenData!.image),
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      width: 160,
                                                                      child: GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          Navigator.of(context)
                                                                              .pushReplacement(
                                                                            MaterialPageRoute(
                                                                              builder: (ctx) => DetailScreen(
                                                                                  name: beefData!.name,
                                                                                  description: beefData!.description,
                                                                                  price: beefData!.price,
                                                                                  image: beefData!.image,
                                                                                  packing: beefData!.packing),
                                                                            ),
                                                                          );
                                                                        },
                                                                        child: SingleProduct(
                                                                            name: beefData!
                                                                                .name,
                                                                            price: beefData!
                                                                                .price,
                                                                            image:
                                                                                beefData!.image),
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
                                  });
                            });
                      });
                });
          }),
    );
    // }
    // );
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return Login();
    }));
  }
}
