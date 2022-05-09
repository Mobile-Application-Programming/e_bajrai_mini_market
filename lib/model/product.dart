import 'package:flutter/material.dart';

class Product {
  final String name;
  final String description;
  final double price;
  final int quantity;
  final String image;
  final int categoryID;
  final String packing;

  Product({required this.name, required this.description, required this.price, required this.quantity, required this.image, required this.categoryID, required this.packing});
}