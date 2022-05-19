// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../model/usermodel.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class ProductProvider with ChangeNotifier {

//   List<UserModel> userModelList = [];

//   late UserModel userModel;
//   Future<void> getUserData() async {
//     List<UserModel> newList = [];
//     User? currentUser = FirebaseAuth.instance.currentUser;
//     // QuerySnapshot userSnapShot = await FirebaseFirestore.instance.collection("User").get();
//     // userSnapShot.docs.forEach(
//     // for (var element in userSnapShot.docs)  {
//     //     if (currentUser?.uid == element.data().["UserId"]) {
//     //       userModel = UserModel(
//     //         userEmail: element.data()["UserEmail"];
//     //         userName: element.data()["UserName"];
//     //         userPhoneNumber: element.data()["UserPhoneNumber"];
//     //       );
//     //       newList.add(userModel);
//     //     }
//     //     userModelList = newList;
//     //   },
//     // );
//     QuerySnapshot userSnapShot = await FirebaseFirestore.instance.collection("User").get(); 
//     for (var element in userSnapShot.docs) { 
//         if (currentUser?.uid == element.data()["UserId"]) { 
//           userModel = UserModel( 
//             userEmail: element.data()["UserEmail"]; 
//             userGender: element.data()["UserGender"]; 
//             userName: element.data()["UserName"]; 
//             userPhoneNumber: element.data()["UserPhoneNumber"]; 
//           ); 
//           newList.add(userModel); 
//         } 
//         userModelList = newList; 
//       }
//   }

//   List<UserModel> get getUserModelList {
//     return userModelList;
//   }

// }

