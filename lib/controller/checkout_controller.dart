import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_bajrai_mini_market/controller/cart_controller.dart';
import 'package:e_bajrai_mini_market/controller/user_controller.dart';
import 'package:e_bajrai_mini_market/model/ordermodel.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

class CheckoutController extends GetxController {

  static CheckoutController instance = Get.find();
  final userController1 = Get.put(UserController());
  UserController userController = UserController.instance;
  final cartController = Get.put(CartController());
  final CartController controller = Get.find();

  void addOrder() {

    String orderId = Uuid().v1();
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');

    FirebaseFirestore.instance.collection("orders").doc(orderId).set(OrderModel(
      orderID: orderId, 
      orderDate: formatter.format(now),
      userEmail: userController.userModel.value.userEmail, 
      userName: userController.userModel.value.userName, 
      userPhoneNumber: userController.userModel.value.userPhoneNumber, 
      userAddress: userController.userModel.value.userAddress, 
      totalCost: cartController.totalCartPrice.value, 
      orderItem: [],
    ).toMap());

    for(int index=0; index<userController.userModel.value.cart.length; index++) {

      FirebaseFirestore.instance.collection("orders").doc(orderId).update({
        "orderItem": FieldValue.arrayUnion([
          {
            "name" : userController.userModel.value.cart[index].name,
            "price" : userController.userModel.value.cart[index].price,
            "image" : userController.userModel.value.cart[index].image,
            "quantity" : userController.userModel.value.cart[index].quantity,
            "cost" : userController.userModel.value.cart[index].cost
          }
        ])
      });

      userController.updateUserData({
        "cart": FieldValue.arrayRemove([userController.userModel.value.cart[index].toJson()])
      });

    }
  }
}