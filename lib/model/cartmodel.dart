import 'package:flutter/material.dart';

class CartModel {

  static const ID = "id";
  static const NAME = "name";
  static const PRICE = "price";
  static const IMAGE = "image";
  static const QUANTITY = "quantity";
  static const COST = "cost";

  late String id;
  late String name;
  late double price;
  late String image;
  late int quantity;
  late double cost;

  CartModel({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.quantity,
    required this.cost,
  });

  CartModel.fromMap(Map<String, dynamic> data){
    id = data[ID];
    name = data[NAME];
    price = data[PRICE];
    image = data[IMAGE];
    quantity = data[QUANTITY];
    cost = data[COST];
  }

  Map toJson() => {
    ID: id,
    NAME: name,
    PRICE: price,
    QUANTITY: quantity,
    IMAGE: image,
    COST: price * quantity,
  };
}
