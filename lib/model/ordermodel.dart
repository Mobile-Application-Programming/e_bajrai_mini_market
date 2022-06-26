import 'package:e_bajrai_mini_market/model/cartmodel.dart';
import 'package:e_bajrai_mini_market/model/orderitem.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {

  static const ORDERID = "OrderID";
  static const ORDERDATE = "OrderDate";
  static const USERNAME = "UserName";
  static const USEREMAIL = "UserEmail";
  static const USERPHONENUMBER = "Phone Number";
  static const USERADDRESS = "userAddress";
  static const TOTALCOST = "totalCost";
  static const ORDERITEM = "orderItem";

  late String orderID, orderDate, userName, userEmail, userPhoneNumber, userAddress;
  late double totalCost;
  late List<OrderItem> orderItem;
  
  OrderModel({
    required this.orderID,
    required this.orderDate,
    required this.userEmail,
    required this.userName,
    required this.userPhoneNumber,
    required this.userAddress,
    required this.totalCost,
    required this.orderItem,
  });

  Map<String, dynamic> toMap() {
    return {
      'orderID': orderID, 
      'orderDate': orderDate, 
      'userEmail': userEmail, 
      'userName': userName, 
      'userPhoneNumber': userPhoneNumber, 
      'userAddress': userAddress,
      'totalCost': totalCost, 
      'orderItem': orderItem,
    };
  }

  OrderModel.fromSnapshot(DocumentSnapshot snapshot) { 
    orderID = snapshot[ORDERID];
    orderDate= snapshot[ORDERDATE];
    userEmail = snapshot[USERNAME];
    userName = snapshot[USEREMAIL];
    userPhoneNumber = snapshot[USERPHONENUMBER];
    userAddress = snapshot[USERADDRESS];
    totalCost = snapshot[TOTALCOST];
    orderItem = _convertOrderItems(snapshot[ORDERITEM] ?? []);
  }

  List<OrderItem> _convertOrderItems(List orderFomDb){
    List<OrderItem> _result = [];
    if(orderFomDb.length > 0){
      orderFomDb.forEach((element) {
      _result.add(OrderItem.fromMap(element));
    });
    }
    return _result;
  }

  List<Map>? orderItemsToJson() => orderItem.map((item) => item.toJson()).toList();
}
