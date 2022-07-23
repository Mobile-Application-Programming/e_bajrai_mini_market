import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_bajrai_mini_market/controller/checkout_controller.dart';
import 'package:e_bajrai_mini_market/model/cartmodel.dart';
import 'package:e_bajrai_mini_market/screens/cartscreen.dart';
import 'package:e_bajrai_mini_market/screens/homepage.dart';
import 'package:e_bajrai_mini_market/screens/makepayment.dart';
import 'package:e_bajrai_mini_market/widgets/checkout_singleproduct.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_bajrai_mini_market/controller/cart_controller.dart';
import 'package:e_bajrai_mini_market/controller/user_controller.dart';
import 'package:hexcolor/hexcolor.dart';

class CheckOut extends StatefulWidget {
  @override
  _CheckOutState createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {

  final cartController = Get.put(CartController());
  final CartController controller = Get.find();
  final userController1 = Get.put(UserController());
  UserController userController = UserController.instance;
  final checkoutController = Get.put(CheckoutController());
  final CheckoutController controller2 = Get.find();
  
  TextStyle myStyle = TextStyle(
    fontSize: 17,
  );
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  
  get console => null;

  Widget _buildBottomSingleDetail(
      {required String startName, required String endName}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          startName,
          style: TextStyle(fontSize: 15),
        ),
        Text(
          endName,
          style: TextStyle(fontSize: 15),
        ),
      ],
    );
  }

  late User user;
  late double total;
  late List<CartModel> myList;

  Widget _buildButton() {
    return Container(
      height: 60,
      width: 350,
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
          "Buy",
          style: myStyle,
        ),
        onPressed: () {
          if (userController.userModel.value.userAddress=="") {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (ctx) => HomePage(),
              ),
            );
          } else {
              controller2.addOrder();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (ctx) => makePayment(),
              ),
            );
          }
        },
      )
    );
  }
  
  @override
  Widget build(BuildContext context) {

    double subTotal = cartController.totalCartPrice.value;
    double shipping = 7;
    total = subTotal + shipping;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Checkout Page", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (ctx) => CartScreen(),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: Container(
          height: 70,
          width: 90,
          margin: EdgeInsets.symmetric(horizontal: 10),
          padding: EdgeInsets.only(bottom: 15),
          child: _buildButton(),
        ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                child: ListView.builder(
                  itemCount: userController.userModel.value.cart.length,
                  itemBuilder: (ctx, index) {
                    return CheckOutSingleProduct(
                      index: index,
                      image: userController.userModel.value.cart[index].image,
                      name: userController.userModel.value.cart[index].name,
                      price: userController.userModel.value.cart[index].price,
                      quentity: userController.userModel.value.cart[index].quantity,
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _buildBottomSingleDetail(
                      startName: "Subtotal",
                      endName: "RM ${subTotal.toStringAsFixed(2)}",
                    ),
                    _buildBottomSingleDetail(
                      startName: "Shipping",
                      endName: "RM ${shipping.toStringAsFixed(2)}",
                    ),
                    _buildBottomSingleDetail(
                      startName: "Total",
                      endName: "RM ${total.toStringAsFixed(2)}",
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
