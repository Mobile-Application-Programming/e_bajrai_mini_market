import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_bajrai_mini_market/constants/app_constants.dart';
import 'package:e_bajrai_mini_market/controller/user_controller.dart';
import 'package:e_bajrai_mini_market/model/cartmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../model/product.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:uuid/uuid.dart';

class CartController extends GetxController {

  static CartController instance = Get.find();
  final userController1 = Get.put(UserController());
  UserController userController = UserController.instance;
  var _products = {}.obs;

  void addProduct(Product product) {
    if (_products.containsKey(product)) {

        Get.snackbar(
          "Product Already Added", 
          "Check your cart, this product is already added",
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds:2),
          backgroundColor: HexColor("#2f3330"),
          colorText: HexColor("#fafafa"),
        );
    }
    else {
      _products[product] = 1;

      String itemId = Uuid().toString();
      userController.updateUserData({
        "cart": FieldValue.arrayUnion([
          {
            "id": itemId,
            "name" : product.name,
            "price" : product.price,
            "image" : product.image,
            "quantity" : 1,
            "cost" : product.price
          }
        ])
      });

      Get.snackbar(
        "Product Added", 
        "You have added the product to the cart",
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds:2),
        backgroundColor: HexColor("#2f3330"),
        colorText: HexColor("#fafafa"),
      );
    }


  }

  void removeProduct(Product product, CartModel cartItem) {
    if (_products.containsKey(product) && _products[product] == 1) {
      _products.removeWhere((key, value) => key == product);

      userController.updateUserData({
        "cart": FieldValue.arrayRemove([cartItem.toJson()])
      });

      Get.snackbar(
        "Product Removed", 
        "You have removed the product to the cart",
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds:2),
        backgroundColor: HexColor("#2f3330"),
        colorText: HexColor("#fafafa"),
      );
    } else {
      _products[product] -= 1;

      userController.updateUserData({
        "cart": FieldValue.arrayRemove([cartItem.toJson()])
      });
      cartItem.quantity--;
          userController.updateUserData({
        "cart": FieldValue.arrayUnion([cartItem.toJson()])
      });
    }
  }

  void increaseQuantity(Product product, CartModel cartItem) {
    if (_products.containsKey(product)) {
      _products[product] += 1;

      userController.updateUserData({
        "cart": FieldValue.arrayRemove([cartItem.toJson()])
      });
      cartItem.quantity++;
      logger.i({"quantity": cartItem.quantity});
          userController.updateUserData({
        "cart": FieldValue.arrayUnion([cartItem.toJson()])
      });

        Get.snackbar(
          "Product Added", 
          "You have added the quantity of the product to the cart",
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds:2),
          backgroundColor: HexColor("#2f3330"),
          colorText: HexColor("#fafafa"),
        );
    }
  }

  get products => _products;

  get productSubtotal => _products.entries
    .map((product) => product.key.price * product.value)
    .toList();

  get total => _products.entries
    .map((product) => product.key.price * product.value)
    .toList()
    .reduce((value, element) => value + element)
    .toStringAsFixed(2);

}