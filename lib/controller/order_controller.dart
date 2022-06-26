// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:e_bajrai_mini_market/constants/app_constants.dart';
// import 'package:e_bajrai_mini_market/controller/user_controller.dart';
// import 'package:e_bajrai_mini_market/model/cartmodel.dart';
// import 'package:e_bajrai_mini_market/model/ordermodel.dart';
// import 'package:e_bajrai_mini_market/model/usermodel.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
// import '../model/product.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:uuid/uuid.dart';

// class OrderController extends GetxController {

//   static OrderController instance = Get.find();
//   static Rx<OrderModel> orderModel = OrderModel(orderID: '', orderDate: '', userEmail: '', userName: '', userPhoneNumber: '', userAddress: '', totalCost: 2, orderItem:[]).obs;
//   RxDouble totalRevenue = 0.0.obs; 

//   @override
//   void onReady() {
//     super.onReady();
//     ever(OrderController.orderModel, getTotalRevenue());
//   }

//   getTotalRevenue() async {
//     final productData = FirebaseFirestore.instance.collection('orders');
//       final QuerySnapshot result = await productData.get();

//       result.docs.forEach((res) async {
//         totalRevenue.value += res["totalCost"];
//       });
//   }

//   Future<int> getTotalSales() async {

//     final int totalSales = await FirebaseFirestore.instance.collection('orders').snapshots().length;
//     return 1;
//   }
// }