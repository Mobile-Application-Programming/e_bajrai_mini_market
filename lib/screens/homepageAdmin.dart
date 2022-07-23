// ignore_for_file: prefer_const_constructors
import 'package:e_bajrai_mini_market/screens/addProduct.dart';
import 'package:e_bajrai_mini_market/screens/detailAdmin.dart';
import 'package:e_bajrai_mini_market/screens/detailscreen.dart';
import 'package:e_bajrai_mini_market/screens/listProductAdmin.dart';
import 'package:e_bajrai_mini_market/screens/listproduct.dart';
import 'package:e_bajrai_mini_market/screens/salesReport.dart';
import 'package:e_bajrai_mini_market/widgets/admindrawer.dart';
import 'package:e_bajrai_mini_market/widgets/singleproduct.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../model/product.dart';
import '../model/usermodel.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:e_bajrai_mini_market/screens/login.dart';
import 'package:e_bajrai_mini_market/screens/searchproduct.dart';
import 'package:get/get.dart';
import 'package:e_bajrai_mini_market/screens/cartscreen.dart';

//product_provider.getUserModel();

Product? chickenData;
Product? beefData;
var mySnapShot;
var fruitVeg;
var dairyEgg;
var meatFish;
var beverage;

class HomepageAdmin extends StatefulWidget {
  @override
  State<HomepageAdmin> createState() => _HomepageAdminState();
}

//late CategoryProvider categoryProvider;

class _HomepageAdminState extends State<HomepageAdmin> {

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

  bool homeColor = true;
  bool cartColor = false;
  bool aboutColor = false;
  bool profileColor = false;

  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _key,
      drawer: DrawerAdmin(),
      appBar: AppBar(
         title: Text(
          "Admin Homepage",
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
            }),
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
                                        children: <Widget>[ Column(
                                          children: [
                                            SizedBox(
                                              height: 30,
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
                                              height: 40,
                                            ),
                                            Container(
                                              height: 50,
                                              width: 230,
                                              child: ElevatedButton.icon(
                                                style: ButtonStyle(
                                                  shape: MaterialStateProperty.all<
                                                      RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(10),
                                                    ),
                                                  ),
                                                  backgroundColor: MaterialStateProperty.all(Colors.white),
                                                  side: MaterialStateProperty.all(BorderSide(
                                                          color: HexColor("#53B175"),
                                                          width: 2.0,
                                                          style: BorderStyle.solid))
                                                ),
                                                icon: Icon(Icons.add, color: HexColor("#53B175")),
                                                label: Text(
                                                  "Add New Product",
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                    color: HexColor("#53B175")
                                                  ),
                                                ),
                                                onPressed: () {
                                                  Get.to(() => AddProduct());
                                                },
                                              )
                                          ),                                           
                                          SizedBox(
                                            height: 30,
                                          ),
                                            // Expanded(
                                            //   // child: 
                                            Container(
                                              //margin: EdgeInsets.symmetric(horizontal: 20),
                                                child: 
                                            //     ListView(
                                            //       children: <Widget>[
                                                    Column(
                                                      children: <Widget>[
                                                        Container(
                                                          height: 2500,
                                                          child: GridView.builder(
                                                            physics: NeverScrollableScrollPhysics(),
                                                            
                                                            itemCount: mySnapShot.data.docs.length,
                                                            itemBuilder: (ctx, index) {
                                                              return GestureDetector(
                                                                onTap: () {
                                                                  Navigator.of(context).pushReplacement(
                                                                    MaterialPageRoute(
                                                                      builder: (ctx) => DetailAdmin(
                                                                          name: mySnapShot.data.docs[index]["name"],
                                                                          description: mySnapShot.data.docs[index]["description"],
                                                                          price: mySnapShot.data.docs[index]["price"],
                                                                          quantity: mySnapShot.data.docs[index]["quantity"],
                                                                          image: mySnapShot.data.docs[index]["image"],
                                                                          categoryID: mySnapShot.data.docs[index]["categoryID"],
                                                                          packing: mySnapShot.data.docs[index]["packing"]),
                                                                    ),
                                                                  );
                                                                },
                                                                child: SingleProduct(
                                                                    name: mySnapShot.data.docs[index]["name"],
                                                                    price: mySnapShot.data.docs[index]["price"],
                                                                    image: mySnapShot.data.docs[index]["image"]),
                                                              );
                                                            },
                                                            scrollDirection: Axis.vertical,
                                                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                                crossAxisCount: 2,
                                                                childAspectRatio: 0.7,
                                                                crossAxisSpacing: 10,
                                                                mainAxisSpacing: 10),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                              //     ],
                                              //   ),
                                              // ),
                                            ),
                                          ],
                                        ),
                                        ]
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
