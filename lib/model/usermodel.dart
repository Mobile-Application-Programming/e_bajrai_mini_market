import 'package:flutter/material.dart';
class UserModel {
  String userName, userEmail, userPhoneNumber, userGender;
  UserModel ({
    @required this.userEmail,
    @required this.userGender,
    @required this.userName,
    @required this.userPhoneNumber,
  });
}