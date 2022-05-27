import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Product {
  final String name;
  final String description;
  final double price;
  final int quantity;
  final String image;
  final String categoryID;
  final String packing;

  Product({required this.name, required this.description, required this.price, required this.quantity, required this.image, required this.categoryID, required this.packing});

  static Product fromSnapshot(DocumentSnapshot snap) {
    Product product = Product(
      name: snap['name'],
      description: snap['description'],
      price: snap['price'],
      quantity: snap['quantity'],
      image: snap['image'],
      categoryID: snap['categoryID'],
      packing: snap['packing'],
    );
    return product;
  }
}