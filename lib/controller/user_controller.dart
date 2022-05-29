import 'package:e_bajrai_mini_market/constants/app_constants.dart';
import 'package:e_bajrai_mini_market/model/usermodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserController extends GetxController {
  static UserController instance = Get.find();
  //Rx<User> firebaseUser = Rx<User>(auth.currentUser);
  User? firebaseUser = FirebaseAuth.instance.currentUser;
  RxBool isLoggedIn = false.obs;
  String usersCollection = "User";
  Rx<UserModel> userModel = UserModel(userName: 'dia', userAddress: '', userEmail: '', userImage: '', cart: [], userPhoneNumber: '').obs;
  //Rxn<UserModel> userModel = Rxn<UserModel>();
  //final userModel = UserModel().obs;

  setToListen(){
    userModel.bindStream(listenToUser());
  }

  updateUserData(Map<String, dynamic> data) {
    print(firebaseUser!.uid);
    logger.i("UPDATED");
    FirebaseFirestore.instance
        .collection(usersCollection)
        .doc(firebaseUser!.uid)
        .update(data);
  }

  Stream<UserModel> listenToUser() => FirebaseFirestore.instance
      .collection(usersCollection)
      .doc(firebaseUser!.uid)
      .snapshots()
      .map((snapshot) => UserModel.fromSnapshot(snapshot));
}