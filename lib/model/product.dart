import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String name;
  final String description;
  double price;
  int quantity;
  final String image;
  final String categoryID;
  final String packing;

  Product({required this.name, required this.description, this.price = 0, this.quantity = 0, required this.image, required this.categoryID, required this.packing});

  @override
  List<Object> get props {
    return [name, description, price, quantity, image, categoryID, packing];
  }

  Product copyWith({
    String? name,
    String? description,
    double? price,
    int? quantity,
    String? image,
    String? categoryID,
    String? packing,
  }) {
    return Product(
      name: name ?? this.name, 
      description: description ?? this.description, 
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      image: image ?? this.image, 
      categoryID: categoryID ?? this.categoryID, 
      packing: packing ?? this.packing,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name, 
      'description': description, 
      'price': price, 
      'quantity': quantity, 
      'image': image,
      'categoryID': categoryID, 
      'packing': packing,
    };
  }

  factory Product.fromSnapshotMap(DocumentSnapshot snap) {
    return Product(
      name: snap['name'], 
      description: snap['description'], 
      price: snap['price'],
      quantity: snap['quantity'],
      image: snap['image'], 
      categoryID: snap['categoryID'], 
      packing: snap['packing'],
    );
  }

  String toJson() => json.encode(toMap());

  @override
  bool get stringify => true;

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