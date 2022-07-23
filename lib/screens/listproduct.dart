import 'package:e_bajrai_mini_market/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:e_bajrai_mini_market/widgets/singleproduct.dart';
import 'package:e_bajrai_mini_market/screens/detailscreen.dart';
import '../model/product.dart';

class ListProduct extends StatelessWidget {
  final snapShot;
  final String title;
  ListProduct({required this.title, required this.snapShot});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (ctx) => HomePage()),
              );
            }),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  height: 30,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              title,
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                          ],
                        )
                      ]),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 700,
                  child: GridView.builder(
                    itemCount: snapShot.data.docs.length,
                    itemBuilder: (ctx, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (ctx) => DetailScreen(
                                  name: snapShot.data.docs[index]["name"],
                                  description: snapShot.data.docs[index]
                                      ["description"],
                                  price: snapShot.data.docs[index]["price"],
                                  image: snapShot.data.docs[index]["image"],
                                  packing: snapShot.data.docs[index]
                                      ["packing"]),
                            ),
                          );
                        },
                        child: SingleProduct(
                            name: snapShot.data.docs[index]["name"],
                            price: snapShot.data.docs[index]["price"],
                            image: snapShot.data.docs[index]["image"]),
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
          ],
        ),
      ),
    );
  }
}
