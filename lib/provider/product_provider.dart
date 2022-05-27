// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:e_bajrai_mini_market/model/cartmodel.dart';
// import 'package:e_bajrai_mini_market/model/product.dart';
// import 'package:e_bajrai_mini_market/model/usermodel.dart';
// import 'package:e_bajrai_mini_market/widgets/singleproduct.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class ProductProvider with ChangeNotifier {
//   List<Product> feature = [];
//   late Product featureData;

// //   List<CartModel> checkOutModelList = [];
// //   late CartModel checkOutModel;

// //   List<CartModel> cartModelList = [];
// //   late CartModel cartModel;

// //   void getCartData({
// //     required String name,
// //     required String image,
// //     required int quantity,
// //     required double price,
// //   }) {
// //     cartModel = CartModel(
// //         price: price,
// //         name: name,
// //         image: image,
// //         quantity: quantity);
// //     cartModelList.add(cartModel);
// //   }

// //   List<CartModel> get getCartModelList {
// //     return List.from(cartModelList);
// //   }

// //   int get getCartModelListLength {
// //     return cartModelList.length;
// //   }

// //   List<UserModel> userModelList = [];
// //   late UserModel userModel;
// //   Future<void> getUserData() async {
// //     List<UserModel> newList = [];
// //     User? currentUser = FirebaseAuth.instance.currentUser;

// //     FirebaseFirestore.instance
// //     .collection("User")
// //     .get()
// //     .then((QuerySnapshot querySnapshot) {
// //         querySnapshot.docs.forEach((doc) {
// //             if (currentUser?.uid == doc["UserId"]) {
// //               userModel = UserModel(
// //                   userAddress: doc["UserAddress"],
// //                   userImage: doc["UserImage"],
// //                   userEmail: doc["UserEmail"],
// //                   userName: doc["UserName"],
// //                   userPhoneNumber: doc["UserNumber"]);
// //               newList.add(userModel);
// //             }
// //             userModelList = newList;
// //         });
// //     });
// //     // QuerySnapshot userSnapShot =
// //     //     await FirebaseFirestore.instance.collection("User").get();
// //     // userSnapShot.docs.forEach(
// //     //   (element) {
// //     //     if (currentUser?.uid == element.data()["UserId"]) {
// //     //       userModel = UserModel(
// //     //           userAddress: element.data()["UserAddress"],
// //     //           userImage: element.data()["UserImage"],
// //     //           userEmail: element.data()["UserEmail"],
// //     //           userName: element.data()["UserName"],
// //     //           userPhoneNumber: element.data()["UserNumber"]);
// //     //       newList.add(userModel);
// //     //     }
// //     //     userModelList = newList;
// //     //   },
// //     // );
// //   }

// //   List<UserModel> get getUserModelList {
// //     return userModelList;
// //   }

// //   void deleteCheckoutProduct(int index) {
// //     checkOutModelList.removeAt(index);
// //     notifyListeners();
// //   }

// //   void clearCheckoutProduct() {
// //     checkOutModelList.clear();
// //     notifyListeners();
// //   }

// //   void getCheckOutData({
// //     required int quantity,
// //     required double price,
// //     required String name,
// //     required String color,
// //     required String size,
// //     required String image,
// //   }) {
// //     checkOutModel = CartModel(
// //       price: price,
// //       name: name,
// //       image: image,
// //       quantity: quantity,
// //     );
// //     checkOutModelList.add(checkOutModel);
// //   }

// //   List<CartModel> get getCheckOutModelList {
// //     return List.from(checkOutModelList);
// //   }

// //   int get getCheckOutModelListLength {
// //     return checkOutModelList.length;
// //   }

// //   Future<void> getFeatureData() async {
// //     List<Product> newList = [];

// //     FirebaseFirestore.instance
// //     .collection("products")
// //     .get()
// //     .then((QuerySnapshot querySnapshot) {
// //         querySnapshot.docs.forEach((doc) {
// //           featureData = Product(
// //             image: doc["image"],
// //             name: doc["name"],
// //             price: doc["price"],
// //             categoryID: doc["categoryID"],
// //             description: doc["description"],
// //             packing: doc["packing"],
// //             quantity: doc["quantity"],
// //           );
// //           newList.add(featureData);
// //         });
// //     });
// //   }

// //   List<Product> get getFeatureList {
// //     return feature;
// //   }

// //   List<Product> homeFeature = [];

// //   // Future<void> getHomeFeatureData() async {
// //   //   List<Product> newList = [];
// //   //   QuerySnapshot featureSnapShot =
// //   //       await FirebaseFirestore.instance.collection("homefeature").get();
// //   //   featureSnapShot.docs.forEach(
// //   //     (element) {
// //   //       featureData = Product(
// //   //         image: element.data()["image"],
// //   //         name: element.data()["name"],
// //   //         price: element.data()["price"],
// //   //         categoryID: element.data()["categoryID"],
// //   //         description: element.data()["description"],
// //   //         packing: element.data()["packing"],
// //   //         quantity: element.data()["quantity"],
// //   //       );
// //   //       newList.add(featureData);
// //   //     },
// //   //   );
// //   //   homeFeature = newList;
// //   //   notifyListeners();
// //   // }

// //   List<Product> get getHomeFeatureList {
// //     return homeFeature;
// //   }

// //   List<Product> homeAchive = [];

// //   // Future<void> getHomeAchiveData() async {
// //   //   List<Product> newList = [];
// //   //   QuerySnapshot featureSnapShot =
// //   //       await FirebaseFirestore.instance.collection("homeachive").get();
// //   //   featureSnapShot.docs.forEach(
// //   //     (element) {
// //   //       featureData = Product(
// //   //         image: element.data()["image"],
// //   //         name: element.data()["name"],
// //   //         price: element.data()["price"],
// //   //         categoryID: element.data()["categoryID"],
// //   //         description: element.data()["description"],
// //   //         packing: element.data()["packing"],
// //   //         quantity: element.data()["quantity"],
// //   //       );
// //   //       newList.add(featureData);
// //   //     },
// //   //   );
// //   //   homeAchive = newList;
// //   //   notifyListeners();
// //   // }

// //   List<Product> get getHomeAchiveList {
// //     return homeAchive;
// //   }

// //   List<Product> newAchives = [];
// //   late Product newAchivesData;
// //   // Future<void> getNewAchiveData() async {
// //   //   List<Product> newList = [];
// //   //   QuerySnapshot achivesSnapShot = await FirebaseFirestore.instance
// //   //       .collection("products")
// //   //       .doc("hfPmMokn0tbAuGZvRMy1")
// //   //       .collection("newachives")
// //   //       .get();
// //   //   achivesSnapShot.docs.forEach(
// //   //     (element) {
// //   //       newAchivesData = Product(
// //   //         image: element.data()["image"],
// //   //         name: element.data()["name"],
// //   //         price: element.data()["price"],
// //   //         categoryID: element.data()["categoryID"],
// //   //         description: element.data()["description"],
// //   //         packing: element.data()["packing"],
// //   //         quantity: element.data()["quantity"],
// //   //       );
// //   //       newList.add(newAchivesData);
// //   //     },
// //   //   );
// //   //   newAchives = newList;
// //   //   notifyListeners();
// //   // }

// //   List<Product> get getNewAchiesList {
// //     return newAchives;
// //   }

// //   List<String> notificationList = [];

// //   void addNotification(String notification) {
// //     notificationList.add(notification);
// //   }

// //   int get getNotificationIndex {
// //     return notificationList.length;
// //   }

// //   get getNotificationList {
// //     return notificationList;
// //   }

// //   late List<Product> searchList;
// //   void getSearchList({required List<Product> list}) {
// //     searchList = list;
// //   }

// //   List<Product> searchProductList(String query) {
// //     List<Product> searchShirt = searchList.where((element) {
// //       return element.name.toUpperCase().contains(query) ||
// //           element.name.toLowerCase().contains(query);
// //     }).toList();
// //     return searchShirt;
// //   }

// //   map(SingleProduct Function(dynamic e) param0) {}
// // }
















// // // class ProductProvider with ChangeNotifier {
// // //   List<Product> feature = [];
// // //   late Product featureData;

// // //   Future<void> getFeatureData() async {
// // //     List<Product> newList = [];

// // //     FirebaseFirestore.instance
// // //     .collection("products")
// // //     .get()
// // //     .then((QuerySnapshot querySnapshot) {
// // //         querySnapshot.docs.forEach((doc) {
// // //           featureData = Product(
// // //             image: doc["image"],
// // //             name: doc["name"],
// // //             price: doc["price"],
// // //             categoryID: doc["categoryID"],
// // //             description: doc["description"],
// // //             packing: doc["packing"],
// // //             quantity: doc["quantity"],
// // //           );
// // //           newList.add(featureData);
// // //         });
// // //     });
// // //     feature = newList;
// // //     notifyListeners();
// // //   }

// // //   List<Product> get getFeatureList {
// // //     return feature;
//   }






// //   // List<CartModel> checkOutModelList = [];
// //   // late CartModel checkOutModel;

// //   // List<CartModel> cartModelList = [];
// //   // late CartModel cartModel;

// //   // void getCartData({
// //   //   required String name,
// //   //   required String image,
// //   //   required int quantity,
// //   //   required double price,
// //   // }) {
// //   //   cartModel = CartModel(
// //   //       price: price,
// //   //       name: name,
// //   //       image: image,
// //   //       quantity: quantity);
// //   //   cartModelList.add(cartModel);
// //   // }

// //   // List<CartModel> get getCartModelList {
// //   //   return List.from(cartModelList);
// //   // }

// //   // int get getCartModelListLength {
// //   //   return cartModelList.length;
// //   // }

// //   // List<UserModel> userModelList = [];
// //   // late UserModel userModel;
// //   // Future<void> getUserData() async {
// //   //   List<UserModel> newList = [];
// //   //   User? currentUser = FirebaseAuth.instance.currentUser;

// //   //   FirebaseFirestore.instance
// //   //   .collection("User")
// //   //   .get()
// //   //   .then((QuerySnapshot querySnapshot) {
// //   //       querySnapshot.docs.forEach((doc) {
// //   //           if (currentUser?.uid == doc["UserId"]) {
// //   //             userModel = UserModel(
// //   //                 userAddress: doc["UserAddress"],
// //   //                 userImage: doc["UserImage"],
// //   //                 userEmail: doc["UserEmail"],
// //   //                 userName: doc["UserName"],
// //   //                 userPhoneNumber: doc["UserNumber"]);
// //   //             newList.add(userModel);
// //   //           }
// //   //           userModelList = newList;
// //   //       });
// //   //   });
// //   //   // QuerySnapshot userSnapShot =
// //   //   //     await FirebaseFirestore.instance.collection("User").get();
// //   //   // userSnapShot.docs.forEach(
// //   //   //   (element) {
// //   //   //     if (currentUser?.uid == element.data()["UserId"]) {
// //   //   //       userModel = UserModel(
// //   //   //           userAddress: element.data()["UserAddress"],
// //   //   //           userImage: element.data()["UserImage"],
// //   //   //           userEmail: element.data()["UserEmail"],
// //   //   //           userName: element.data()["UserName"],
// //   //   //           userPhoneNumber: element.data()["UserNumber"]);
// //   //   //       newList.add(userModel);
// //   //   //     }
// //   //   //     userModelList = newList;
// //   //   //   },
// //   //   // );
// //   // }

// //   // List<UserModel> get getUserModelList {
// //   //   return userModelList;
// //   // }

// //   // void deleteCheckoutProduct(int index) {
// //   //   checkOutModelList.removeAt(index);
// //   //   notifyListeners();
// //   // }

// //   // void clearCheckoutProduct() {
// //   //   checkOutModelList.clear();
// //   //   notifyListeners();
// //   // }

// //   // void getCheckOutData({
// //   //   required int quantity,
// //   //   required double price,
// //   //   required String name,
// //   //   required String color,
// //   //   required String size,
// //   //   required String image,
// //   // }) {
// //   //   checkOutModel = CartModel(
// //   //     price: price,
// //   //     name: name,
// //   //     image: image,
// //   //     quantity: quantity,
// //   //   );
// //   //   checkOutModelList.add(checkOutModel);
// //   // }

// //   // List<CartModel> get getCheckOutModelList {
// //   //   return List.from(checkOutModelList);
// //   // }

// //   // int get getCheckOutModelListLength {
// //   //   return checkOutModelList.length;
// //   // }


// //   // List<Product> homeFeature = [];



// //   // List<Product> get getHomeFeatureList {
// //   //   return homeFeature;
// //   // }

// //   // // List<Product> homeAchive = [];

// //   // // Future<void> getHomeAchiveData() async {
// //   // //   List<Product> newList = [];
// //   // //   QuerySnapshot featureSnapShot =
// //   // //       await FirebaseFirestore.instance.collection("homeachive").get();
// //   // //   featureSnapShot.docs.forEach(
// //   // //     (element) {
// //   // //       featureData = Product(
// //   // //         image: element.data()["image"],
// //   // //         name: element.data()["name"],
// //   // //         price: element.data()["price"],
// //   // //         categoryID: element.data()["categoryID"],
// //   // //         description: element.data()["description"],
// //   // //         packing: element.data()["packing"],
// //   // //         quantity: element.data()["quantity"],
// //   // //       );
// //   // //       newList.add(featureData);
// //   // //     },
// //   // //   );
// //   // //   homeAchive = newList;
// //   // //   notifyListeners();
// //   // // }

// //   // // List<Product> get getHomeAchiveList {
// //   // //   return homeAchive;
// //   // // }

// //   // // List<Product> newAchives = [];
// //   // // late Product newAchivesData;
// //   // // Future<void> getNewAchiveData() async {
// //   // //   List<Product> newList = [];
// //   // //   QuerySnapshot achivesSnapShot = await FirebaseFirestore.instance
// //   // //       .collection("products")
// //   // //       .doc("hfPmMokn0tbAuGZvRMy1")
// //   // //       .collection("newachives")
// //   // //       .get();
// //   // //   achivesSnapShot.docs.forEach(
// //   // //     (element) {
// //   // //       newAchivesData = Product(
// //   // //         image: element.data()["image"],
// //   // //         name: element.data()["name"],
// //   // //         price: element.data()["price"],
// //   // //         categoryID: element.data()["categoryID"],
// //   // //         description: element.data()["description"],
// //   // //         packing: element.data()["packing"],
// //   // //         quantity: element.data()["quantity"],
// //   // //       );
// //   // //       newList.add(newAchivesData);
// //   // //     },
// //   // //   );
// //   // //   newAchives = newList;
// //   // //   notifyListeners();
// //   // // }

// //   // // List<Product> get getNewAchiesList {
// //   // //   return newAchives;
// //   // // }

// //   // List<String> notificationList = [];

// //   // void addNotification(String notification) {
// //   //   notificationList.add(notification);
// //   // }

// //   // int get getNotificationIndex {
// //   //   return notificationList.length;
// //   // }

// //   // get getNotificationList {
// //   //   return notificationList;
// //   // }

// //   // late List<Product> searchList;
// //   // void getSearchList({required List<Product> list}) {
// //   //   searchList = list;
// //   // }

// //   // List<Product> searchProductList(String query) {
// //   //   List<Product> searchShirt = searchList.where((element) {
// //   //     return element.name.toUpperCase().contains(query) ||
// //   //         element.name.toLowerCase().contains(query);
// //   //   }).toList();
// //   //   return searchShirt;
// //   // }

// //   // map(SingleProduct Function(dynamic e) param0) {}
// // //}
