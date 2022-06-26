import 'package:e_bajrai_mini_market/model/cartmodel.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {

  static const USERNAME = "UserName";
  static const USEREMAIL = "UserEmail";
  static const USERPHONENUMBER = "Phone Number";
  static const USERIMAGE = "userImage";
  static const USERADDRESS = "userAddress";
  static const CART = "cart";

  late String userName, userEmail, userPhoneNumber, userImage, userAddress;
  late List<CartModel> cart;
  
  UserModel({
    required this.userEmail,
    required this.userName,
    required this.userImage,
    required this.userPhoneNumber,
    required this.userAddress,
    required this.cart,
  });

  UserModel.fromSnapshot(DocumentSnapshot snapshot) { 
    
    userEmail = snapshot[USEREMAIL];
    userName = snapshot[USERNAME];
    userImage = snapshot[USERIMAGE];
    userPhoneNumber = snapshot[USERPHONENUMBER];
    userAddress = snapshot[USERADDRESS];
    cart = _convertCartItems(snapshot[CART] ?? []);
  }

  List<CartModel> _convertCartItems(List cartFomDb){
    List<CartModel> _result = [];
    if(cartFomDb.length > 0){
      cartFomDb.forEach((element) {
      _result.add(CartModel.fromMap(element));
    });
    }
    return _result;
  }

  List<Map>? cartItemsToJson() => cart.map((item) => item.toJson()).toList();
}
