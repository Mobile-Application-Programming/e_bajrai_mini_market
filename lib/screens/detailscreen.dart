import 'package:e_bajrai_mini_market/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:e_bajrai_mini_market/screens/listproduct.dart';

class DetailScreen extends StatefulWidget {
  final String image;
  final String name;
  final String description;
  final String packing;
  final double price;
  DetailScreen({required this.name, required this.description, required this.price, required this.image, required this.packing});
  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {

  int count=1;
  Widget _buildSizeProduct({required String name}){
    return Container(
      height: 60,
      width: 60,
      color: Color(0xfff2f2f2),
      child: Center(
        child: Text(
          name, 
          style: TextStyle(
            fontSize: 17,
          ),
        )
      ),
    );
  }

  final TextStyle myStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Detail Page", style:TextStyle(color: Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ), 
          onPressed: (){
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (ctx)=>ListProduct(
                  snapShot: mySnapShot,
                ),
              ),
            );
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.notifications_none, 
              color: Colors.black,
            ),
            onPressed: (){},
          ),
        ],
      ),
      body: Container(
        child: ListView(
          children: [
            Column(
              children: <Widget>[
                Center(
                  child: Container(
                    width: 350,
                    child: Card(
                      child: Container(
                        padding: EdgeInsets.all(13),
                        child: Container(
                          height: 260,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage("images/${widget.image}"),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 150,
                        child: Row(
                          children:<Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  widget.name, 
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "\RM ${widget.price.toStringAsFixed(2)}",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 85, 94, 88),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    height: 2.0,
                                  ),
                                ),
                                Text(
                                  "Description", 
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    height: 3.0,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 110,
                        child: Wrap(
                          children: <Widget>[
                            Text(
                              widget.description,
                              style: TextStyle(
                                fontSize: 15,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "Packing Size", 
                        style: myStyle,
                      ),
                      Container(
                        height: 80,
                        child: Wrap(
                          children: <Widget>[
                            Text(
                              widget.packing,
                              style: TextStyle(
                                fontSize: 15,
                                height: 2.5,
                              ),
                            )
                          ],
                        ),
                      ),
                      Text(
                        "Quantity", 
                        style: myStyle,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 40,
                        width: 130,
                        decoration: BoxDecoration(
                          color: HexColor("#cae8d5"),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            GestureDetector(
                              child: Icon(Icons.remove), 
                              onTap: (){
                                setState(() {
                                  if(count>1) {
                                    count--;
                                  }
                                });
                              },
                            ),
                            Text(
                              count.toString(), 
                              style: myStyle,
                            ),
                            GestureDetector(
                              child: Icon(Icons.add), 
                              onTap: (){
                                setState(() {
                                  count++;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      Container(
                        height: 60,
                        width: double.infinity,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)
                          ),
                          color: HexColor("#53B175"),
                          child: Text(
                            "Add To Cart", 
                            style: myStyle,
                          ),
                          onPressed: (){}
                        )
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}