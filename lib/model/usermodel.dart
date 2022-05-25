import 'package:flutter/material.dart';

class UserModel {
  String userName, userEmail, userPhoneNumber, userImage, userAddress;
  UserModel(
      {required this.userEmail,
      required this.userImage,
      required this.userAddress,
      required this.userName,
      required this.userPhoneNumber});
}
