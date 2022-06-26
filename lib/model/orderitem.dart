import 'package:flutter/material.dart';

class OrderItem {

  static const NAME = "name";
  static const PRICE = "price";
  static const IMAGE = "image";
  static const QUANTITY = "quantity";
  static const COST = "cost";

  late String name;
  late double price;
  late String image;
  late int quantity;
  late double cost;

  OrderItem({
    required this.name,
    required this.price,
    required this.image,
    required this.quantity,
    required this.cost,
  });

  OrderItem.fromMap(Map<String, dynamic> data){
    name = data[NAME];
    price = data[PRICE];
    image = data[IMAGE];
    quantity = data[QUANTITY];
    cost = data[COST];
  }

  Map toJson() => {
    NAME: name,
    PRICE: price,
    QUANTITY: quantity,
    IMAGE: image,
    COST: price * quantity,
  };
}
