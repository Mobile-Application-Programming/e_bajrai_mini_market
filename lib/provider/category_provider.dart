// //import 'dart:html';

// import 'package:flutter/material.dart';
// import 'package:e_bajrai_mini_market/model/product.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class CategoryProvider with ChangeNotifier{
  
//   List<Product> fruitVeg=[];
//   late Product fruitVegData;
  
//   get console => null;

  // Future<void> getfruitVegData() async {
  //   List<Product> newList = [];

  //   FirebaseFirestore.instance
  //   .collection("category")
  //   .doc("5b0ccqbprptV116Qd00O")
  //   .collection("fruitVeg")
  //   .get()
  //   .then((QuerySnapshot querySnapshot) {
  //       querySnapshot.docs.forEach((doc) {
          
  //         fruitVegData = Product( 
  //           name: doc["name"],
  //           description: doc["description"],
  //           price: doc["price"],
  //           quantity: doc["quantity"],
  //           image: doc["image"],
  //           categoryID: doc["categoryID"],
  //           packing: doc["packing"],
  //         );
  //         newList.add(fruitVegData);
  //       });
  //       fruitVeg = newList;
  //       notifyListeners();
  //   });
  // }

//   // Future<void> getHomeFeatureData() async {
//   //   List<Product> newList = [];
//   //   QuerySnapshot featureSnapShot =
//   //       await FirebaseFirestore.instance.collection("homefeature").get();
//   //   featureSnapShot.docs.forEach(
//   //     (element) {
//   //       fruitVegData = Product(
//   //         image: document.data()["image"],
//   //         name: element.data()["name"],
//   //         price: element.data()["price"],
//   //         categoryID: element.data()["categoryID"],
//   //         description: element.data()["description"],
//   //         packing: element.data()["packing"],
//   //         quantity: element.data()["quantity"],
//   //       );
//   //       newList.add(fruitVegData);
//   //     },
//   //   );
//   //   fruitVeg = newList;
//   // }

//   List<Product> get getfruitVegList{
//     return fruitVeg;
//   }
// }