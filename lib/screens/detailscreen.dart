import 'package:e_bajrai_mini_market/controller/user_controller.dart';
import 'package:e_bajrai_mini_market/model/cartmodel.dart';
import 'package:e_bajrai_mini_market/model/usermodel.dart';
import 'package:e_bajrai_mini_market/screens/cartscreen.dart';
import 'package:e_bajrai_mini_market/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:e_bajrai_mini_market/screens/listproduct.dart';
import '../provider/product_provider.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:e_bajrai_mini_market/controller/cart_controller.dart';
import 'package:e_bajrai_mini_market/controller/product_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_bajrai_mini_market/model/product.dart';

class DetailScreen extends StatefulWidget {
  final String image;
  final String name;
  final String description;
  final String packing;
  final double price;
  DetailScreen(
      {required this.name,
      required this.description,
      required this.price,
      required this.image,
      required this.packing});
  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {

  int count = 1;
  late int index;
  final cartController = Get.put(CartController());
  final productController = Get.put(ProductController());
  final userController1 = Get.put(UserController());
  UserController userController = UserController.instance;
   
  //late ProductProvider productProvider;
  Widget _buildSizeProduct({required String name}) {
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
      )),
    );
  }

  List<Product> productList1=[];
  late Product productData1;
  late Product productBetul;
  late final CartModel cartItem;
  late UserModel user1;
  List<UserModel> userList1=[];

  void productList() async {

      final productData = FirebaseFirestore.instance.collection('products');
      final QuerySnapshot result = await productData.get();

      result.docs.forEach((res) async {
        productData1 = Product( 
          name: res["name"],
          description: res["description"],
          price: res["price"],
          quantity: res["quantity"],
          image: res["image"],
          categoryID: res["categoryID"],
          packing: res["packing"],
        );
        productList1.add(productData1);
      });
      index = productList1.indexWhere((element) => element.name == widget.name);

      productBetul = productList1[index];
      print(productBetul.name);
      
      //print(userController.listenToUser().toList());
      //userController.listenToUser();
      //userController.userModel.value.cart!.map((cartItem) => cuba(cartItem)).toList();
      userController.setToListen();
      print(userController.listenToUser().isEmpty);
      print(userController.userModel.value.userName);
      print(userController.userModel.value.cart.toList()[0].name);
      print(userController.firebaseUser?.uid);
  }

  void cuba() async {

      final productData = FirebaseFirestore.instance.collection('User');
      final QuerySnapshot result = await productData.get();

      result.docs.forEach((res) async {
        user1 = UserModel( 
          userEmail:res["UserName"],
          userName:res["UserEmail"],
          userImage:res["Phone Number"],
          userPhoneNumber:res["userImage"],
          userAddress:res["userAddress"],
          cart:res["cart"],
        );
        userList1.add(user1);
      });
      
      
      //print(userController.listenToUser().toList());
      //userController.listenToUser();
      //userController.userModel.value.cart!.map((cartItem) => cuba(cartItem)).toList();
      print(userController.userModel.value.userName);
      print(userController.firebaseUser?.uid);
  }

  final TextStyle myStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    //productProvider = Provider.of<ProductProvider>(context);
    //productController.getAllProducts();
    productList();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Detail Page", style: TextStyle(color: Colors.black)),
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
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.notifications_none,
              color: Colors.black,
            ),
            onPressed: () {},
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
                          children: <Widget>[
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
                      // Text(
                      //   "Quantity",
                      //   style: myStyle,
                      // ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // Container(
                      //   height: 40,
                      //   width: 130,
                      //   decoration: BoxDecoration(
                      //     color: HexColor("#cae8d5"),
                      //     borderRadius: BorderRadius.circular(20),
                      //   ),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //     children: <Widget>[
                      //       GestureDetector(
                      //         child: Icon(Icons.remove),
                      //         onTap: () {
                      //           setState(() {
                      //             if (count > 1) {
                      //               count--;
                      //             }
                      //           });
                      //         },
                      //       ),
                      //       Text(
                      //         count.toString(),
                      //         style: myStyle,
                      //       ),
                      //       GestureDetector(
                      //         child: Icon(Icons.add),
                      //         onTap: () {
                      //           setState(() {
                      //             count++;
                      //           });
                      //         },
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      SizedBox(
                        height: 35,
                      ),
                      Container(
                          height: 60,
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                backgroundColor: MaterialStateProperty.all(
                                    HexColor("#53B175"))),
                            child: Text(
                              "Add To Cart",
                              style: myStyle,
                            ),
                            onPressed: () {
                              cartController.addProduct(productList1[index]);
                              // productProvider.getCartData(
                              //   image: widget.image,
                              //   name: widget.name,
                              //   price: widget.price,
                              //   quantity: count,
                              // );
                              // Navigator.of(context).pushReplacement(
                              //   MaterialPageRoute(
                              //     builder: (ctx) => CartScreen(),
                              //   ),
                              // );
                            },
                          ))
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
