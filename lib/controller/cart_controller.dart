import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_bajrai_mini_market/constants/app_constants.dart';
import 'package:e_bajrai_mini_market/controller/user_controller.dart';
import 'package:e_bajrai_mini_market/model/cartmodel.dart';
import 'package:e_bajrai_mini_market/model/usermodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../model/product.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:uuid/uuid.dart';

class CartController extends GetxController {

  static CartController instance = Get.find();
  RxDouble totalCartPrice = 0.0.obs;
  final userController1 = Get.put(UserController());
  UserController userController = UserController.instance;

  @override
  void onReady() {
    super.onReady();
    ever(userController.userModel, changeCartTotalPrice);
  }

  void addProductToCart(Product product) {
    try {
      if (_isItemAlreadyAdded(product)) {
          Get.snackbar(
            "Product Already Added", 
            "Check your cart, this product is already added",
            snackPosition: SnackPosition.BOTTOM,
            duration: Duration(seconds:2),
            backgroundColor: HexColor("#2f3330"),
            colorText: HexColor("#fafafa"),
          );
      } else {
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
    } catch (e) {
      Get.snackbar("Error", "Cannot add this item");
      debugPrint(e.toString());
    }
  }

  void removeCartItem(CartModel cartItem) {
    try {
      userController.updateUserData({
        "cart": FieldValue.arrayRemove([cartItem.toJson()])
      });
    } catch (e) {
      Get.snackbar("Error", "Cannot remove this item");
      debugPrint(e.toString());
    }
  }

  changeCartTotalPrice(UserModel userModel) {
    totalCartPrice.value = 0.0;
    if (userModel.cart.isNotEmpty) {
      userModel.cart.forEach((cartItem) {
        totalCartPrice.value += cartItem.cost;
      });
    }
  }

  bool _isItemAlreadyAdded(Product product) =>
      userController.userModel.value.cart
          .where((item) => item.name == product.name)
          .isNotEmpty;

  void decreaseQuantity(CartModel item){
    if(item.quantity == 1){
      removeCartItem(item);
    }else{
      removeCartItem(item);
      item.quantity--;
      userController.updateUserData({
        "cart": FieldValue.arrayUnion([item.toJson()])
      });
    }
  }

    void increaseQuantity(CartModel item){
      removeCartItem(item);
      item.quantity++;
      logger.i({"quantity": item.quantity});
      userController.updateUserData({
        "cart": FieldValue.arrayUnion([item.toJson()])
      });
  }
}