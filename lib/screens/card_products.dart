import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_bajrai_mini_market/controller/cart_controller.dart';
import 'package:e_bajrai_mini_market/controller/user_controller.dart';
import 'package:e_bajrai_mini_market/model/cartmodel.dart';
import 'package:e_bajrai_mini_market/model/product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class CartProducts extends StatelessWidget {
  final cartController = Get.put(CartController());
  final CartController controller = Get.find();
  final userController1 = Get.put(UserController());
  CartProducts({Key? key}) : super(key:key);
  UserController userController = UserController.instance;

  void listenCartItem() {
    userController.setToListen();
  }

  @override
  Widget build(BuildContext context) {
    listenCartItem();
    //print(userController.userModel.value.cart!.toList()[0].name);
    return Obx(
      () => SizedBox(
        height: 450, 
        child: ListView.builder(
          itemCount: userController.userModel.value.cart.length,
          itemBuilder: (BuildContext context, int index) {
            return CartProductCard(
              controller: controller,
              product: userController.userModel.value.cart[index],
              quantity: userController.userModel.value.cart[index].quantity,
              index: index,
              cartItem: userController.userModel.value.cart[index],
            );
          }
        )
      ),
    );
  }
}

class CartProductCard extends StatelessWidget {
  final CartController controller;
  final CartModel product;
  final int quantity;
  final int index;
  final CartModel cartItem;

  const CartProductCard({
    Key? key,
    required this.controller,
    required this.product,
    required this.quantity,
    required this.index,
    required this.cartItem,
  }) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 15,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            radius: 40, 
            backgroundImage: NetworkImage(product.image),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Text(
              product.name,
              style: TextStyle(fontSize: 15)
            ),
            
          ),
          IconButton(
            onPressed: (){
              controller.decreaseQuantity(cartItem);
            }, 
            icon: Icon(
              Icons.remove_circle,
              color: HexColor("#575757"),
              size: 30,
            ),
          ),
          Text(
            '${quantity}',
            style: TextStyle(fontSize: 15)
          ),
          IconButton(
            onPressed: (){
              controller.increaseQuantity(cartItem);
            }, 
            icon: Icon(
              Icons.add_circle,
              color: HexColor("#575757"),
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}